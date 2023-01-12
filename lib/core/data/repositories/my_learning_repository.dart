import 'package:dio/dio.dart';
import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/data/remote/services/my_learning_service.dart';

class MyLearningRepository {
  final MyLearningService _myLearningService = MyLearningService();

  Future<DataResponseMyLearningModel?> getAllListMyLearning({
    required String param,
  }) async {
    try {
      return await _myLearningService.getAllListMyLearning(param: param);
    } on Exception {
      rethrow;
    }
  }

  Future<MyLearningDetailResponse?> getMyLearningDetailData({
    required int courseId,
  }) async {
    try {
      return await _myLearningService.getMyLearningDetailData(
        courseId: courseId,
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
      return await _myLearningService.getMemberRankMyLearningDetail(
        courseId: courseId,
        param: param,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<QuizMyLearningResponse?> getQuizMyLearningDetail({
    required String param,
  }) async {
    try {
      return await _myLearningService.getQuizMyLearningDetail(param: param);
    } on Exception {
      rethrow;
    }
  }

  Future<NotificationResponse?> getNotificationDetail({
    required String param,
  }) async {
    try {
      return await _myLearningService.getNotificationDetail(param: param);
    } on Exception {
      rethrow;
    }
  }

  Future<RoadmapResponse?> getRoadMapMyLearningDetail({
    required int courseId,
  }) async {
    try {
      return await _myLearningService.getRoadMapMyLearningDetail(
        courseId: courseId,
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
      return await _myLearningService.updateStatusNotification(
        status: status,
        idNotification: idNotification,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<Response> getAvatar(String? fileName) async {
    try {
      return await _myLearningService.getAvatar(fileName);
    } on Exception {
      rethrow;
    }
  }

  Future<TypeDataResponse?> getContentOnRoadMap({
    required String param,
  }) async {
    try {
      return await _myLearningService.getContentOnRoadMap(param: param);
    } on Exception {
      rethrow;
    }
  }

  Future<CommentModel> getCommentTeacher() async {
    try {
      return _myLearningService.getCommentTeacher();
    } on Exception {
      rethrow;
    }
  }

  Future<PlaySlideShowDataResponse?> getContentSlideShow({
    required String param,
  }) async {
    try {
      return await _myLearningService.getContentSlideShow(param: param);
    } on Exception {
      rethrow;
    }
  }
}
