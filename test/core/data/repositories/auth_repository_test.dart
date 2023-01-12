import 'package:elearning/core/data/models/user_model.dart';
import '../remote/services/auth_service_test.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future<UserModel?> signIn(String email, String password) async {
    try {
      return await authService.signIn(email, password);
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> signUp(
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      return await authService.signUp(email, password, confirmPassword);
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> onGetNewPassword(String email) async {
    try {
      return await authService.onGetNewPassword(email);
    } on Exception {
      rethrow;
    }
  }
}
