import 'package:elearning/core/data/remote/api/api_exception.dart';
import 'package:elearning/core/data/repositories/auth_repository.dart';
import 'package:elearning/core/data/share_preference/spref_user_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class SignInViewModel extends BaseViewModel {
  final AuthRepository _authRepository = AuthRepository();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isCheckRememberMe = false;

  bool get isCheckRememberMe => _isCheckRememberMe;

  bool _inProgress = false;

  bool get inProgress => _inProgress;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    inItData();
    LogUtils.d("[$runtimeType][LOGIN_VIEW_MODEL] => INIT");
  }

  void checkedRememberMe(bool? isChecked) {
    _isCheckRememberMe = isChecked!;
    updateUI();
  }

  Future<bool> onSignIn() async {
    try {
      _inProgress = true;
      updateUI();
      final res = await _authRepository.signIn(
        emailController.text,
        passwordController.text,
      );
      _inProgress = false;
      updateUI();
      SPrefUserModel().setRemember(_isCheckRememberMe);
      if (res != null) {
        SPrefUserModel().setAccessToken(res.accessToken);
        SPrefUserModel().setRefreshToken(res.refreshToken);
        SPrefUserModel().setExpiration(res.expiration);
        SPrefUserModel().setExpires(res.expires);
        if (SPrefUserModel().getRemember() ?? false) {
          SPrefUserModel().setEmail(emailController.text);
          SPrefUserModel().setPassword(passwordController.text);
        }
        SPrefUserModel().setIsSignIn(true);
        removeNotifier();
        _transitionToLadingView();

        return true;
      }

      return false;
    } on ApiException catch (e) {
      _inProgress = false;
      updateUI();
      hideCurrentSnackBar();
      showToastError(
        e.failure?.message ?? Strings.of(context)!.anErrorHasOccurred,
      );

      return false;
    } on Exception {
      _inProgress = false;
      updateUI();
      hideCurrentSnackBar();
      showToastError(
        Strings.of(context)!.anErrorHasOccurred,
      );

      return false;
    }
  }

  void inItData() {
    final bool? remember = SPrefUserModel().getRemember();
    final String? expiration = SPrefUserModel().getExpiration();
    if (expiration == null) {
      return;
    }
    DateTime expirationDateTime = DateTime.parse(expiration);
    if (expirationDateTime.isAfter(DateTime.now()) &&
        remember != null &&
        remember) {
      final String? email = SPrefUserModel().getEmail();
      final String? password = SPrefUserModel().getPassword();
      _isCheckRememberMe = remember;
      emailController.text = email ?? "";
      passwordController.text = password ?? "";
      notifyListeners();
    }
  }

  void _transitionToLadingView() {
    Navigator.of(context).pop();
  }

  String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.passwordRequired;
    }

    return null;
  }

  void hideCurrentSnackBar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
