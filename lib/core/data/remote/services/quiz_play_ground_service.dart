import 'dart:convert';

import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/quiz_play_ground_model.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';

class QuizDetailService extends BaseService {
  Future<QuizDetailResponse?> getQuizDetailData({
    required String param,
  }) async {
    return await get(
      ApiEndPointConstants.getMyQuizDetail,
      param: param,
      mapper: (json) =>
          QuizDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<QuizPlayGroundResponse?> getDataQuizPlayGround({
    required int id,
    required int classroomId,
    required int roadMapId,
    required int contestId,
    required int? resultId,
  }) async {
    final body = '{"id": $id,'
        '"classroomId": $classroomId,'
        '"roadmapId": $roadMapId,'
        '"contestId": $contestId,'
        '"resultId": $resultId}';

    return await post(
      ApiEndPointConstants.getQuizPlayGround,
      body: body,
      mapper: (json) =>
          QuizPlayGroundResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<SubmitModel?> submitQuizPlayGround({
    required ParamQuizModel quizParam,
  }) async {
    final body = const JsonEncoder().convert(quizParam.toJson());

    return await post(
      ApiEndPointConstants.postQuizPlayGround,
      body: body,
      mapper: (json) => SubmitModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ResultResponseModel?> getResultQuiz(String param) async {
    return await get(
      ApiEndPointConstants.getResultQuizPlayGround,
      param: param,
      mapper: (json) =>
          ResultResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
