import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorViewWidget extends StatelessWidget {
  final String? image;
  final String? errorCode;
  final String? title;
  final String? message;
  final Function? onButtonPressed;

  const ErrorViewWidget({
    Key? key,
    this.image,
    this.errorCode,
    this.title,
    this.message,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    Images.iconClose,
                    color: AppColor.primary.shade500,
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    if (image != null)
                      Container(
                        margin: EdgeInsets.only(
                          top: 100.h,
                        ),
                        height: 240.h,
                        child: Image.asset(image!),
                      ),
                    SizedBox(height: 40.h),
                    if (errorCode != null)
                      Text(
                        errorCode!,
                        textAlign: TextAlign.center,
                        style: AppText.text60.copyWith(
                          color: AppColor.primary.shade400,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    SizedBox(height: 40.h),
                    if (title != null)
                      Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: AppText.text18.copyWith(
                          color: AppColor.textTitleErrorWidget,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    SizedBox(height: 8.h),
                    if (message != null)
                      Text(
                        message!,
                        textAlign: TextAlign.center,
                        style: AppText.text14.copyWith(
                          color: AppColor.textMessageErrorWidget,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    SizedBox(height: 60.h),
                    AppButton(
                      width: 160.w,
                      label: Strings.of(context)!.tryAgain,
                      isDisableButton: false,
                      onPressed: () {
                        // TODO onPressed try again
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
