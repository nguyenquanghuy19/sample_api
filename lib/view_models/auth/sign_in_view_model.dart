import 'package:flutter/material.dart';
import 'package:testproject/core/data/repositories/auth_repository.dart';
import 'package:testproject/core/data/share_preference/spref_user_model.dart';
import 'package:testproject/core/utils/log_utils.dart';
import 'package:testproject/ui/views/main/main_view.dart';
import 'package:testproject/view_models/base_view_model.dart';

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
    await SPrefUserModel().onInit();
    emailController.text = "huy2test@gmail.com";
    passwordController.text = "123abcD@";
    LogUtils.d("[$runtimeType][LOGIN_VIEW_MODEL] => INIT");
  }

  void checkedRememberMe(bool? isChecked) {
    _isCheckRememberMe = isChecked!;
    updateUI();
  }

  Future<void> onSignIn() async {
    try {
      _inProgress = true;
      final res = await _authRepository.signUp(
        "Huy",
        "Nguyen",
        emailController.text,
        passwordController.text,
      );
      if (res != null) {
        await SPrefUserModel().setAccessToken(res.token);
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) {
            return const MainView();
          }),
        );
      }
      _inProgress = false;
      updateUI();
    } on Exception catch (error) {
      _inProgress = false;
      LogUtils.d("[SignIn_MODEL] => error: $error");
      updateUI();
    }
  }
}
