import 'package:elearning/core/data/models/user_model.dart';
import 'package:elearning/core/data/remote/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<UserModel?> signIn(String email, String password) async {
    try {
      return await _authService.signIn(email, password);
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
      return await _authService.signUp(email, password, confirmPassword);
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> onGetNewPassword(String email) async {
    try {
      return await _authService.onGetNewPassword(email);
    } on Exception {
      rethrow;
    }
  }

  Future<UserModel?> refreshToken(String accessToken, String refreshToken) async {
    try {
      return await _authService.refreshToken(accessToken, refreshToken);
    } on Exception {
      rethrow;
    }
  }
}
