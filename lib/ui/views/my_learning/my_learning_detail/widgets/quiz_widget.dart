import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/dialog/dialog_widget.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/bottom_sheet_widget.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/quiz_detail_widget.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail/widgets/quiz_history_widget.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/quiz_my_learning_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class QuizWidget extends BaseView {
  final int? courseId;
  final double paddingTop;

  const QuizWidget({
    Key? key,
    required this.courseId,
    required this.paddingTop,
  }) : super(key: key);

  @override
  QuizWidgetState createState() => QuizWidgetState();
}

class QuizWidgetState
    extends BaseViewState<QuizWidget, QuizMyLearningViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = QuizMyLearningViewModel()
      ..onInitViewModel(context, courseId: widget.courseId);
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<QuizMyLearningViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoading,
      shouldRebuild: (pre, next) => true,
      builder: (_, isLoading, __) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Selector<QuizMyLearningViewModel, List<QuizModel>>(
                selector: (_, viewModel) => viewModel.quizList,
                shouldRebuild: (pre, next) => true,
                builder: (_, quizList, __) {
                  return quizList.isEmpty
                      ? Center(
                          child: Text(Strings.of(context)!.defaultValueProfile),
                        )
                      : ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          itemBuilder: (context, index) {
                            final item = quizList[index];

                            return _handlerEventItem(item);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                          itemCount: quizList.length,
                        );
                },
              );
      },
    );
  }

  Widget _handlerEventItem(QuizModel item) {
    return GestureDetector(
      onTap: () async {
        if (item.detail.length < item.remaining!) {
          if (!item.checkQuiz()) {
            DialogWidget().showBasicDialog(
              context: context,
              title: Strings.of(context)!.titleTimeOutQuizDetail,
              content: Strings.of(context)!.contentTimeOutQuizDetail,
              positiveText: Strings.of(context)!.gotIt,
              negativeText: "",
            );

            return;
          }
          final quizDetail = await viewModel.getQuizDetailData(
            classroomId: item.classroomId,
            roadmapId: item.roadmapId,
            contestId: item.contestId,
            id: item.id!,
          );
          if (quizDetail != null) {
            _showDialogQuiz(
              quizDetail,
              item.id ?? 0,
              item,
            );
          }
        }
      },
      child: _buildItemQuiz(item),
    );
  }

  Widget _buildItemQuiz(
    QuizModel item,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Constants.contentPaddingHorizontal,
        right: Constants.contentPaddingHorizontal,
        top: 4,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: _getStatusQuiz(item.status, item.openDate, item.closeDate)
                ? AppColor.supporting.shade200
                : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.iconQuizRoadMap,
                      width: 36.w,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _buildTitleInformation(item),
              _buildInformationQuiz(item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleInformation(QuizModel item) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.contestName ?? "",
            style: AppText.text16.copyWith(
              color: AppColor.neutrals.shade800,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    Images.iconTimer,
                    width: (15.h + 15.w) / 2,
                    height: (15.h + 15.w) / 2,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    item.duration != null
                        ? Strings.of(context)!.timeRemainingQuiz(item.duration!)
                        : "",
                    style: AppText.text14
                        .copyWith(color: AppColor.neutrals.shade800),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  SvgPicture.asset(
                    Images.iconArrowRotate,
                    width: (15.h + 15.w) / 2,
                    height: (15.h + 15.w) / 2,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "${item.detail.length}/${item.remaining}",
                    style: AppText.text14
                        .copyWith(color: AppColor.neutrals.shade800),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          _buildProgressDateRanger(item.openDate, item.closeDate),
        ],
      ),
    );
  }

  Widget _buildInformationQuiz(QuizModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _getStatusQuiz(item.status, item.openDate, item.closeDate)
            ? Row(
                children: [
                  SvgPicture.asset(
                    Images.iconFlash,
                    color: AppColor.greenAccent.shade300,
                  ),
                  SvgPicture.asset(
                    Images.iconFlash,
                    color: AppColor.greenAccent.shade300,
                  ),
                  SvgPicture.asset(
                    Images.iconFlash,
                    color: AppColor.greenAccent.shade300,
                  ),
                ],
              )
            : Row(
                children: [
                  SvgPicture.asset(Images.iconFlashNoColor),
                  SvgPicture.asset(Images.iconFlashNoColor),
                  SvgPicture.asset(Images.iconFlashNoColor),
                ],
              ),
        SizedBox(height: 10.h),
        InkWell(
          onTap: () {
            // TODO handle report quiz
          },
          child: Text(
            Strings.of(context)!.report,
            style: AppText.text14.copyWith(color: AppColor.supporting.shade600),
          ),
        ),
        if (item.detail.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: InkWell(
              onTap: () {
                BottomSheetWidget().showBottomSheetWidget(
                  context,
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  isScrollControlled: true,
                  content: QuizHistoryWidget(
                    quiz: item,
                    viewModel: viewModel,
                  ),
                  maxHeight: MediaQuery.of(context).size.height -
                      widget.paddingTop -
                      AppBar().preferredSize.height,
                );
              },
              child: Text(
                Strings.of(context)!.quizHistory,
                style: AppText.text14.copyWith(
                  color: AppColor.supporting.shade600,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showDialogQuiz(
    QuizDetailResponse quizDetailData,
    int idQuiz,
    QuizModel quiz,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return QuizDetailWidget(
          quizDetailData: quizDetailData,
          idQuiz: idQuiz,
          quiz: quiz,
          canPop: true,
          fromHistory: false,
        );
      },
    );
  }

  Widget _buildProgressDateRanger(DateTime? start, DateTime? end) {
    if (start == null || end == null) {
      return Container();
    }

    return Container(
      width: 150.w,
      margin: EdgeInsets.only(top: 25.h),
      child: Column(
        children: [
          LinearPercentIndicator(
            barRadius: const Radius.circular(5),
            padding: EdgeInsets.zero,
            lineHeight: 7.0,
            percent: _getPercentWithRanger(start, end),
            backgroundColor: AppColor.neutrals.shade50,
            progressColor: AppColor.neutrals.shade300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${start.day}${DateFormat('MMM').format(start)}",
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade300,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${end.day}${DateFormat('MMM').format(end)}",
                style: AppText.text14.copyWith(
                  color: AppColor.neutrals.shade300,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _getPercentWithRanger(DateTime start, DateTime end) {
    var currentDate = DateTime.now();

    if (start.isAfter(currentDate)) {
      return 0.0;
    }
    if (end.isBefore(currentDate)) {
      return 1.0;
    }
    if ((start.isBefore(currentDate) ||
            DateUtils.isSameDay(start, currentDate)) &&
        (end.isAfter(currentDate) || DateUtils.isSameDay(end, currentDate))) {
      var totalDay = _daysBetween(start, end);
      var current = _daysBetween(start, currentDate);
      var percent = current / totalDay.toDouble();

      return percent;
    }

    return 0.0;
  }

  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);

    return (to.difference(from).inHours / 24).round();
  }

  bool _getStatusQuiz(String? status, DateTime? start, DateTime? end) {
    if (status == null || start == null || end == null) {
      return false;
    }
    var currentDate = DateTime.now();

    return (start.isBefore(currentDate) ||
            DateUtils.isSameDay(start, currentDate)) &&
        (end.isAfter(currentDate) || DateUtils.isSameDay(end, currentDate)) &&
        status == Constants.statusReady;
  }
}
