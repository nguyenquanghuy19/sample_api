import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardResultQuizWidget extends StatefulWidget {
  final bool isPass;
  final String? idQuiz;
  final String? courseName;
  final String? studentName;
  final String? quizTime;
  final String? pointQuiz;
  final String? timeDoQuiz;
  final String? questionQuiz;
  final String? numberQuiz;

  const CardResultQuizWidget({
    Key? key,
    required this.isPass,
    this.idQuiz,
    this.courseName,
    this.studentName,
    this.quizTime,
    this.pointQuiz,
    this.timeDoQuiz,
    this.questionQuiz,
    this.numberQuiz,
  }) : super(key: key);

  @override
  State<CardResultQuizWidget> createState() => _CardResultQuizWidgetState();
}

class _CardResultQuizWidgetState extends State<CardResultQuizWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
        vertical: 20.h,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4).r,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          _buildHeaderCard(
            widget.isPass,
          ),
          SizedBox(
            height: 10.h,
          ),
          _buildPointQuiz(),
          SizedBox(
            height: 20.h,
          ),
          Text(
            widget.isPass
                ? Strings.of(context)!.titlePassedQuiz
                : Strings.of(context)!.titleFailedQuiz,
            style: AppText.text14.copyWith(
              color: AppColor.neutrals.shade300,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(bool isPass) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.courseName ?? "",
                maxLines: 3,
                style: AppText.text22.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              Text(
                widget.quizTime ?? "",
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 5.h),
        Image.asset(
          isPass ? Images.imageOwlPassed : Images.imageOwlFailed,
          height: 115.h,
          width: 93.w,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  Widget _buildPointQuiz() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        children: [
          Text(
            widget.studentName ?? '',
            style: AppText.text16.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildItemQuiz(
                      Images.iconPointQuiz,
                      Strings.of(context)!.titlePassScoreQuiz,
                      widget.pointQuiz,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildItemQuiz(
                      Images.iconQuestionQuiz,
                      "${Strings.of(context)!.question}:",
                      widget.questionQuiz,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildItemQuiz(
                      Images.iconTimerQuiz,
                      Strings.of(context)!.titleTimeResultQuiz,
                      widget.timeDoQuiz,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _buildItemQuiz(
                      Images.iconCountRemainingQuiz,
                      Strings.of(context)!.titleNumberResultQuiz,
                      widget.numberQuiz,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemQuiz(String imageAsset, String title, String? content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColor.neutrals.shade300,
              width: 1,
            ),
          ),
          child: SvgPicture.asset(
            imageAsset,
            width: 18.w,
            height: 18.h,
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade300,
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              Text(
                content ?? "",
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade800,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
