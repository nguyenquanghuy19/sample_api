import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';

class AuthService extends BaseService {
  Future<UserModel?> signIn(String email, String password) async {
    final body = '{"email": "$email", "password": "$password"}';

    return await post(
      ApiEndPointConstants.signIn,
      body: body,
      mapper: (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataResponseModel?> signUp(
    String email,
    String password,
    String confirmPassword,
  ) async {
    final body =
        '{"email": "$email", "password": "$password", "passwordConfirmation": "$confirmPassword"}';

    return await post(
      ApiEndPointConstants.signup,
      body: body,
      mapper: (json) =>
          DataResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataResponseModel?> onGetNewPassword(String email) async {
    final body = '{"email": "$email"}';

    return await post(
      ApiEndPointConstants.resetPassword,
      body: body,
      mapper: (json) =>
          DataResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<UserModel?> refreshToken(
    String accessToken,
    String refreshToken,
  ) async {
    final body =
        '{"accessToken": "$accessToken", "refreshToken": "$refreshToken"}';

    return await post(
      ApiEndPointConstants.refreshToken,
      body: body,
      mapper: (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
