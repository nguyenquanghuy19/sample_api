import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:testproject/core/utils/check_validate_utils.dart';
import 'package:testproject/ui/shared/app_input.dart';
import 'package:testproject/ui/shared/app_theme.dart';
import 'package:testproject/ui/shared/images.dart';
import 'package:testproject/ui/views/base_view.dart';
import 'package:testproject/view_models/auth/sign_in_view_model.dart';

class SignInView extends BaseView {
  const SignInView({
    super.key,
  });

  @override
  SignInViewState createState() => SignInViewState();
}

class SignInViewState extends BaseViewState<SignInView, SignInViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String patternUppercase =
      ".*[A-Z].*"; // should contain at least one upper case
  String patternLowercase =
      ".*[a-z].*"; // should contain at least one lower case
  String patternDigit = ".*\\d.*"; // should contain at least one digit
  String patternSpecial =
      ".*[!@#\$%^&*+=?-].*"; // should contain at least one Special character
  String password = "";
  double passwordStrength = 0;
  String displayTextError = 'Please enter a password';

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SignInViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
        child: _buildSignIn(),
      ),
    );
  }

  Widget _buildSignIn() {
    return SingleChildScrollView(
      child: Stack(children: [
        Container(
          height: 500.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.imageBackgroundAuth),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.8),
                  Colors.black,
                  Colors.black,
                  Colors.black,
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: 200.h,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's get you started!",
                  style: AppText.text22.copyWith(color: Colors.white),
                ),
                SizedBox(height: 40.h),
                AppInput(
                  hintText: "Your email",
                  controller: viewModel.emailController,
                  validator: (value) {
                    return CheckValidateUtils.validateEmail(
                      value,
                      context,
                    );
                  },
                ),
                SizedBox(height: 50.h),
                AppInput(
                  hintText: "Your password",
                  controller: viewModel.passwordController,
                  obscureText: true,
                  onChanged: (value) {
                    _checkPassword(value);
                    // viewModel.passwordController.text =
                    //     viewModel.passwordController.text.trim();
                    // viewModel.passwordController.selection =
                    //     TextSelection.fromPosition(
                    //   TextPosition(
                    //     offset: viewModel.passwordController.text.length,
                    //   ),
                    // );
                  },
                  suffixIcon: Tab(
                    icon: SvgPicture.asset(Images.iconPassword),
                    height: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: LinearProgressIndicator(
                    value: passwordStrength,
                    backgroundColor: Colors.grey[300],
                    minHeight: 5,
                    color: passwordStrength <= 1 / 4
                        ? Colors.red
                        : passwordStrength == 2 / 4
                            ? Colors.yellow
                            : passwordStrength == 3 / 4
                                ? Colors.blue
                                : Colors.green,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  displayTextError,
                  style: AppText.text16.copyWith(color: Colors.red),
                ),
                SizedBox(height: 40.h),
                _checkRememberMe(),
                SizedBox(height: 29.h),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'By clicking Sign Up, you are indicating that you have read and agree to the ',
                        style: AppText.text16
                            .copyWith(color: Colors.white.withOpacity(0.5)),
                      ),
                      TextSpan(
                        text: 'Terms of Service ',
                        style: AppText.text16
                            .copyWith(color: AppColor.colorsPrimary),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: AppText.text16.copyWith(
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: AppText.text16
                            .copyWith(color: AppColor.colorsPrimary),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sign Up",
                      style: AppText.text18.copyWith(color: Colors.white),
                    ),
                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: Colors.white,
                      padding: const EdgeInsets.all(15.0),
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.arrow_circle_right,
                        size: 35.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
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
                    const BorderSide(width: 1.0, color: AppColor.colorsPrimary),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              checkColor: Colors.white,
              activeColor: Colors.transparent,
              onChanged: (value) => viewModel.checkedRememberMe(value),
            );
          },
        ),
        Expanded(
          child: Text(
            "I am over 16 years of age",
            style: AppText.text14.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _checkPassword(String value) {
    password = value.trim();
    RegExp rxUppercase = RegExp(patternUppercase);
    RegExp rxLowercase = RegExp(patternLowercase);
    RegExp rxDigit = RegExp(patternDigit);
    RegExp rxSpecial = RegExp(patternSpecial);

    if (password.isEmpty || password.length < 6 || password.length > 18) {
      setState(() {
        passwordStrength = 0;
        displayTextError =
            'Please enter you password. The password must be between 6-18 characters';
      });
    } else if (!rxUppercase.hasMatch(password) &&
        !rxLowercase.hasMatch(password)) {
      setState(() {
        passwordStrength = 1 / 4;
        displayTextError =
            'Your password is contains both lowercase and uppercase letters';
      });
    } else if (!rxDigit.hasMatch(password)) {
      setState(() {
        passwordStrength = 2 / 4;
        displayTextError =
            'Your password is contains at least one numeric character';
      });
    } else {
      if (!rxSpecial.hasMatch(password)) {
        setState(() {
          // Password length >= 8
          // But doesn't contain both letter and digit characters
          passwordStrength = 3 / 4;
          displayTextError = 'Your password is contains special characters';
        });
      } else {
        // Password length > 6 & < 18
        // Password contains both lowercase and uppercase letters and digit characters and special characters
        setState(() {
          passwordStrength = 1;
          displayTextError = 'Your password is great';
        });
      }
    }
  }
}
