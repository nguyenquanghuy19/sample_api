import 'package:elearning/core/data/share_preference/spref_user_model.dart';
import 'package:elearning/ui/views/auth/sign_in_view.dart';
import 'package:elearning/ui/views/auth/sign_up_view.dart';
import 'package:elearning/ui/views/mains/main_view_after_sign_in.dart';
import 'package:elearning/ui/views/mains/main_view_before_sign_in.dart';
import 'package:elearning/ui/views/profile/profile_view.dart';
import 'package:elearning/ui/views/profile/update_password_view.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class SettingViewModel extends BaseViewModel {
  bool get checkSignIn => SPrefUserModel().getIsSignIn();

  void onClickProfileButton() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const ProfileView(),
      ),
    );
  }

  void onClickLogin() {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (
          context,
        ) {
          return SignInView(
            canBack: true,
            callBack: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (context) {
                    return const MainViewAfterSignIn();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void onClickRegister() {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (
          context,
        ) {
          return const SignUpView();
        },
      ),
    );
  }

  void onClickSignOut() {
    SPrefUserModel().removeDataUser(SPrefUserModel.accessTokenKey);
    SPrefUserModel().removeDataUser(SPrefUserModel.refreshTokenKey);
    SPrefUserModel().removeDataUser(SPrefUserModel.isSignInKey);
    SPrefUserModel().removeDataUser(SPrefUserModel.avatarKey);
    SPrefUserModel().removeDataUser(SPrefUserModel.typeAvatarKey);
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainViewBeforeSignIn(),
      ),
    );
  }

  void onClickChangePasswordButton() {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => const UpdatePasswordView(),
      ),
    );
  }
}
