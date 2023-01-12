import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/data/remote/services/quiz_play_ground_service.dart';

class QuizDetailRepository {
  final QuizDetailService _quizDetailService = QuizDetailService();

  Future<QuizDetailResponse?> getQuizDetailData({
    required String param,
  }) async {
    try {
      return await _quizDetailService.getQuizDetailData(param: param);
    } on Exception {
      rethrow;
    }
  }

  Future<QuizPlayGroundResponse?> getDataQuizPlayGround({
    required int id,
    required int classroomId,
    required int roadMapId,
    required int contestId,
    required int? resultId,
  }) async {
    try {
      return await _quizDetailService.getDataQuizPlayGround(
        id: id,
        classroomId: classroomId,
        roadMapId: roadMapId,
        contestId: contestId,
        resultId: resultId,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<SubmitModel?> submitQuizPlayGround({
    required ParamQuizModel quizParam,
  }) async {
    try {
      return await _quizDetailService.submitQuizPlayGround(
        quizParam: quizParam,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<ResultResponseModel?> getResultQuiz(
    String param,
  ) async {
    try {
      return await _quizDetailService.getResultQuiz(param);
    } on Exception {
      rethrow;
    }
  }
}
