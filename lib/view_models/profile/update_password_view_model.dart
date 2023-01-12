import 'package:elearning/core/data/remote/api/api_exception.dart';
import 'package:elearning/core/data/repositories/account_repository.dart';
import 'package:elearning/core/data/share_preference/spref_user_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/ui/views/auth/sign_in_view.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class UpdatePasswordViewModel extends BaseViewModel {
  final AccountRepository _accountRepository = AccountRepository();

  final TextEditingController oldPasswordTextFieldController =
      TextEditingController();
  final TextEditingController newPasswordTextFieldController =
      TextEditingController();
  final TextEditingController confirmPasswordTextFieldController =
      TextEditingController();

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
    LogUtils.d("[$runtimeType][INIT] => UpdatePasswordViewModel");
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.confirmPasswordRequired;
    }
    if (newPasswordTextFieldController.text != value) {
      return Strings.of(context)!.comparePasswordError;
    }

    return null;
  }

  Future<void> onPressUpdatePassword() async {
    try {
      _inProgress = true;
      updateUI();
      final res = await _accountRepository.updatePassword(
        oldPasswordTextFieldController.text,
        newPasswordTextFieldController.text,
        confirmPasswordTextFieldController.text,
      );
      _inProgress = false;
      updateUI();
      if (res != null && res.status != null && res.status!) {
        SPrefUserModel().removeDataUser(SPrefUserModel.accessTokenKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.refreshTokenKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.expirationKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.expiresKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.rememberMeKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.emailKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.passwordKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.isSignInKey);
        hideCurrentSnackBar();
        showToastSuccess(res.message);
        removeNotifier();
        _onOpenSignInScreen();
      } else {
        hideCurrentSnackBar();
        showToastError(res?.message);
      }
    } on ApiException catch (e) {
      _inProgress = false;
      updateUI();
      LogUtils.d("[$runtimeType][API_ERROR] => $e");
      hideCurrentSnackBar();
      showToastError(
        e.failure?.message ?? Strings.of(context)!.anErrorHasOccurred,
      );
    } on Exception catch (e) {
      _inProgress = false;
      updateUI();
      hideCurrentSnackBar();
      LogUtils.d("[$runtimeType][HANDLER_ERROR] => $e");
      showToastError(Strings.of(context)!.anErrorHasOccurred);
    }
  }

  String? validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.passwordOldRequired;
    }

    return null;
  }

  void _onOpenSignInScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) {
          return const SignInView(
            canBack: false,
          );
        },
      ),
    );
  }

  void hideCurrentSnackBar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
