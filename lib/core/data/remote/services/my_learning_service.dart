import 'package:dio/dio.dart';
import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';
import 'package:elearning/core/mock_datas/mock_teacher_comment.dart';

class MyLearningService extends BaseService {
  Future<DataResponseMyLearningModel?> getAllListMyLearning({
    required String param,
  }) async {
    return await get(
      ApiEndPointConstants.getListMyLearning,
      param: param,
      mapper: (json) =>
          DataResponseMyLearningModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<MyLearningDetailResponse?> getMyLearningDetailData({
    required int courseId,
  }) async {
    try {
      return await get(
        "${ApiEndPointConstants.getListMyLearning}/$courseId",
        mapper: (json) =>
            MyLearningDetailResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<MemberRankResponse?> getMemberRankMyLearningDetail({
    required int courseId,
    required String param,
  }) async {
    try {
      return await get(
        "${ApiEndPointConstants.getRankMemberMyClassRoom}/$courseId/member-ranks",
        param: param,
        mapper: (json) =>
            MemberRankResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<QuizMyLearningResponse?> getQuizMyLearningDetail({
    required String param,
  }) async {
    try {
      return await get(
        ApiEndPointConstants.getQuizMyClassRoom,
        param: param,
        mapper: (json) =>
            QuizMyLearningResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<NotificationResponse?> getNotificationDetail({
    required String param,
  }) async {
    try {
      return await get(
        ApiEndPointConstants.getNotificationDetail,
        param: param,
        mapper: (json) =>
            NotificationResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<RoadmapResponse?> getRoadMapMyLearningDetail({
    required int courseId,
  }) async {
    try {
      return await get(
        "${ApiEndPointConstants.getRoadMapMyLearningDetail}/$courseId/roadmaps",
        mapper: (json) =>
            RoadmapResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<NotificationResponseStatus?> updateStatusNotification({
    required String status,
    required int idNotification,
  }) async {
    try {
      return await patch(
        ApiEndPointConstants.updateStatusNotification,
        body: {"id": idNotification, "status": status},
        mapper: (json) =>
            NotificationResponseStatus.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<Response> getAvatar(String? fileName) async {
    try {
      return await getImage(
        ApiEndPointConstants.getAvatar,
        param: "?fileName=$fileName",
      );
    } on Exception {
      rethrow;
    }
  }

  Future<TypeDataResponse?> getContentOnRoadMap({
    required String param,
  }) async {
    try {
      return await get(
        ApiEndPointConstants.getContentOnRoadMap,
        param: param,
        mapper: (json) =>
            TypeDataResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<CommentModel> getCommentTeacher() async {
    return MockCommentTeacher.commentModel;
  }

  Future<PlaySlideShowDataResponse?> getContentSlideShow({
    required String param,
  }) async {
    try {
      return await get(
        ApiEndPointConstants.getContentSlideShow,
        param: param,
        mapper: (json) =>
            PlaySlideShowDataResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }
}
