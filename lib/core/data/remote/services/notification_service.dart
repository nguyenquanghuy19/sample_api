import 'package:elearning/core/constants/api_end_point.dart';
import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/data/remote/services/base_service.dart';

class NotificationService extends BaseService {
  Future<NotificationResponse?> getNotificationData({
    required String param,
  }) async {
    try {
      return await get(
        ApiEndPointConstants.getNotifications,
        param: param,
        mapper: (json) =>
            NotificationResponse.fromJson(json as Map<String, dynamic>),
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

  Future<NotificationResponse?> getMyNotification({String? param}) async {
    try {
      return await get(
        ApiEndPointConstants.getMyNotification,
        param: param,
        mapper: (json) =>
            NotificationResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<NotificationResponse?> getNotificationActivities({
    String? param,
  }) async {
    try {
      return await get(
        ApiEndPointConstants.getNotificationActivities,
        param: param,
        mapper: (json) =>
            NotificationResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<StatusNotificationModel?> getStatusNotification() async {
    try {
      return await get(
        ApiEndPointConstants.getStatusNotification,
        mapper: (json) =>
            StatusNotificationModel.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }

  Future<NotificationResponse?> getLatestNotification() async {
    try {
      return await get(
        ApiEndPointConstants.getLatestNotification,
        mapper: (json) =>
            NotificationResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Exception {
      rethrow;
    }
  }
}
