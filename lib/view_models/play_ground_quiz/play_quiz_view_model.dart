import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/data/repositories/quiz_play_ground_repository.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/quiz_my_learning_view_model.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/road_map_my_learning_view_model.dart';
import 'package:flutter/material.dart';

class PlayQuizViewModel extends BaseViewModel {
  final QuizDetailRepository _quizDetailRepository = QuizDetailRepository();

  ScrollController scrollController = ScrollController();

  QuizPlayGroundResponse? _quizPlayGroundResponse;

  QuizPlayGroundModel? get quizDataPlayGround => _quizPlayGroundResponse?.data;

  List<ItemQuizModel> get listItemQuiz =>
      _quizPlayGroundResponse?.data?.items ?? [];

  int _numberPage = 0;

  int get numberPage => _numberPage;

  int indexPage = Constants.zeroValueDefault;

  int get indexReducePage => indexPage >= 1 ? --indexPage : indexPage;

  int get indexIncreasePage =>
      indexPage < (numberPage - 1) ? ++indexPage : indexPage;

  List<ItemQuizModel> listPerPage = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool isSubmitting = false;

  String? _valueRadioQuiz;

  String? get valueRadioQuiz => _valueRadioQuiz;
  late QuizArgumentModel _quizArgument;

  ResultResponseModel? resultResponse;

  DataResultModel? get dataResult => resultResponse?.data;
  int? _resultId;

  int? get resultId => _resultId;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
  }

  Future<void> initData(
    QuizArgumentModel quizArgument,
  ) async {
    _quizArgument = quizArgument;
    await _getRoadMapMyLearningDetail(
      idQuiz: quizArgument.idQuiz,
      classroomId: quizArgument.classroomId,
      roadMapId: quizArgument.roadmapId,
      contestId: quizArgument.contestId,
      resultId: quizArgument.resultId,
    );
    _handleIndexPage();
  }

  Future<void> _getRoadMapMyLearningDetail({
    required int idQuiz,
    required int classroomId,
    required int roadMapId,
    required int contestId,
    required int? resultId,
  }) async {
    try {
      _isLoading = true;
      final res = await _quizDetailRepository.getDataQuizPlayGround(
        id: idQuiz,
        classroomId: classroomId,
        roadMapId: roadMapId,
        contestId: contestId,
        resultId: resultId,
      );
      if (res != null) {
        _quizPlayGroundResponse = res;
        _resultId = res.data?.id;
        _handlerPerPage();
      }
      _isLoading = false;
    } on Exception {
      _isLoading = false;
      LogUtils.d("[GET_LIST_QUIZ] => ERROR");
    }
    updateUI();
    final myLeaningQuizViewModel =
        notifierList.whereType<QuizMyLearningViewModel>().first;
    myLeaningQuizViewModel.getDataQuizMyLearning(
      classRoomId: classroomId,
    );
  }

  Future<void> onSubmitQuizPlayGround(bool isFormRoadMap) async {
    try {
      if (_resultId == null) {
        return;
      }
      isSubmitting = true;
      ParamQuizModel paramQuiz =
          ParamQuizModel(id: _resultId!, result: listItemQuiz);
      final res = await _quizDetailRepository.submitQuizPlayGround(
        quizParam: paramQuiz,
      );
      if (res != null && res.status == Constants.statusSubmit) {
        await getResultQuiz();
      }
      isSubmitting = false;
      updateUI();
    } on Exception {
      LogUtils.d("[POST_SUBMIT_QUIZ_ERROR] => ERROR");
      isSubmitting = false;
      updateUI();
    }
    if (isFormRoadMap) {
      final myLeaningQuizViewModel =
          notifierList.whereType<RoadMapMyLearningViewModel>().first;
      myLeaningQuizViewModel.getDataQuizMyLearning(
        courseId: _quizArgument.classroomId,
      );
    } else {
      final myLeaningQuizViewModel =
          notifierList.whereType<QuizMyLearningViewModel>().first;
      myLeaningQuizViewModel.getDataQuizMyLearning(
        classRoomId: _quizArgument.classroomId,
      );
    }
  }

  Future<void> getResultQuiz() async {
    try {
      String param =
          "?ClassroomId=${_quizArgument.classroomId}&RoadmapId=${_quizArgument.roadmapId}&ContestId=${_quizArgument.contestId}&ResultId=$_resultId";
      resultResponse = await _quizDetailRepository.getResultQuiz(param);
    } on Exception {
      LogUtils.i("Error get result");
    }
  }

  void _handlerPerPage() {
    listPerPage.clear();
    final value = (listItemQuiz.length >
            (indexPage + Constants.pageFirstValue) * Constants.pageQuizDefault)
        ? (indexPage + Constants.pageFirstValue) * Constants.pageQuizDefault
        : listItemQuiz.length;
    for (int i = indexPage * Constants.pageQuizDefault; i < value; i++) {
      listPerPage.add(listItemQuiz[i]);
    }
    updateUI();
  }

  void _handleIndexPage() {
    _numberPage = listItemQuiz.length % Constants.pageQuizDefault ==
            Constants.zeroValueDefault
        ? listItemQuiz.length ~/ Constants.pageQuizDefault
        : listItemQuiz.length ~/ Constants.pageQuizDefault +
            Constants.pageFirstValue;
  }

  void handleOnChangePage(int index) {
    indexPage = index;
    _handlerPerPage();
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 1),
    );
    updateUI();
  }

  void onCheckedMultipleAnswers(
    int indexAnswer,
    bool value,
    ItemQuizModel quiz,
  ) {
    quiz.answerMultiple[indexAnswer] = value;
    updateUI();
  }

  void onCheckedSingleAnswer(String answer, ItemQuizModel quiz) {
    quiz.answerSingle = answer;
    updateUI();
  }

  void onChangeAnswerInput(String? answer, ItemQuizModel quiz) {
    quiz.answerInput = answer;
    updateUI();
  }

  void onChangeAnswerDrop(List<String> answers, ItemQuizModel quiz) {
    quiz.correct = answers;
  }

  int getNumberNotAnswer() {
    int numberNotAnswer = 0;
    for (int i = 0; i < listItemQuiz.length; i++) {
      if (!listItemQuiz[i].isAnswer) {
        numberNotAnswer++;
      }
    }

    return numberNotAnswer;
  }
}
