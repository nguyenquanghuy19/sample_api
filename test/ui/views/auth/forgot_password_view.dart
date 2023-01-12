import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/check_validate_utils.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_models/auth/forgot_password_view_model.dart';

class ForgotPasswordView extends BaseView {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  ForgotPasswordViewState createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState
    extends BaseViewState<ForgotPasswordView, ForgotPasswordViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ForgotPasswordViewModel()..onInitViewModel(context);
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () =>
              FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 70.h),
                _buildTitle(),
                SizedBox(
                  height: 12.h,
                ),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: AppInput(
                    hintText: Strings.of(context)!.emailAddress,
                    prefixIcon: Icon(
                      Icons.email,
                      size: 18.h,
                    ),
                    validator: (value) =>
                        CheckValidateUtils.validateEmail(value, context),
                  ),
                ),
                SizedBox(
                  height: 12.h * 1.5,
                ),
                AppButton(
                  label: Strings.of(context)!.btnResetPassword,
                  backgroundColor: AppColor.primary.shade400,
                  onPressed: () => null,
                ),
                SizedBox(
                  height: 12.h,
                ),
                TextButton(
                  child: Text(
                    Strings.of(context)!.rememberPassword,
                    style: AppText.text21.copyWith(color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.of(context)!.requestANewPassword,
          style: AppText.text33,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 12.h,
        ),
        Text(
          Strings.of(context)!.pleaseEnterYourEmail,
          style: AppText.text21.copyWith(color: AppColor.neutrals),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 12.h,
        ),
      ],
    );
  }
}
