import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/user_model.dart';

import 'base_service.dart';

class AuthService extends BaseService {
  BaseService baseService;

  AuthService({required this.baseService});

  Future<UserModel?> signIn(String email, String password) async {
    final body = '{"email": "$email", "password": "$password"}';

    return await baseService.post(
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

    return await baseService.post(
      ApiEndPointConstants.signup,
      body: body,
      mapper: (json) =>
          DataResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataResponseModel?> onGetNewPassword(String email) async {
    final body = '{"email": "$email"}';

    return await baseService.post(
      ApiEndPointConstants.resetPassword,
      body: body,
      mapper: (json) =>
          DataResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
