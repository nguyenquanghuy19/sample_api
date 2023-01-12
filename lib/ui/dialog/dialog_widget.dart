import 'dart:io';

import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///  This method will be invoked when a button in the dialog is clicked.
typedef DialogPositiveOnClickListener = void Function();

///  This method will be invoked when a button in the dialog is clicked.
typedef DialogNegativeOnClickListener = void Function();

///  This method will be invoked when a dialog is dismissed.
typedef DialogDismissedListener = void Function();

class DialogWidget {
  static DialogWidget? _instance;

  DialogWidget._();

  factory DialogWidget() {
    return _instance ??= DialogWidget._();
  }

  void _buildDialogAndroidStyle(
    BuildContext context, {
    String? title,
    required String content,
    String? subTitle,
    String? positiveText,
    String? negativeText,
    DialogPositiveOnClickListener? positiveOnClickListener,
    DialogNegativeOnClickListener? negativeOnClickListener,
    DialogDismissedListener? dismissedListener,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title,
                    style: AppText.text22.copyWith(fontWeight: FontWeight.w700),
                  ),
                subTitle != null && title != null
                    ? SizedBox(
                        height: 5.h,
                      )
                    : const SizedBox.shrink(),
                subTitle != null
                    ? Text(
                        subTitle,
                        style: AppText.text14.copyWith(
                          color: AppColor.neutrals.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            content: Text(
              content,
              style: AppText.text14.copyWith(
                color: AppColor.neutrals.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: <Widget>[
              if (negativeText != null)
                TextButton(
                  child: Text(
                    negativeText,
                    style: AppText.text14.copyWith(
                      color: AppColor.neutrals.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (negativeOnClickListener != null) {
                      negativeOnClickListener();
                    }
                  },
                ),
              if (positiveText != null)
                TextButton(
                  child: Text(
                    positiveText,
                    style: AppText.text14.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary.shade400,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (positiveOnClickListener != null) {
                      positiveOnClickListener();
                    }
                  },
                ),
            ],
          ),
        );
      },
    ).then(
      (dynamic value) {
        if (dismissedListener != null) dismissedListener();
      },
    );
  }

  void _buildDialogIOSStyle(
    BuildContext context, {
    String? title,
    String? subTitle,
    required String content,
    String? positiveText,
    String? negativeText,
    DialogPositiveOnClickListener? positiveOnClickListener,
    DialogNegativeOnClickListener? negativeOnClickListener,
    DialogDismissedListener? dismissedListener,
  }) {
    showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            title: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (title != null)
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppText.text16.copyWith(
                          color: AppColor.neutrals.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    subTitle != null && title != null
                        ? SizedBox(
                            height: 10.h,
                          )
                        : const SizedBox.shrink(),
                    subTitle != null
                        ? Text(
                            subTitle,
                            textAlign: TextAlign.center,
                            style: AppText.text12
                                .copyWith(color: AppColor.neutrals.shade300),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
              style: AppText.text14.copyWith(
                color: AppColor.neutrals.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: <Widget>[
              if (negativeText != null)
                CupertinoDialogAction(
                  isDefaultAction: true,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (negativeOnClickListener != null) {
                      negativeOnClickListener();
                    }
                  },
                  child: Text(
                    negativeText,
                    style: AppText.text14.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              if (positiveText != null)
                CupertinoDialogAction(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (positiveOnClickListener != null) {
                      positiveOnClickListener();
                    }
                  },
                  child: Text(
                    positiveText,
                    style: AppText.text14.copyWith(
                      color: AppColor.primary.shade400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    ).then(
      (dynamic value) {
        if (dismissedListener != null) dismissedListener();
      },
    );
  }

  void showBasicDialog({
    required BuildContext context,
    String? title,
    String? subTitle,
    required String content,
    String? positiveText,
    String? negativeText,
    DialogPositiveOnClickListener? positiveOnClickListener,
    DialogNegativeOnClickListener? negativeOnClickListener,
    DialogDismissedListener? dismissedListener,
  }) {
    if (Platform.isAndroid) {
      _buildDialogAndroidStyle(
        context,
        subTitle: subTitle,
        title: title,
        content: content,
        positiveText: positiveText?.isEmpty == true
            ? null
            : positiveText ?? Strings.of(context)!.accept,
        negativeText: negativeText?.isEmpty == true
            ? null
            : negativeText ?? Strings.of(context)!.cancel,
        positiveOnClickListener: positiveOnClickListener,
        negativeOnClickListener: negativeOnClickListener,
        dismissedListener: dismissedListener,
      );
    } else {
      _buildDialogIOSStyle(
        context,
        subTitle: subTitle,
        title: title,
        content: content,
        positiveText: positiveText?.isEmpty == true
            ? null
            : positiveText ?? Strings.of(context)!.accept,
        negativeText: negativeText?.isEmpty == true
            ? null
            : negativeText ?? Strings.of(context)!.cancel,
        positiveOnClickListener: positiveOnClickListener,
        negativeOnClickListener: negativeOnClickListener,
        dismissedListener: dismissedListener,
      );
    }
  }

  void dioLogLoading({required BuildContext context}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 200,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CupertinoActivityIndicator(),
                    const SizedBox(height: 15),
                    Text(
                      "Loading...",
                      style: AppText.text18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
