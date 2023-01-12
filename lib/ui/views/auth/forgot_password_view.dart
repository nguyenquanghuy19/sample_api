import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/check_validate_utils.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/view_models/auth/forgot_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () =>
              FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
          child: SingleChildScrollView(
            child: Stack(children: [
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
                padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 296.h),
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
                            SizedBox(
                              height: 28.h,
                            ),
                            Form(
                              key: _formKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: AppInput(
                                hintText: Strings.of(context)!.emailAddress,
                                keyboardType: TextInputType.text,
                                prefixIcon: Tab(
                                  icon: SvgPicture.asset(
                                    Images.iconEmail,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                controller: viewModel.emailController,
                                validator: (value) =>
                                    CheckValidateUtils.validateEmail(
                                  value,
                                  context,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 28.h,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: _buildResetPasswordBtn(),
                      ),
                    ],
                  ),
                  SizedBox(height: 28.h),
                  TextButton(
                    child: Text(
                      Strings.of(context)!.rememberPassword,
                      style: AppText.text14.copyWith(
                        color: AppColor.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Navigator.pop(context);
                    },
                  ),
                ]),
              ),
            ]),
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
          style: AppText.text24.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 14.h,
        ),
        Text(
          Strings.of(context)!.pleaseEnterYourEmail,
          style: AppText.text14,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildResetPasswordBtn() {
    return Selector<ForgotPasswordViewModel, bool>(
      selector: (_, viewModel) => viewModel.inProgress,
      builder: (_, inProgress, __) {
        return AppButton(
          width: 166.w,
          label: Strings.of(context)!.btnResetPassword,
          isDisableButton: inProgress,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (!inProgress) {
                viewModel.onGetNewPassword();
              }
            }
          },
        );
      },
    );
  }
}
