import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/play_ground_quiz/play_quiz_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuizDetailWidget extends StatefulWidget {
  final QuizDetailResponse quizDetailData;
  final int idQuiz;
  final QuizModel quiz;
  final bool canPop;
  final bool fromHistory;

  const QuizDetailWidget({
    Key? key,
    required this.quizDetailData,
    required this.quiz,
    required this.idQuiz,
    required this.canPop,
    required this.fromHistory,
  }) : super(key: key);

  @override
  State<QuizDetailWidget> createState() => _QuizDetailWidgetState();
}

class _QuizDetailWidgetState extends State<QuizDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.quizDetailData.data?.quizName ?? "",
                  style: AppText.text20.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColor.primary.shade400,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      widget.quizDetailData.data!.classroomName ?? "",
                      style:
                          AppText.text18.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.asset(
                            Images.imageOwlDialogQuiz,
                            height: 100.h,
                            width: 100.w,
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            bottom: 14.h,
                            child: Text(
                              '${widget.quiz.detail.length}/${widget.quiz.remaining}',
                              style: AppText.text16
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        Strings.of(context)!.titleNumberResultQuiz,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 13.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90.w,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: AppColor.neutrals.shade100,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Images.iconPointQuiz,
                              height: 12,
                              width: 12,
                            ),
                            SizedBox(width: 5.h),
                            Text(
                              Strings.of(context)!.titlePassScoreQuiz,
                              style: AppText.text12.copyWith(
                                color: AppColor.neutrals.shade400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.quizDetailData.data?.passingScore ?? "",
                          style: AppText.text14.copyWith(
                            color: AppColor.neutrals.shade800,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.h),
                  Container(
                    width: 90.w,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: AppColor.neutrals.shade100,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Images.iconTimerQuiz,
                              height: 12,
                              width: 12,
                            ),
                            SizedBox(width: 5.h),
                            Text(
                              Strings.of(context)!.titleTimeResultQuiz,
                              style: AppText.text12.copyWith(
                                color: AppColor.neutrals.shade400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${widget.quizDetailData.data?.duration}",
                          style: AppText.text14.copyWith(
                            color: AppColor.neutrals.shade800,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.h),
                  Container(
                    width: 90.w,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: AppColor.neutrals.shade100,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Images.iconQuestionQuiz,
                              height: 12,
                              width: 12,
                            ),
                            SizedBox(width: 5.h),
                            Text(
                              Strings.of(context)!.titleQuiz,
                              style: AppText.text12.copyWith(
                                color: AppColor.neutrals.shade400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${widget.quizDetailData.data?.total}",
                          style: AppText.text14.copyWith(
                            color: AppColor.neutrals.shade800,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: AppButton(
                      label: Strings.of(context)!.cancel,
                      width: 100.w,
                      height: 31.h,
                      styleLabel: AppText.text14
                          .copyWith(color: AppColor.primary.shade400),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(width: 35.w),
                  _buildButtonStart(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonStart() {
    return Center(
      child: AppButton(
        height: 31.h,
        width: 100.w,
        label: Strings.of(context)!.btnQuizNow,
        backgroundColor: AppColor.primary.shade400,
        styleLabel: AppText.text14.copyWith(color: Colors.white),
        onPressed: () {
          if (widget.canPop) {
            Navigator.of(context).pop();
          }
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) {
                return PlayQuizView(
                  quizArgument: QuizArgumentModel(
                    idQuiz: widget.quiz.id!,
                    classroomId: widget.quiz.classroomId,
                    contestId: widget.quiz.contestId,
                    roadmapId: widget.quiz.roadmapId,
                    resultId: widget.idQuiz,
                    timeQuiz: widget.quiz.duration,
                  ),
                  fromHistory: widget.fromHistory,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
