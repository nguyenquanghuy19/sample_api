import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/check_validate_utils.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/auth/forgot_password_view.dart';
import 'package:elearning/ui/views/auth/sign_up_view.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_models/auth/sign_in_view_model.dart';

class SignInView extends BaseView {
  const SignInView({super.key});

  @override
  SignInViewState createState() => SignInViewState();
}

class SignInViewState extends BaseViewState<SignInView, SignInViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SignInViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(411, 774),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () =>
              FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
          child: _buildSignIn(),
        ),
      ),
    );
  }

  Widget _buildSignIn() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70.h),
            _buildTitle(),
            SizedBox(height: 5.h),
            _buildMessageWelcome(),
            SizedBox(height: 30.h),
            AppInput(
              prefixIcon: Icon(
                Icons.email,
                size: 18.h,
              ),
              hintText: Strings.of(context)!.emailAddress,
              controller: viewModel.emailController,
              validator: (value) =>
                  CheckValidateUtils.validateEmail(value, context),
            ),
            SizedBox(height: 8.h),
            AppInput(
              prefixIcon: Icon(
                Icons.key,
                size: 18.h,
              ),
              hintText: Strings.of(context)!.password,
              controller: viewModel.passwordController,
              obscureText: true,
              validator: (value) => viewModel.validatePassword(value, context),
            ),
            SizedBox(height: 10.h),
            _checkRememberMe(),
            SizedBox(height: 20.h),
            AppButton(
              label: Strings.of(context)!.btnSignIn,
              backgroundColor: AppColor.primary.shade400,
              onPressed: () => null,
            ),
            SizedBox(height: 20.h),
            _forgottenPassword(),
            SizedBox(height: 5.h),
            _signUpNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      Strings.of(context)!.welcomeBack,
      textAlign: TextAlign.center,
      style: AppText.text33,
    );
  }

  Widget _buildMessageWelcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.of(context)!.introduceMessage,
          textAlign: TextAlign.center,
          style: AppText.text21.copyWith(color: AppColor.neutrals),
        ),
        SizedBox(height: 2.h),
        Text(
          Strings.of(context)!.introduceLogIn,
          textAlign: TextAlign.center,
          style: AppText.text21.copyWith(color: AppColor.neutrals),
        ),
      ],
    );
  }

  Widget _checkRememberMe() {
    return Row(
      children: <Widget>[
        Selector<SignInViewModel, bool>(
          selector: (_, viewModel) => viewModel.isCheckRememberMe,
          builder: (_, isCheckRemember, __) {
            return Checkbox(
              value: isCheckRemember,
              side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 1.0, color: AppColor.neutrals),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              checkColor: Colors.white,
              activeColor: AppColor.blueAccent.shade300,
              onChanged: (value) => viewModel.checkedRememberMe(value),
            );
          },
        ),
        Expanded(
          child: Text(
            Strings.of(context)!.rememberAccount,
            textAlign: TextAlign.left,
            style: AppText.text18.copyWith(color: AppColor.neutrals),
          ),
        ),
      ],
    );
  }

  Widget _forgottenPassword() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        child: Text(
          Strings.of(context)!.forgottenPassword,
          style: AppText.text21.copyWith(color: Colors.blue),
        ),
        onPressed: () {
          LogUtils.d("[$runtimeType][OPEN_FORGOT_PASSWORD_SCREEN] => RUNNING");
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (context) {
              return const ForgotPasswordView();
            }),
          );
        },
      ),
    );
  }

  Widget _signUpNav() {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: Strings.of(context)!.signUpNavigation,
              style: AppText.text21.copyWith(color: AppColor.neutrals),
            ),
            TextSpan(
              text: Strings.of(context)!.btnSignUp,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  LogUtils.d("[$runtimeType][OPEN_SIGN_UP_SCREEN] => RUNNING");
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (context) {
                      return const SignUpView();
                    }),
                  );
                },
              style: AppText.text21.copyWith(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
