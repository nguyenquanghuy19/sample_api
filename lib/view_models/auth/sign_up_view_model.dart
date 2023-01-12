import 'package:elearning/core/data/remote/api/api_exception.dart';
import 'package:elearning/core/data/repositories/auth_repository.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/check_validate_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthRepository _authRepository = AuthRepository();

  final TextEditingController emailTextFieldController =
      TextEditingController();
  final TextEditingController passwordTextFieldController =
      TextEditingController();
  final TextEditingController confirmPasswordTextFieldController =
      TextEditingController();

  bool _isCheckAgreeTermsAndConditions = false;

  bool get isCheckAgreeTermsAndConditions => _isCheckAgreeTermsAndConditions;

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  void checkedAgreeTermsAndConditions(bool? isChecked) {
    _isCheckAgreeTermsAndConditions = isChecked!;
    updateUI();
  }

  Future<void> onPressSignUp() async {
    if (!_isCheckAgreeTermsAndConditions) {
      _showToastNotAgreeTermsAndConditions();

      return;
    }
    try {
      _inProgress = true;
      updateUI();
      final res = await _authRepository.signUp(
        emailTextFieldController.text,
        passwordTextFieldController.text,
        confirmPasswordTextFieldController.text,
      );
      _inProgress = false;
      updateUI();
      if (res != null && res.status != null && res.status!) {
        hideCurrentSnackBar();
        showToastSuccess(res.message);
        _backToLoginView();
      } else if (res != null && res.status != null && !res.status!) {
        hideCurrentSnackBar();
        showToastError(res.message);
      }
    } on ApiException catch (e) {
      _inProgress = false;
      updateUI();
      hideCurrentSnackBar();
      showToastError(
        e.failure?.message ?? Strings.of(context)!.anErrorHasOccurred,
      );
    } on Exception {
      _inProgress = false;
      updateUI();
      hideCurrentSnackBar();
      showToastError(
        Strings.of(context)!.anErrorHasOccurred,
      );
    }
  }

  void _showToastNotAgreeTermsAndConditions() {
    showToastError(Strings.of(context)!.checkAgreeTermsAndConditions);
  }

  void hideCurrentSnackBar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.confirmPasswordRequired;
    }
    if (passwordTextFieldController.text != value) {
      return Strings.of(context)!.comparePasswordError;
    }
    if (passwordTextFieldController.text == value) {
      return CheckValidateUtils.validatePassword(value, context);
    }

    return null;
  }

  void _backToLoginView() {
    Navigator.of(context).pop();
  }
}
