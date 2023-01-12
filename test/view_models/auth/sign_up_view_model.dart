import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel {
  final TextEditingController emailTextFieldController =
      TextEditingController();
  final TextEditingController passwordTextFieldController =
      TextEditingController();
  final TextEditingController confirmPasswordTextFieldController =
      TextEditingController();

  bool _isCheckAgreeTermsAndConditions = false;

  bool get isCheckAgreeTermsAndConditions => _isCheckAgreeTermsAndConditions;

  void checkedAgreeTermsAndConditions(bool? isChecked) {
    _isCheckAgreeTermsAndConditions = isChecked!;
    updateUI();
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.confirmPasswordRequired;
    }
    if (passwordTextFieldController.text != value) {
      return Strings.of(context)!.comparePasswordError;
    }

    return null;
  }
}
