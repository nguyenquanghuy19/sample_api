import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:testproject/core/constants/api_end_point.dart';
import 'package:testproject/core/data/models/user_model.dart';
import 'package:testproject/core/data/remote/api/api_exception.dart';
import 'package:testproject/core/data/remote/api/failure.dart';
import 'package:testproject/core/data/share_preference/spref_user_model.dart';
import 'package:testproject/core/utils/log_utils.dart';

import 'app_dio.dart';

class HandleInterceptors extends QueuedInterceptorsWrapper {
  final AppDio appDio;

  HandleInterceptors(this.appDio);

  //TODO header
  Map<String, String> get headers {
    return <String, String>{
      'Accept': '*/*',
    };
  }

  Map<String, String> get authorizedHeaders {
    final String accessToken = SPrefUserModel().getAccessToken() ?? "";

    return headers..putIfAbsent('Authorization', () => "Bearer $accessToken");
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final path = err.requestOptions.path;
    final statusCode = err.response?.statusCode;
    final bodyFailure = err.response?.data?.toString() ?? "";
    LogUtils.d("【API:ERROR/$statusCode】【$path】【$bodyFailure】 $err");
    if (_isNetworkError(err)) {
      LogUtils.d("【interceptor:error】【$path】 network error ...");
      handler.reject(NoInternetException(err.requestOptions, null));

      return;
    }
    if (_isTimeoutException(err)) {
      LogUtils.d("【interceptor:error】【$path】 timeout error ...");
      // Retry api
      handler.reject(AppTimeOutException(
        err.requestOptions,
        Failure(errorCode: 500, message: "Error internet"),
      ));
    }
    Failure? failure;
    try {
      dynamic responseJson = jsonDecode(bodyFailure == "" ? "{}" : bodyFailure);
      failure = Failure.fromJson(
        responseJson as Map<String, dynamic>,
      );
    } on Exception {
      failure = Failure(message: bodyFailure, errorCode: statusCode);
    }
    if (statusCode != null) {
      switch (statusCode) {
        case 400:
          handler.reject(BadRequestException(err.requestOptions, failure));
          break;
        case 401:
          //TODO retry login
          if (path ==
              appDio.processUri(url: ApiEndPointConstants.signIn).toString()) {
            /// Because API called don't need retry
            LogUtils.d("[$path] throws UnauthorisedException...");
            handler.reject(UnauthorisedException(err.requestOptions, failure));

            return;
          }
          await _processRefreshToken(err, handler);
          break;
        case 403:
          handler.reject(ForbiddenException(err.requestOptions, failure));
          break;
        case 500:
          handler.reject(FetchDataException(err.requestOptions, failure));
          break;
        case 504:
          handler.reject(ServerTimeOutException(err.requestOptions, failure));
          break;
        case 503:
          handler
              .reject(ServerUnavailableException(err.requestOptions, failure));
          break;
        default:
          handler.next(err);
          break;
      }
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogUtils.d("onRequest -> [options.path] => ${options.path}");
    options.headers = authorizedHeaders;
    super.onRequest(options, handler);
  }

  Future<void> _processRefreshToken(
    DioError err,
    ErrorInterceptorHandler handler, {
    int retryCount = 1,
  }) async {
    LogUtils.d("【retryCount】 => $retryCount");

    /// Others API handlers ...
    /// API Response(401:UnAuthorized) 送信
    LogUtils.d("【_processRefreshToken:retry】");
    RequestOptions requestOptions = err.response!.requestOptions;

    /// ログイン処理 Request送信
    await _refreshAccessToken().then((newUser) async {
      /// [200:OK]
      /// ログイン処理 Response送信
      /// accessToken取得
      /// 登録結果

      if (newUser != null) {
        SPrefUserModel().setAccessToken(newUser.accessToken);
        SPrefUserModel().setRefreshToken(newUser.refreshToken);
        SPrefUserModel().setExpiration(newUser.expiration);
        SPrefUserModel().setExpires(newUser.expires);
      }
      LogUtils.d(
        "【interceptor:retry】【${err.requestOptions.uri.path}】[$retryCount] has new token",
      );
      // Repeat call api ...
      await appDio.fetch<dynamic>(requestOptions).then((r) {
        handler.resolve(r);
      }).onError<DioError>((error, stackTrace) {
        handler.reject(error);
      });
    }).onError<DioError>((errorRefreshToken, stackTrace) async {
      LogUtils.d(
        "【interceptor:refresh_token:error】【${err.requestOptions.uri.path}】[$retryCount] refresh token has error $errorRefreshToken",
      );
      // 400が返却された場合、エラーダイアログ①「異常が発生しています」というダイアログを表示する
      if (errorRefreshToken.response != null &&
          errorRefreshToken.response!.statusCode == 400) {
        SPrefUserModel().clear();
        handler.reject(
          RefreshTokenBadRequestException(
            errorRefreshToken.requestOptions,
            Failure(
              message: errorRefreshToken.response!.data,
              errorCode: errorRefreshToken.response!.statusCode,
            ),
          ),
        );

        // TODO refreshtoken
        // Constants.navigatorKey.currentState?.pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => SignInView(
        //       canBack: false,
        //       showExpirationToken: true,
        //       callBack: () {
        //         Constants.navigatorKey.currentState?.push(
        //           MaterialPageRoute<void>(
        //             builder: (context) {
        //               return const MainViewAfterSignIn();
        //             },
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // );

        return;
      } else if (errorRefreshToken is UnauthorisedException) {
        if (retryCount > 1) {
          handler.reject(errorRefreshToken);

          return;
        } else {
          /// 401 refreshToken
          await _processRefreshToken(err, handler, retryCount: 2);

          return;
        }
      } else {
        handler.reject(errorRefreshToken);

        return;
      }
    });
  }

  Future<UserModel?> _refreshAccessToken() async {
    var dio = Dio();
    final String? accessToken = SPrefUserModel().getAccessToken();
    final String? refreshToken = SPrefUserModel().getRefreshToken();
    Uri uri =
        appDio.processUri(url: ApiEndPointConstants.refreshToken, param: null);
    final body = {"accessToken": accessToken, "refreshToken": refreshToken};
    LogUtils.d(
      '[$runtimeType][REQUEST:POST][REFRESH_TOKEN] API:【${uri.path}】 body:$body',
    );

    return dio
        .postUri<String>(
          uri,
          data: body,
        )
        .then((response) => UserModel.fromJson(appDio.convertResponseToObject(
              response,
              runtimeType.toString(),
              uri.path,
            ) as Map<String, dynamic>));
  }

  bool _isNetworkError(DioError err) {
    return err.error != null &&
        (err.error is SocketException || err.error is HttpException);
  }

  bool _isTimeoutException(DioError err) {
    return err.type == DioErrorType.sendTimeout ||
        err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.receiveTimeout;
  }
}
