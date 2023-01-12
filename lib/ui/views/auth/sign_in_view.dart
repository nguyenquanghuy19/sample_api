import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/check_validate_utils.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/auth/forgot_password_view.dart';
import 'package:elearning/ui/views/auth/sign_up_view.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/view_models/auth/sign_in_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignInView extends BaseView {
  final Function()? callBack;
  final bool canBack;
  final bool showExpirationToken;

  const SignInView({
    super.key,
    this.callBack,
    required this.canBack,
    this.showExpirationToken = false,
  });

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
      bottomSheet: widget.showExpirationToken &&
              MediaQuery.of(context).viewInsets.bottom == 0
          ? Container(
              height: 55,
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              alignment: Alignment.center,
              child: Text(
                Strings.of(context)!.expirationToken,
                style: AppText.text16.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : null,
    );
  }

  Widget _buildSignIn() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(children: [
          Container(
            height: 400.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.imageBackgroundAuth),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (widget.canBack)
            Positioned(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                icon: Tab(
                  icon: SvgPicture.asset(
                    Images.iconArrowLeft,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 250.h),
            child: Column(children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: EdgeInsets.only(bottom: 25.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.neutrals.shade300,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTitle(),
                        SizedBox(height: 14.h),
                        _buildMessageWelcome(),
                        SizedBox(height: 28.h),
                        AppInput(
                          prefixIcon: Tab(
                            icon: SvgPicture.asset(
                              Images.iconEmail,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          hintText: Strings.of(context)!.emailAddress,
                          controller: viewModel.emailController,
                          validator: (value) =>
                              CheckValidateUtils.validateEmail(value, context),
                        ),
                        SizedBox(height: 14.h),
                        AppInput(
                          prefixIcon: Tab(
                            icon: SvgPicture.asset(
                              Images.iconLock,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          hintText: Strings.of(context)!.password,
                          controller: viewModel.passwordController,
                          obscureText: true,
                          onChanged: (value) {
                            viewModel.passwordController.text =
                                viewModel.passwordController.text.trim();
                            viewModel.passwordController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                offset:
                                    viewModel.passwordController.text.length,
                              ),
                            );
                          },
                          validator: (value) =>
                              viewModel.validatePassword(value, context),
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Flexible(child: _checkRememberMe()),
                            const SizedBox(width: 8),
                            Expanded(child: _forgottenPassword()),
                          ],
                        ),
                        SizedBox(height: 29.h),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: _buildSignInBtn(),
                  ),
                ],
              ),
              SizedBox(height: 28.h),
              _signUpNav(),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      Strings.of(context)!.welcomeBack,
      textAlign: TextAlign.center,
      style: AppText.text24.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMessageWelcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.of(context)!.introduceMessage,
          textAlign: TextAlign.center,
          style: AppText.text14,
        ),
        Text(
          Strings.of(context)!.introduceLogIn,
          textAlign: TextAlign.center,
          style: AppText.text14,
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
                (states) =>
                    const BorderSide(width: 1.0, color: AppColor.neutrals),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
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
            style: AppText.text14.copyWith(color: AppColor.neutrals.shade800),
          ),
        ),
      ],
    );
  }

  Widget _forgottenPassword() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) {
            return const ForgotPasswordView();
          }),
        );
      },
      child: Text(
        Strings.of(context)!.forgottenPassword,
        style: AppText.text14.copyWith(color: AppColor.blueAccent),
      ),
    );
  }

  Widget _buildSignInBtn() {
    return Selector<SignInViewModel, bool>(
      selector: (_, viewModel) => viewModel.inProgress,
      builder: (_, inProgress, __) {
        return AppButton(
          width: 166.w,
          label: Strings.of(context)!.btnSignIn,
          isDisableButton: inProgress,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (!inProgress) {
                final res = await viewModel.onSignIn();
                if (res && widget.callBack != null) {
                  widget.callBack!();
                }
              }
            }
          },
        );
      },
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
              style: AppText.text14.copyWith(color: AppColor.neutrals.shade800),
            ),
            TextSpan(
              text: Strings.of(context)!.labelSignUp,
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
              style: AppText.text14.copyWith(color: AppColor.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}
