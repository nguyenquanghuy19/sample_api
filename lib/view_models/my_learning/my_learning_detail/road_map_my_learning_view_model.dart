import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/data/models/road_map_model.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/ui/views/play_ground_quiz/play_quiz_view.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class RoadMapMyLearningViewModel extends BaseViewModel {
  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  DataRoadmap? dataRoadmap;

  List<QuizModel> quizList = [];

  QuizDetailResponse? _quizDetailResponse;

  QuizDetailResponse? get quizDetailData => _quizDetailResponse;

  QuizModel _item = QuizModel();

  @override
  Future<void> onInitViewModel(BuildContext context, {int? courseId}) async {
    super.onInitViewModel(context);
    _initDataRoadMapMyLearning(courseId: courseId);
  }

  Future<void> _initDataRoadMapMyLearning({int? courseId}) async {
    _isLoading = true;
    await _getRoadMapMyLearningDetail(courseId: courseId);
    await getDataQuizMyLearning(courseId: courseId);
    _isLoading = false;
    updateUI();
  }

  Future<void> _getRoadMapMyLearningDetail({required courseId}) async {
    try {
      final res = await _myLearningRepository.getRoadMapMyLearningDetail(
        courseId: courseId,
      );
      if (res != null && res.data.isNotEmpty) {
        dataRoadmap = res.data[0];
      }
    } on Exception {
      LogUtils.d("[$runtimeType][_getRoadMapMyLearningDetail] => ERROR");
    }
  }

  Future<void> getDataQuizMyLearning({int? courseId}) async {
    try {
      if (courseId != null) {
        String param = "?classroomId=$courseId";
        final res =
            await _myLearningRepository.getQuizMyLearningDetail(param: param);
        if (res != null && res.data.isNotEmpty) {
          quizList.clear();
          quizList.addAll(res.data);
        }
      }
    } on Exception {
      LogUtils.d("[$runtimeType][GET_LIST_QUIZ] => ERROR");
    }
  }

  Future<void> handlerMoveQuizItem({int? idQuiz}) async {
    for (int i = 0; i < quizList.length; i++) {
      if (idQuiz != null && idQuiz == quizList[i].contestId) {
        _item = quizList[i];
      }
    }
    if (_item.detail.length < _item.remaining!) {
      if (!_item.checkQuiz()) return;

      _goToDoQuiz(
        id: _item.id!,
        classroomId: _item.classroomId,
        contestId: _item.contestId,
        roadmapId: _item.roadmapId,
        resultId: _item.id ?? 0,
        timeQuiz: _item.duration,
      );
    }
  }

  void _goToDoQuiz({
    required int id,
    required int classroomId,
    required int contestId,
    required int roadmapId,
    int? resultId,
    int? timeQuiz,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) {
          return PlayQuizView(
            quizArgument: QuizArgumentModel(
              idQuiz: id,
              classroomId: classroomId,
              contestId: contestId,
              roadmapId: roadmapId,
              resultId: resultId,
              timeQuiz: timeQuiz,
            ),
            isFromRoadMap: true,
            fromHistory: false,
          );
        },
      ),
    );
  }
}
