import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/play_ground_quiz/play_ground_quiz_widget/card_result_quiz_widget.dart';
import 'package:elearning/view_models/play_ground_quiz/quiz_result_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QuizResultView extends BaseView {
  final DataResultModel dataResult;

  const QuizResultView({
    Key? key,
    required this.dataResult,
  }) : super(key: key);

  @override
  QuizResultViewState createState() => QuizResultViewState();
}

class QuizResultViewState
    extends BaseViewState<QuizResultView, QuizResultViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = QuizResultViewModel()..onInitViewModel(context);
    viewModel.inItData(widget.dataResult);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: SingleChildScrollView(
        controller: viewModel.scrollController,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: CardResultQuizWidget(
                idQuiz: "${viewModel.dataResult.calQuizCode}",
                courseName: "${viewModel.dataResult.classroomName}",
                studentName: "${viewModel.dataResult.displayName}",
                quizTime: DateFormat('yyyy/MM/dd HH:mm')
                    .format(viewModel.dataResult.startDate!),
                pointQuiz: "${viewModel.dataResult.scoreResult!.score}",
                //ToDo: show data from BE (waiting)
                timeDoQuiz: "0",
                questionQuiz:
                    "${viewModel.dataResult.scoreResult!.scorePass}/${viewModel.dataResult.scoreResult!.scoreTotal}",
                //ToDo: show data from BE (waiting)
                numberQuiz: "1/1",
                //ToDo: handle pass
                isPass: true,
              ),
            ),
            _buildContentQuizResult(),
            const SizedBox(height: 50),
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: AppColor.primary.shade50,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                viewModel.handleOnChangePage(
                  viewModel.indexReducePage,
                );
              },
              child: SvgPicture.asset(
                Images.iconArrowLeftQuiz,
                width: 26.w,
                height: 26.h,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: _buildListItemPageBottom(),
              ),
            ),
            InkWell(
              onTap: () {
                viewModel.handleOnChangePage(
                  viewModel.indexIncreasePage,
                );
              },
              child: SvgPicture.asset(
                Images.iconArrowRightQuiz,
                width: 26.w,
                height: 26.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text(
        "${viewModel.dataResult.quizName}",
        style: AppText.text16.copyWith(fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.close),
        color: Colors.black,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: AppButton(
            width: 85.w,
            label: Strings.of(context)!.report,
            styleLabel: AppText.text14.copyWith(
              color: AppColor.neutrals.shade800,
            ),
            onPressed: () {
              // [TODO] Handler onTap button report quiz
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListItemPageBottom() {
    return Center(
      child: Selector<QuizResultViewModel, int>(
        selector: (_, viewModel) => viewModel.indexPage,
        shouldRebuild: (pre, next) => true,
        builder: (_, indexPage, __) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 5),
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.numberPage,
            itemBuilder: (context, index) {
              return _buildItemPageBottom(
                countPage: "${index + 1}",
                colorItemActive: index == indexPage,
                index: index,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 5,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildItemPageBottom({
    required String countPage,
    required bool colorItemActive,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        viewModel.handleOnChangePage(index);
      },
      child: Container(
        width: 30,
        height: 38,
        decoration: BoxDecoration(
          color: colorItemActive
              ? AppColor.blueAccent.shade800
              : AppColor.neutrals.shade50,
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.neutrals.shade300,
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Text(
            countPage,
            style: AppText.text16.copyWith(
              fontWeight: FontWeight.w700,
              color:
                  colorItemActive ? Colors.white : AppColor.neutrals.shade800,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentQuizResult() {
    return Selector<QuizResultViewModel, List<ItemQuizModel>>(
      selector: (_, viewModel) => viewModel.listPerPage,
      shouldRebuild: (pre, next) => true,
      builder: (_, listPerPage, __) {
        return ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleQuestion(index, listPerPage[index]),
                _buildAnswerQuestion(listPerPage[index]),
              ],
            );
          },
          itemCount: listPerPage.length,
        );
      },
    );
  }

  Widget _buildTitleQuestion(int index, ItemQuizModel quiz) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.of(context)!.titleQuestions("${index + 1}"),
            style: AppText.text14.copyWith(
              color: AppColor.neutrals.shade800,
              fontWeight: FontWeight.w700,
            ),
          ),
          (quiz.question != null && quiz.question != "")
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                  child: Text(
                    "${quiz.question}",
                    style: AppText.text14
                        .copyWith(color: AppColor.neutrals.shade800),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildAnswerQuestion(ItemQuizModel quiz) {
    return Container(
      color: AppColor.neutrals.shade50,
      width: double.infinity,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (quiz.answerType == Constants.inputAnswer ||
              quiz.answerType == Constants.dropAnswer) {
            return _buildItemAnswerInput(quiz, index);
          }

          return _buildItemAnswerMultipleAndSingle(quiz, index);
        },
        itemCount: quiz.result.length,
      ),
    );
  }

  Widget _buildItemAnswerMultipleAndSingle(ItemQuizModel quiz, int index) {
    return quiz.correct[index] == true
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                quiz.correct[index] == quiz.result[index]
                    ? Icon(
                        Icons.check_circle,
                        size: 25.h,
                        color: AppColor.greenAccent.shade900,
                      )
                    : Icon(
                        Icons.clear,
                        size: 25.h,
                        color: AppColor.redApp,
                      ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    quiz.answer[index],
                    style: AppText.text14.copyWith(
                      color: AppColor.neutrals.shade800,
                    ),
                  ),
                ),
                Icon(
                  FontAwesomeIcons.solidCommentDots,
                  size: 23.h,
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildItemAnswerInput(ItemQuizModel quiz, int index) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          quiz.result[index]
              ? Icon(
                  Icons.check_circle,
                  size: 25.h,
                  color: AppColor.greenAccent.shade900,
                )
              : Icon(
                  Icons.clear,
                  size: 25.h,
                  color: AppColor.redApp,
                ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Text(
              quiz.correct[index],
              style: AppText.text14.copyWith(
                color: AppColor.neutrals.shade800,
              ),
            ),
          ),
          Icon(
            FontAwesomeIcons.solidCommentDots,
            size: 23.h,
          ),
        ],
      ),
    );
  }
}
