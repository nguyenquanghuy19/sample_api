import 'package:elearning/ui/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double? width;
  final double? height;
  final TextStyle? styleLabel;
  final Color? backgroundColor;
  final double borderRadius;
  final Color? colorBorderSide;
  final bool? isDisableButton;

  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.styleLabel,
    this.borderRadius = 24,
    this.colorBorderSide,
    this.isDisableButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor(),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isDisableButton != null
                ? BorderSide.none
                : BorderSide(
                    color: colorBorderSide ?? AppColor.primary.shade400,
                    width: 1,
                  ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: _styleLabel(),
        ),
      ),
    );
  }

  Color? _backgroundColor() {
    if (isDisableButton != null) {
      return isDisableButton!
          ? AppColor.neutrals.shade100
          : AppColor.primary.shade400;
    }

    return backgroundColor ?? Colors.white;
  }

  TextStyle? _styleLabel() {
    if (isDisableButton != null) {
      return isDisableButton!
          ? AppText.text14.copyWith(
              color: AppColor.neutrals.shade500,
              fontWeight: FontWeight.w700,
            )
          : AppText.text14
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700);
    }

    return styleLabel ?? AppText.text24.copyWith(color: AppColor.neutrals);
  }
}

class AppButtonIcon extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double? width;
  final double? height;
  final TextStyle? styleLabel;
  final Color? backgroundColor;
  final double borderRadius;
  final Widget icon;

  const AppButtonIcon({
    Key? key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.styleLabel,
    this.borderRadius = 100,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.white,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            icon,
            SizedBox(width: 6.w),
            Text(
              label,
              textAlign: TextAlign.center,
              style: styleLabel ??
                  AppText.text24.copyWith(color: AppColor.neutrals),
            ),
          ],
        ),
      ),
    );
  }
}
