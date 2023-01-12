import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/check_validate_utils.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_models/profile/update_password_view_model.dart';

class UpdatePasswordView extends BaseView {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  UpdatePasswordViewState createState() => UpdatePasswordViewState();
}

class UpdatePasswordViewState
    extends BaseViewState<UpdatePasswordView, UpdatePasswordViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = UpdatePasswordViewModel()..onInitViewModel(context);
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
        child: Container(
          alignment: Alignment.center,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              SizedBox(height: 60.h),
              _buildTitle(),
              SizedBox(height: 46.h),
              AppInput(
                controller: viewModel.oldPasswordTextFieldController,
                keyboardType: TextInputType.text,
                validator: (value) => viewModel.validateOldPassword(value),
                hintText: Strings.of(context)!.oldPassword,
                prefixIcon: Icon(
                  Icons.key,
                  size: 18.h,
                ),
                label: Strings.of(context)!.oldPassword,
              ),
              SizedBox(height: 8.h),
              AppInput(
                controller: viewModel.newPasswordTextFieldController,
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: (value) =>
                    CheckValidateUtils.validatePassword(value, context),
                hintText: Strings.of(context)!.newPassword,
                prefixIcon: Icon(
                  Icons.key,
                  size: 18.h,
                ),
                label: Strings.of(context)!.newPassword,
              ),
              SizedBox(height: 8.h),
              AppInput(
                controller: viewModel.confirmPasswordTextFieldController,
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: (value) => viewModel.validateConfirmPassword(value),
                hintText: Strings.of(context)!.confirmPassword,
                prefixIcon: Icon(
                  Icons.key,
                  size: 18.h,
                ),
                label: Strings.of(context)!.confirmPassword,
              ),
              SizedBox(height: 30.h),
              _buildUpdatePasswordBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          Strings.of(context)!.updatePasswordTitle,
          style: AppText.text33,
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }

  Widget _buildUpdatePasswordBtn() {
    return AppButton(
      backgroundColor: AppColor.primary.shade400,
      label: Strings.of(context)!.updatePasswordTitle,
      onPressed: () => null,
    );
  }
}
