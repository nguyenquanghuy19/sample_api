import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:testproject/core/constants/api_end_point.dart';
import 'package:testproject/core/data/remote/api/api_exception.dart';
import 'package:testproject/core/data/remote/api/failure.dart';
import 'package:testproject/core/data/share_preference/spref_user_model.dart';
import 'package:testproject/core/utils/log_utils.dart';

import 'app_dio.dart';

class HandleInterceptors extends QueuedInterceptorsWrapper {
  final AppDio appDio;

  HandleInterceptors(this.appDio);

  Map<String, String> get headers {
    return <String, String>{};
  }

  Map<String, String> get authorizedHeaders {
    String? accessToken = SPrefUserModel().getAccessToken() ?? "";

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
    options.headers = options.path ==
            appDio.processUri(url: ApiEndPointConstants.signup).toString()
        ? headers
        : authorizedHeaders;
    LogUtils.d("onRequest -> [options.path] => ${options.path}");
    super.onRequest(options, handler);
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
