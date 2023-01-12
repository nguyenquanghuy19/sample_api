import 'package:elearning/core/data/remote/api/api_exception.dart';
import 'package:elearning/core/data/repositories/auth_repository.dart';
import 'package:elearning/core/data/share_preference/spref_user_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/views/auth/sign_in_view.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final AuthRepository _authRepository = AuthRepository();

  TextEditingController emailController = TextEditingController();

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<void> onGetNewPassword() async {
    try {
      _inProgress = true;
      updateUI();
      final res = await _authRepository.onGetNewPassword(emailController.text);
      _inProgress = false;
      updateUI();
      if (res != null && res.status != null && res.status!) {
        hideCurrentSnackBar();
        showToastSuccess(res.message);
        SPrefUserModel().removeDataUser(SPrefUserModel.accessTokenKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.refreshTokenKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.expirationKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.expiresKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.rememberMeKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.emailKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.passwordKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.isSignInKey);
        _onOpenSignInScreen();
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
    notifyListeners();
  }

  void _onOpenSignInScreen() {
    Navigator.push(
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

  void hideCurrentSnackBar(){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
