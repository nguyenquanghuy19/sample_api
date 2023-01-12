import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/dialog/dialog_widget.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/play_ground_quiz/play_ground_quiz_widget/drop_answer_widget.dart';
import 'package:elearning/ui/views/play_ground_quiz/quiz_result_view.dart';
import 'package:elearning/view_models/play_ground_quiz/play_quiz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PlayQuizView extends BaseView {
  final QuizArgumentModel quizArgument;
  final bool isFromRoadMap;
  final bool fromHistory;

  const PlayQuizView({
    Key? key,
    required this.quizArgument,
    this.isFromRoadMap = false,
    required this.fromHistory,
  }) : super(key: key);

  @override
  PlayQuizViewState createState() => PlayQuizViewState();
}

class PlayQuizViewState extends BaseViewState<PlayQuizView, PlayQuizViewModel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = PlayQuizViewModel()..onInitViewModel(context);
    viewModel.initData(
      widget.quizArgument,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: widget.quizArgument.timeQuiz ?? 0),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<PlayQuizViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoading,
      builder: (_, isLoading, __) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: GestureDetector(
            onTap: () =>
                FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Selector<PlayQuizViewModel, List<ItemQuizModel>>(
                          selector: (_, viewModel) => viewModel.listPerPage,
                          shouldRebuild: (pre, next) => true,
                          builder: (_, listPerPage, __) {
                            return listPerPage.isNotEmpty
                                ? SingleChildScrollView(
                                    controller: viewModel.scrollController,
                                    child: _buildListQuizItem(listPerPage),
                                  )
                                : Center(
                                    child: Text(
                                      Strings.of(context)!.defaultValueProfile,
                                      style: AppText.text16,
                                    ),
                                  );
                          },
                        ),
                      ),
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
      },
    );
  }

  Widget _buildListItemPageBottom() {
    return Center(
      child: Selector<PlayQuizViewModel, int>(
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
              return const SizedBox(width: 5);
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

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Images.iconTimerQuiz,
            width: 18.w,
            height: 18.h,
          ),
          SizedBox(width: 9.w),
          CountDownTime(
            animation: StepTween(
              begin: widget.quizArgument.timeQuiz != null
                  ? widget.quizArgument.timeQuiz! * Constants.valueTime
                  : 0,
              end: Constants.zeroValueDefault,
            ).animate(_controller)
              ..addListener(() {
                if (_controller.value == 1) {
                  DialogWidget().showBasicDialog(
                    context: context,
                    title: Strings.of(context)!.titleTimeOutQuizDetail,
                    content: Strings.of(context)!.contentTimeOutQuizDetail,
                    positiveText: Strings.of(context)!.gotIt,
                    negativeText: "",
                    positiveOnClickListener: () async {
                      Navigator.of(context).pop();
                      DialogWidget().dioLogLoading(context: context);
                      await viewModel
                          .onSubmitQuizPlayGround(widget.isFromRoadMap);
                      _backDialogLoading();
                      if (viewModel.dataResult != null) {
                        _navigateQuizResult();
                      }
                    },
                  );
                  _controller.stop();
                }
              }),
          ),
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.close),
        color: Colors.black,
        onPressed: () {
          DialogWidget().showBasicDialog(
            context: context,
            content: Strings.of(context)!.confirmCloseQuizAnswer,
            positiveOnClickListener: () {
              if (widget.isFromRoadMap) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
          );
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: AppButton(
            width: 85.w,
            isDisableButton: viewModel.resultId == null,
            label: Strings.of(context)!.labelButtonSubmit,
            onPressed: () async {
              if (viewModel.resultId != null) {
                if (viewModel.getNumberNotAnswer() != 0) {
                  DialogWidget().showBasicDialog(
                    context: context,
                    content: Strings.of(context)!
                        .confirmSubmitQuiz(viewModel.getNumberNotAnswer()),
                    positiveOnClickListener: () async {
                      DialogWidget().dioLogLoading(context: context);
                      await viewModel
                          .onSubmitQuizPlayGround(widget.isFromRoadMap);
                      _backDialogLoading();
                      if (viewModel.dataResult != null) {
                        _navigateQuizResult();
                      }
                    },
                  );
                } else {
                  DialogWidget().showBasicDialog(
                    context: context,
                    content: Strings.of(context)!.confirmSubmitAnswer,
                    positiveOnClickListener: () async {
                      DialogWidget().dioLogLoading(context: context);
                      await viewModel
                          .onSubmitQuizPlayGround(widget.isFromRoadMap);
                      _backDialogLoading();
                      if (viewModel.dataResult != null) {
                        _navigateQuizResult();
                      }
                    },
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }

  void _navigateQuizResult() {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) {
          return QuizResultView(
            dataResult: viewModel.dataResult!,
          );
        },
      ),
    );
  }

  void _backDialogLoading() {
    if(widget.fromHistory){
      Navigator.of(context).pop();
    }
    Navigator.of(context, rootNavigator: true).pop();
  }

  Widget _buildListQuizItem(List<ItemQuizModel> itemsQuiz) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleQuestion(itemsQuiz, index),
            _buildAnswerQuestion(itemsQuiz[index]),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox.shrink();
      },
      itemCount: itemsQuiz.length,
    );
  }

  Widget _buildTitleQuestion(List<ItemQuizModel> itemsQuiz, int index) {
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
            style: AppText.text16.copyWith(
              color: AppColor.neutrals.shade800,
              fontWeight: FontWeight.w700,
            ),
          ),
          (itemsQuiz[index].question != null && itemsQuiz[index].question != "")
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                  child: Text(
                    itemsQuiz[index].question ?? "",
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
      padding: EdgeInsets.symmetric(
        vertical:
            quiz.answerType == Constants.dropAnswer ? Constants.zeroValue : 6,
      ),
      child: _buildContentAnswer(
        typeInput: quiz.answerType,
        quiz: quiz,
      ),
    );
  }

  Widget _buildContentAnswer({
    String? typeInput,
    required ItemQuizModel quiz,
  }) {
    switch (typeInput) {
      case Constants.multipleAnswers:
        return _buildMultipleAnswers(quiz);
      case Constants.singleAnswer:
        return _buildSingleAnswer(quiz);
      case Constants.dropAnswer:
        return DropAnswerWidget(
          answers: quiz.answer,
          callBack: (answers) {
            viewModel.onChangeAnswerDrop(answers, quiz);
          },
        );
      case Constants.inputAnswer:
        return _buildInputAnswer(quiz);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildMultipleAnswers(ItemQuizModel quiz) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildItemMultipleAnswers(
          quiz.answer[index],
          index,
          quiz,
          quiz.answerMultiple[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox.shrink();
      },
      itemCount: quiz.answer.length,
    );
  }

  Widget _buildItemMultipleAnswers(
    String answer,
    int indexAnswer,
    ItemQuizModel quiz,
    bool value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
          side: BorderSide(color: AppColor.neutrals.shade800, width: 2.w),
          checkColor: Colors.white,
          activeColor: AppColor.primary.shade400,
          value: value,
          onChanged: (bool? value) {
            if (value != null) {
              viewModel.onCheckedMultipleAnswers(indexAnswer, value, quiz);
            }
          },
        ),
        SizedBox(width: 5.w),
        Text(
          answer,
          style: AppText.text14.copyWith(color: AppColor.neutrals.shade800),
        ),
      ],
    );
  }

  Widget _buildSingleAnswer(ItemQuizModel quiz) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildItemSingleAnswer(
          quiz.answer[index],
          index,
          quiz,
        );
      },
      itemCount: quiz.answer.length,
    );
  }

  Widget _buildItemSingleAnswer(
    String answer,
    int indexAnswer,
    ItemQuizModel quiz,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio(
          value: answer,
          groupValue: quiz.answerSingle,
          onChanged: (value) {
            viewModel.onCheckedSingleAnswer(answer, quiz);
          },
          activeColor: AppColor.primary.shade400,
          fillColor: MaterialStateColor.resolveWith(
            (states) => quiz.answerSingle == answer
                ? AppColor.primary.shade400
                : AppColor.neutrals.shade800,
          ),
        ),
        SizedBox(width: 5.w),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: answer,
                style:
                    AppText.text14.copyWith(color: AppColor.neutrals.shade800),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputAnswer(ItemQuizModel quiz) {
    return AnswerInputWidget(
      answer: quiz.answerInput,
      onChanged: (answer) {
        viewModel.onChangeAnswerInput(answer, quiz);
      },
    );
  }
}

class AnswerInputWidget extends StatefulWidget {
  final String? answer;
  final Function(String?) onChanged;

  const AnswerInputWidget({
    Key? key,
    this.answer,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<AnswerInputWidget> createState() => _AnswerInputWidgetState();
}

class _AnswerInputWidgetState extends State<AnswerInputWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.answer ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: AppInput(
        controller: controller,
        hintText: Strings.of(context)!.hintTextInputTypeQuiz,
        contentPaddingVertical: 10.h,
        textFormFieldStyle:
            AppText.text16.copyWith(fontWeight: FontWeight.bold),
        onChanged: (value) {
          widget.onChanged(value);
        },
      ),
    );
  }
}

class CountDownTime extends AnimatedWidget {
  final Animation<int> animation;

  const CountDownTime({
    Key? key,
    required this.animation,
  }) : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerDown =
        '${clockTimer.inHours.remainder(60).toString().padLeft(2, '0')}'
        ':${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}'
        ':${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      timerDown,
      style: AppText.text16.copyWith(
        color: AppColor.neutrals.shade800,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
