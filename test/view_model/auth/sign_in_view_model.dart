import 'package:elearning/core/data/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../core/data/repositories/auth_repository_test.dart';
import '../base_view_model.dart';

class SignInViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  SignInViewModel({required this.authRepository});

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
  }

  Future<UserModel?> onSignIn({
    required String email,
    required String password,
  }) async {
    try {
      return await authRepository.signIn(email, password);
    } on Exception {
      rethrow;
    }
  }
}
