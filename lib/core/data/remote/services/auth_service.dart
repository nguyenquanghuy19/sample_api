import 'package:testproject/core/constants/api_end_point.dart';
import 'package:testproject/core/data/models/user_model.dart';
import 'package:testproject/core/data/remote/services/base_service.dart';

class AuthService extends BaseService {
  Future<UserModel?> signUp(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    final body =
        '{"firstName": "$firstName","lastName": "$lastName","email": "$email", "password": "$password"}';

    return await post(
      ApiEndPointConstants.signup,
      body: body,
      mapper: (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
