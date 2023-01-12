import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/data/remote/services/notification_service.dart';

class NotificationRepository {
  final NotificationService _notificationService = NotificationService();

  Future<NotificationResponse?> getNotificationData({
    required String param,
  }) async {
    try {
      return await _notificationService.getNotificationData(param: param);
    } on Exception {
      rethrow;
    }
  }

  Future<NotificationResponseStatus?> updateStatusNotification({
    required String status,
    required int idNotification,
  }) async {
    try {
      return await _notificationService.updateStatusNotification(
        status: status,
        idNotification: idNotification,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<NotificationResponse?> getMyNotification({String? param}) async {
    try {
      return await _notificationService.getMyNotification(param: param);
    } on Exception {
      rethrow;
    }
  }

  Future<NotificationResponse?> getNotificationActivities({
    String? param,
  }) async {
    try {
      return await _notificationService.getNotificationActivities(param: param);
    } on Exception {
      rethrow;
    }
  }

  Future<StatusNotificationModel?> getStatusNotification() async {
    try {
      return await _notificationService.getStatusNotification();
    } on Exception {
      rethrow;
    }
  }

  Future<NotificationResponse?> getLatestNotification() async {
    try {
      return await _notificationService.getLatestNotification();
    } on Exception {
      rethrow;
    }
  }
}
