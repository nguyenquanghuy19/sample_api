import 'package:elearning/core/data/share_preference/spref_user_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/cupertino.dart';

class SignInViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isCheckRememberMe = false;

  bool get isCheckRememberMe => _isCheckRememberMe;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    await SPrefUserModel().onInit();
    inItData();
    LogUtils.d("[$runtimeType][LOGIN_VIEW_MODEL] => INIT");
  }

  void checkedRememberMe(bool? isChecked) {
    _isCheckRememberMe = isChecked!;
    updateUI();
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

  String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.passwordRequired;
    }

    return null;
  }
}
