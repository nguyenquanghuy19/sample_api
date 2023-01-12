import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetSettingFlashCardWidget extends StatefulWidget {
  final bool isShuffleAction;
  final bool isSoundAction;
  final bool isSwapContent;
  final Function(bool, bool, bool) onApply;

  const BottomSheetSettingFlashCardWidget({
    Key? key,
    required this.isShuffleAction,
    required this.isSwapContent,
    required this.isSoundAction,
    required this.onApply,
  }) : super(key: key);

  @override
  State<BottomSheetSettingFlashCardWidget> createState() =>
      _BottomSheetSettingFlashCardWidgetState();
}

class _BottomSheetSettingFlashCardWidgetState
    extends State<BottomSheetSettingFlashCardWidget> {
  bool _isShuffleAction = false;
  bool _isSwapContent = false;
  bool _isSoundAction = false;

  @override
  void initState() {
    _isShuffleAction = widget.isShuffleAction;
    _isSoundAction = widget.isSoundAction;
    _isSwapContent = widget.isSwapContent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, left: Constants.contentPaddingHorizontal, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 16),
            child: Text(
              Strings.of(context)!.setting,
              style: AppText.text24.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width,
          //   child: Text(
          //     Strings.of(context)!.cardSetting,
          //     style: AppText.text16.copyWith(fontWeight: FontWeight.w400),
          //   ),
          // ),
          // SizedBox(height: 20.h),
          _buildShuffleAndSound(context),
          SizedBox(height: 50.h),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              Strings.of(context)!.cardSetting,
              style: AppText.text16.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ToggleButton(
              appTextLeft: AppText.text16,
              appTextRight: AppText.text16,
              width: MediaQuery.of(context).size.width,
              height: 40.h,
              toggleBackgroundColor: AppColor.neutrals.shade100,
              toggleBorderColor: Colors.white,
              toggleColor: Colors.white,
              activeTextColor: Colors.black45,
              inactiveTextColor: Colors.black45,
              toggleBorderColorSelected: Colors.grey,
              defaultToggleActive: _isSwapContent
                  ? SelectedToggleButton.right
                  : SelectedToggleButton.left,
              leftDescription: Strings.of(context)!.terms,
              rightDescription: Strings.of(context)!.explanation,
              onLeftToggleActive: () {
                setState(() {
                  _isSwapContent = false;
                });
              },
              onRightToggleActive: () {
                setState(() {
                  _isSwapContent = true;
                });
              },
            ),
          ),
          SizedBox(
            height: 80.h,
          ),
          AppButton(
            width: 166.w,
            isDisableButton: !_checkApplyButton(),
            label: Strings.of(context)!.apply,
            onPressed: () {
              if (_checkApplyButton()) {
                widget.onApply(
                  _isShuffleAction,
                  _isSoundAction,
                  _isSwapContent,
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShuffleAndSound(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isShuffleAction = !_isShuffleAction;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.blue,
                    ),
                    color: _isShuffleAction ? Colors.blue : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.shuffle,
                      size: 35,
                      color: _isShuffleAction ? Colors.white : Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _isShuffleAction
                  ? Text(Strings.of(context)!.shuffleOn)
                  : Text(Strings.of(context)!.shuffleOff),
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isSoundAction = !_isSoundAction;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.blue,
                    ),
                    color: _isSoundAction ? Colors.blue : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.volume_up,
                      size: 35,
                      color: _isSoundAction ? Colors.white : Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              _isSoundAction
                  ? Text(Strings.of(context)!.soundOn)
                  : Text(Strings.of(context)!.soundOff),
            ],
          ),
        ],
      ),
    );
  }

  bool _checkApplyButton() {
    if (widget.isShuffleAction != _isShuffleAction ||
        widget.isSoundAction != _isSoundAction ||
        widget.isSwapContent != _isSwapContent) {
      return true;
    }

    return false;
  }
}
