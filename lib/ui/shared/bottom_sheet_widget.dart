import 'package:elearning/ui/shared/app_theme.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget {
  static BottomSheetWidget? _instance;

  BottomSheetWidget._();

  factory BottomSheetWidget() {
    return _instance ??= BottomSheetWidget._();
  }

  Future<void> showBottomSheetWidget(
    BuildContext context, {
    required Widget content,
    double? height,
    double? elevation,
    Color? backgroundColor,
    Color? barrierColor,
    required double maxHeight,
    required bool isScrollControlled,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      useRootNavigator: true,
      enableDrag: true,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      constraints: BoxConstraints(minHeight: 0, maxHeight: maxHeight),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        side: BorderSide(
          width: 1,
          strokeAlign: StrokeAlign.outside,
          color: AppColor.supporting.shade600,
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 6,
                width: 40,
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFC8CFD8),
                ),
              ),
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }
}
