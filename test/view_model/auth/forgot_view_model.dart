import 'package:elearning/core/data/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../core/data/repositories/auth_repository_test.dart';
import '../base_view_model.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final AuthRepository authRepository;

  ForgotPasswordViewModel({required this.authRepository});

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
  }

  Future<DataResponseModel?> onForgotPassword({required String email}) async {
    try {
      return await authRepository.onGetNewPassword(email);
    } on Exception {
      rethrow;
    }
  }
}
