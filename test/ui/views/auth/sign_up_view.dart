import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/check_validate_utils.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_models/auth/sign_up_view_model.dart';

class SignUpView extends BaseView {
  const SignUpView({super.key});

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends BaseViewState<SignUpView, SignUpViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

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
    ScreenUtil.init(
      context,
      designSize: const Size(411, 774),
      minTextAdapt: true,
      splitScreenMode: true,
    );

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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 70.h),
            _buildTitle(),
            SizedBox(height: 12.h),
            _buildEmailTextField(),
            SizedBox(height: 12.h),
            _buildPasswordTextField(),
            SizedBox(height: 12.h),
            _buildConfirmPasswordTextField(),
            SizedBox(height: 12.h),
            _buildRememberMeCheckbox(),
            SizedBox(height: 12.h),
            _buildSignUpBtn(),
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
          style: AppText.text28.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          Strings.of(context)!.registerAccountContent,
          style: AppText.text21,
        ),
        SizedBox(
          height: 12.h,
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
      prefixIcon: Icon(
        Icons.email,
        size: 18.h,
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return AppInput(
      controller: viewModel.passwordTextFieldController,
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) => CheckValidateUtils.validatePassword(value, context),
      hintText: Strings.of(context)!.password,
      prefixIcon: Icon(
        Icons.key,
        size: 18.h,
      ),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return AppInput(
      controller: viewModel.confirmPasswordTextFieldController,
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) => viewModel.validateConfirmPassword(value),
      hintText: Strings.of(context)!.repeatPassword,
      prefixIcon: Icon(
        Icons.key,
        size: 18.h,
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
                (states) => const BorderSide(width: 1.0, color: AppColor.neutrals),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
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
            style: AppText.text18.copyWith(color: AppColor.neutrals),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return AppButton(
      backgroundColor: AppColor.primary.shade400,
      label: Strings.of(context)!.btnSignUp,
      onPressed: () => null,
    );
  }
}
