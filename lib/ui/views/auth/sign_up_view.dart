import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/check_validate_utils.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/view_models/auth/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignUpView extends BaseView {
  const SignUpView({super.key});

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends BaseViewState<SignUpView, SignUpViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SignUpViewModel()..onInitViewModel(context);
  }

  @override
  void onBuildCompleted() {
    super.onBuildCompleted();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
        child: SafeArea(child: _buildContent()),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
          children: [
            Container(
              height: 400.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.imageBackgroundAuth),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 250.h),
              child: Column(
                children: [
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
                          children: <Widget>[
                            _buildTitle(),
                            SizedBox(height: 28.h),
                            _buildEmailTextField(),
                            SizedBox(height: 14.h),
                            _buildPasswordTextField(),
                            SizedBox(height: 14.h),
                            _buildConfirmPasswordTextField(),
                            SizedBox(height: 14.h),
                            _buildRememberMeCheckbox(),
                            SizedBox(height: 28.h),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: _buildSignUpBtn(),
                      ),
                    ],
                  ),
                  SizedBox(height: 27.h),
                  TextButton(
                    child: Text(
                      Strings.of(context)!.haveAnAccount,
                      style:
                          AppText.text14.copyWith(color: AppColor.blueAccent),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.of(context)!.registerAccountTitle,
          style: AppText.text24.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 14.h,
        ),
        Text(
          Strings.of(context)!.registerAccountContent,
          style: AppText.text14,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailTextField() {
    return AppInput(
      controller: viewModel.emailTextFieldController,
      keyboardType: TextInputType.text,
      validator: (value) => CheckValidateUtils.validateEmail(value, context),
      hintText: Strings.of(context)!.emailAddress,
      prefixIcon:
          Tab(icon: SvgPicture.asset(Images.iconEmail, width: 20, height: 20)),
    );
  }

  Widget _buildPasswordTextField() {
    return AppInput(
      controller: viewModel.passwordTextFieldController,
      keyboardType: TextInputType.text,
      obscureText: !_passwordVisible,
      validator: (value) => CheckValidateUtils.validatePassword(value, context),
      hintText: Strings.of(context)!.password,
      prefixIcon: Tab(
        icon: SvgPicture.asset(Images.iconLock, width: 20.w, height: 20.h),
      ),
      suffixIcon: Tab(
        icon: IconButton(
          icon: SvgPicture.asset(
            _passwordVisible ? Images.iconSubtractHide : Images.iconSubtract,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return AppInput(
      controller: viewModel.confirmPasswordTextFieldController,
      keyboardType: TextInputType.text,
      obscureText: !_confirmPasswordVisible,
      validator: (value) => viewModel.validateConfirmPassword(value),
      hintText: Strings.of(context)!.repeatPassword,
      prefixIcon: Tab(
        icon: SvgPicture.asset(Images.iconLock, width: 20.w, height: 20.h),
      ),
      suffixIcon: Tab(
        icon: IconButton(
          icon: SvgPicture.asset(
            _confirmPasswordVisible
                ? Images.iconSubtractHide
                : Images.iconSubtract,
          ),
          onPressed: () {
            setState(() {
              _confirmPasswordVisible = !_confirmPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Row(
      children: <Widget>[
        Selector<SignUpViewModel, bool>(
          selector: (_, viewModel) => viewModel.isCheckAgreeTermsAndConditions,
          builder: (_, isCheckRemember, __) {
            return Checkbox(
              value: isCheckRemember,
              side: MaterialStateBorderSide.resolveWith(
                (states) =>
                    const BorderSide(width: 1.0, color: AppColor.neutrals),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              checkColor: Colors.white,
              activeColor: AppColor.blueAccent.shade300,
              onChanged: (value) {
                viewModel.checkedAgreeTermsAndConditions(value);
              },
            );
          },
        ),
        Expanded(
          child: Text(
            Strings.of(context)!.agreeTermsAndConditions,
            textAlign: TextAlign.left,
            style: AppText.text12.copyWith(color: AppColor.neutrals.shade800),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Selector<SignUpViewModel, bool>(
      selector: (_, viewModel) => viewModel.inProgress,
      builder: (_, inProgress, __) {
        return AppButton(
          width: 166.w,
          label: Strings.of(context)!.btnSignUp,
          isDisableButton: inProgress,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (!inProgress) {
                viewModel.onPressSignUp();
              }
            }
          },
        );
      },
    );
  }
}
