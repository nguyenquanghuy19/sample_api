import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/check_validate_utils.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/view_models/profile/update_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UpdatePasswordView extends BaseView {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  UpdatePasswordViewState createState() => UpdatePasswordViewState();
}

class UpdatePasswordViewState
    extends BaseViewState<UpdatePasswordView, UpdatePasswordViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            Navigator.of(context).pop();
          },
          icon: Tab(
            icon: SvgPicture.asset(Images.iconArrowLeft),
          ),
        ),
        title: Text(
          Strings.of(context)!.updatePasswordTitle,
          style: AppText.text24.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            _buildTitle(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 38.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInput(
                    controller: viewModel.oldPasswordTextFieldController,
                    keyboardType: TextInputType.text,
                    validator: (value) => viewModel.validateOldPassword(value),
                    onChanged: (value) {
                      viewModel.oldPasswordTextFieldController.text =
                          viewModel.oldPasswordTextFieldController.text.trim();
                      viewModel.oldPasswordTextFieldController.selection =
                          TextSelection.fromPosition(
                        TextPosition(
                          offset: viewModel
                              .oldPasswordTextFieldController.text.length,
                        ),
                      );
                    },
                    hintText: Strings.of(context)!.oldPassword,
                    contentPaddingVertical: 5.h,
                    hintStyle: AppText.text14
                        .copyWith(color: AppColor.neutrals.shade300),
                    obscureText: !_oldPasswordVisible,
                    prefixIcon: SvgPicture.asset(
                      Images.iconLockOld,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _oldPasswordVisible = !_oldPasswordVisible;
                        });
                      },
                      icon: SvgPicture.asset(
                        _oldPasswordVisible
                            ? Images.iconSubtractHide
                            : Images.iconSubtract,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  AppInput(
                    controller: viewModel.newPasswordTextFieldController,
                    keyboardType: TextInputType.text,
                    obscureText: !_newPasswordVisible,
                    validator: (value) =>
                        CheckValidateUtils.validatePassword(value, context),
                    hintText: Strings.of(context)!.newPassword,
                    contentPaddingVertical: 5.h,
                    hintStyle: AppText.text14
                        .copyWith(color: AppColor.neutrals.shade300),
                    prefixIcon: SvgPicture.asset(
                      Images.iconLock,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _newPasswordVisible = !_newPasswordVisible;
                        });
                      },
                      icon: SvgPicture.asset(
                        _newPasswordVisible
                            ? Images.iconSubtractHide
                            : Images.iconSubtract,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  AppInput(
                    controller: viewModel.confirmPasswordTextFieldController,
                    keyboardType: TextInputType.text,
                    obscureText: !_confirmPasswordVisible,
                    validator: (value) =>
                        viewModel.validateConfirmPassword(value),
                    hintText: Strings.of(context)!.confirmPassword,
                    contentPaddingVertical: 5.h,
                    hintStyle: AppText.text14
                        .copyWith(color: AppColor.neutrals.shade300),
                    prefixIcon: SvgPicture.asset(
                      Images.iconLock,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                      icon: SvgPicture.asset(
                        _confirmPasswordVisible
                            ? Images.iconSubtractHide
                            : Images.iconSubtract,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            _buildUpdatePasswordBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        SizedBox(
          height: 24.h,
        ),
        Text(
          Strings.of(context)!.updatePasswordContent,
          style: AppText.text14.copyWith(color: AppColor.neutrals.shade800),
        ),
        SizedBox(
          height: 24.h,
        ),
      ],
    );
  }

  Widget _buildUpdatePasswordBtn() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Selector<UpdatePasswordViewModel, bool>(
        selector: (_, viewModel) => viewModel.inProgress,
        builder: (_, inProgress, __) {
          return AppButton(
            width: 166.w,
            isDisableButton: inProgress,
            label: Strings.of(context)!.updatePasswordButton,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (!inProgress) {
                  viewModel.onPressUpdatePassword();
                }
              }
            },
          );
        },
      ),
    );
  }
}
