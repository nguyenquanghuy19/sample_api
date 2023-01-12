import 'package:elearning/core/data/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../core/data/repositories/auth_repository_test.dart';
import '../base_view_model.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  SignUpViewModel({required this.authRepository});

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
  }

  Future<DataResponseModel?> onSignUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      return await authRepository.signUp(email, password, confirmPassword);
    } on Exception {
      rethrow;
    }
  }
}
