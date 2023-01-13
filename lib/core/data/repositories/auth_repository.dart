import 'package:testproject/core/data/models/user_model.dart';
import 'package:testproject/core/data/remote/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<UserModel?> signUp(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      return await _authService.signUp(firstName, lastName, email, password);
    } on Exception {
      rethrow;
    }
  }
}
