import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/data/remote/api/api_exception.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/data/repositories/quiz_play_ground_repository.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class QuizMyLearningViewModel extends BaseViewModel {
  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  final QuizDetailRepository _quizDetailRepository = QuizDetailRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  QuizDetailResponse? _quizDetailResponse;

  QuizDetailResponse? get quizDetailData => _quizDetailResponse;

  List<QuizModel> quizList = [];

  ResultResponseModel? resultResponse;

  DataResultModel? get dataResult => resultResponse?.data;

  @override
  Future<void> onInitViewModel(BuildContext context, {int? courseId}) async {
    super.onInitViewModel(context);
    await getDataQuizMyLearning(classRoomId: courseId);
  }

  Future<void> getDataQuizMyLearning({int? classRoomId}) async {
    try {
      if (classRoomId != null) {
        _isLoading = true;
        String param = "?classroomId=$classRoomId";
        final res =
            await _myLearningRepository.getQuizMyLearningDetail(param: param);
        if (res != null && res.data.isNotEmpty) {
          quizList.clear();
          quizList.addAll(res.data);
        }
        _isLoading = false;
      }
    } on Exception {
      _isLoading = false;
      LogUtils.d("[$runtimeType][GET_LIST_QUIZ] => ERROR");
    }
    notifyListeners();
  }

  /// Get quiz detail for dialog
  Future<QuizDetailResponse?> getQuizDetailData({
    required int? id,
    required int? classroomId,
    required int? roadmapId,
    required int? contestId,
  }) async {
    try {
      String param =
          "?Id=$id&ClassroomId=$classroomId&RoadmapId=$roadmapId&ContestId=$contestId";
      final res = await _quizDetailRepository.getQuizDetailData(param: param);
      if (res != null) {
        _quizDetailResponse = res;
      }

      return _quizDetailResponse;
    } on ApiException catch (e) {
      updateUI();
      showToastError(
        e.failure?.message ?? Strings.of(context)!.anErrorHasOccurred,
      );
    } on Exception {
      updateUI();
      showToastError(Strings.of(context)!.anErrorHasOccurred);
    }

    return null;
  }

  Future<void> getResultQuiz({
    required int classroomId,
    required int roadmapId,
    required int contestId,
    required int resultId,
  }) async {
    try {
      String param =
          "?ClassroomId=$classroomId&RoadmapId=$roadmapId&ContestId=$contestId&ResultId=$resultId";
      resultResponse = await _quizDetailRepository.getResultQuiz(param);
    } on Exception {
      LogUtils.i("Error get result");
    }
  }
}
