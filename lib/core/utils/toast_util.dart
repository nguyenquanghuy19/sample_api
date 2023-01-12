import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:flutter/material.dart';

class MessageUtils {
  static void showToastMessage(
    BuildContext context,
    String title,
    String msg,
    Color? backGroundColor,
    Color? colorContent,
    Color? colorIcon,
    Color? colorBorder,
    TypeToast typeToast,
    IconData? icon,
  ) {
    switch (typeToast) {
      case TypeToast.success:
        ScaffoldMessenger.of(context).showSnackBar(
          _buildToastSuccess(
            backGroundColor,
            colorBorder,
            colorIcon,
            title,
            msg,
            colorContent,
          ),
        );
        break;
      case TypeToast.error:
        ScaffoldMessenger.of(context).showSnackBar(
          _buildToastError(
            backGroundColor,
            colorBorder,
            colorIcon,
            title,
            msg,
            colorContent,
          ),
        );
        break;
      case TypeToast.warning:
        ScaffoldMessenger.of(context).showSnackBar(
          _buildToastWarning(
            backGroundColor,
            colorBorder,
            colorIcon,
            title,
            msg,
            colorContent,
          ),
        );
        break;
      case TypeToast.custom:
        ScaffoldMessenger.of(context).showSnackBar(
          _buildToastCustom(
            backGroundColor,
            colorBorder,
            icon,
            colorIcon,
            title,
            msg,
            colorContent,
          ),
        );
        break;
    }
  }

  static SnackBar _buildToastSuccess(
    Color? backGroundColor,
    Color? colorBorder,
    Color? colorIcon,
    String title,
    String msg,
    Color? colorContent,
  ) {
    return SnackBar(
      backgroundColor: backGroundColor,
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: colorBorder ?? Colors.transparent,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      content: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: colorIcon,
            size: 30,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppText.text18.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                msg,
                style: AppText.text16.copyWith(color: colorContent),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static SnackBar _buildToastError(
    Color? backGroundColor,
    Color? colorBorder,
    Color? colorIcon,
    String title,
    String msg,
    Color? colorContent,
  ) {
    return SnackBar(
      backgroundColor: backGroundColor,
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: colorBorder ?? Colors.transparent,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      content: Row(
        children: [
          Icon(
            Icons.block_flipped,
            color: colorIcon,
            size: 30,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppText.text18.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                msg,
                style: AppText.text16.copyWith(color: colorContent),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static SnackBar _buildToastWarning(
    Color? backGroundColor,
    Color? colorBorder,
    Color? colorIcon,
    String title,
    String msg,
    Color? colorContent,
  ) {
    return SnackBar(
      backgroundColor: backGroundColor,
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: colorBorder ?? Colors.transparent,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      content: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: colorIcon,
            size: 30,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppText.text18.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                msg,
                style: AppText.text16.copyWith(color: colorContent),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static SnackBar _buildToastCustom(
    Color? backGroundColor,
    Color? colorBorder,
    IconData? icon,
    Color? colorIcon,
    String title,
    String msg,
    Color? colorContent,
  ) {
    return SnackBar(
      backgroundColor: backGroundColor,
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: colorBorder ?? Colors.transparent,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      content: Row(
        children: [
          Icon(
            icon,
            color: colorIcon,
            size: 30,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              title.isNotEmpty
                  ? Text(
                      title,
                      style: AppText.text18.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox.shrink(),
              Text(
                msg,
                style: AppText.text16.copyWith(color: colorContent),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
