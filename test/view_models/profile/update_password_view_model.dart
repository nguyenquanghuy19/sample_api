import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class UpdatePasswordViewModel extends BaseViewModel {
  final TextEditingController oldPasswordTextFieldController =
      TextEditingController();
  final TextEditingController newPasswordTextFieldController =
      TextEditingController();
  final TextEditingController confirmPasswordTextFieldController =
      TextEditingController();

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.confirmPasswordRequired;
    }
    if (newPasswordTextFieldController.text != value) {
      return Strings.of(context)!.comparePasswordError;
    }

    return null;
  }

  String? validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.passwordOldRequired;
    }

    return null;
  }
}
