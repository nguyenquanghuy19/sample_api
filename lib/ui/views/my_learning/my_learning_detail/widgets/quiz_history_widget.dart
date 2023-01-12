import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/dialog/dialog_widget.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/quiz_detail_widget.dart';
import 'package:elearning/ui/views/play_ground_quiz/quiz_result_view.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/quiz_my_learning_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class QuizHistoryWidget extends StatefulWidget {
  final QuizModel quiz;
  final QuizMyLearningViewModel viewModel;

  const QuizHistoryWidget({
    Key? key,
    required this.quiz,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<QuizHistoryWidget> createState() => _QuizHistoryWidgetState();
}

class _QuizHistoryWidgetState extends State<QuizHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: _buildHistoryQuiz(),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 16),
        child: Text(
          Strings.of(context)!.quizHistory,
          style: AppText.text18.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryQuiz() {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.quiz.detail.length,
      itemBuilder: (BuildContext context, int index) {
        final item = widget.quiz.detail[index];

        return _buildItemQuiz(item, index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: AppColor.neutrals.shade200,
          height: 0,
          endIndent: Constants.contentPaddingHorizontal,
          indent: Constants.contentPaddingHorizontal,
          thickness: 1,
        );
      },
    );
  }

  Widget _buildItemQuiz(DetailQuizModel item, int index) {
    return InkWell(
      onTap: () async {
        if (item.status == Constants.statusTakingExamQuiz) {
          if (!widget.quiz.checkQuiz()) {
            DialogWidget().showBasicDialog(
              context: context,
              title: Strings.of(context)!.titleTimeOutQuizDetail,
              content: Strings.of(context)!.contentTimeOutQuizDetail,
              positiveText: Strings.of(context)!.gotIt,
              negativeText: "",
            );

            return;
          }
          final quiz = await widget.viewModel.getQuizDetailData(
            classroomId: widget.quiz.classroomId,
            roadmapId: widget.quiz.roadmapId,
            contestId: widget.quiz.contestId,
            id: widget.quiz.id!,
          );
          if (quiz != null) {
            showDialogQuiz(quiz, item);
          }
        } else {
          DialogWidget().dioLogLoading(context: context);
          await widget.viewModel.getResultQuiz(
            classroomId: widget.quiz.classroomId,
            resultId: item.id!,
            roadmapId: widget.quiz.roadmapId,
            contestId: widget.quiz.contestId,
          );
          _backBottomSheet();
          if (widget.viewModel.dataResult != null) {
            _navigateQuizResult();
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.contentPaddingHorizontal,
          vertical: 6,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 35,
              height: 35,
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: AppColor.primary.shade400,
                elevation: 2,
                child: Center(
                  child: SvgPicture.asset(
                    Images.iconQuizType,
                    color: Colors.white,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(
                          "${Strings.of(context)!.startTime} :",
                          style: AppText.text14,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.startDate != null
                              ? DateFormat('yyyy/MM/dd HH:mm')
                                  .format(item.startDate!)
                              : "----/--/--",
                          style: AppText.text14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(
                          "${Strings.of(context)!.endTime} :",
                          style: AppText.text14,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.endDate != null
                              ? DateFormat('yyyy/MM/dd HH:mm')
                                  .format(item.endDate!)
                              : "----/--/--",
                          style: AppText.text14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(
                          "${Strings.of(context)!.status} :",
                          style: AppText.text14,
                        ),
                      ),
                      Text(
                        item.status == Constants.statusTakingExamQuiz
                            ? Strings.of(context)!.takingExam
                            : Strings.of(context)!.submitted,
                        style: AppText.text14.copyWith(
                          color: AppColor.primary.shade400,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Text(
                            item.status == Constants.statusTakingExamQuiz
                                ? Strings.of(context)!.reQuiz
                                : Strings.of(context)!.viewResult,
                            style: AppText.text14.copyWith(
                              color: AppColor.supporting.shade500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            Images.iconArrowRight,
                            color: AppColor.supporting.shade500,
                            width: 8,
                            height: 8,
                          ),
                          SvgPicture.asset(
                            Images.iconArrowRight,
                            color: AppColor.supporting.shade500,
                            width: 8,
                            height: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    color: Colors.white,
                    elevation: 2,
                    child: Center(
                      child: Text(
                        item.scoreResult?.score == null
                            ? "--"
                            : "${item.scoreResult!.score}",
                        style: AppText.text14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  Strings.of(context)!.pointCapitalized,
                  style: AppText.text14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDialogQuiz(
    QuizDetailResponse quizDetailData,
    DetailQuizModel detailQuiz,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return QuizDetailWidget(
          quizDetailData: quizDetailData,
          quiz: widget.quiz,
          idQuiz: detailQuiz.id ?? 0,
          canPop: true,
          fromHistory: true,
        );
      },
    );
  }

  void _backBottomSheet() {
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  void _navigateQuizResult() {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return QuizResultView(
            dataResult: widget.viewModel.dataResult!,
          );
        },
      ),
    );
  }
}
