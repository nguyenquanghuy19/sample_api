import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/data/remote/api/api_exception.dart';
import 'package:elearning/core/data/repositories/notification_repository.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class NotificationHomeViewModel extends BaseViewModel {
  final NotificationRepository _notificationRepository =
      NotificationRepository();

  final List<NotificationModel> _notifications = [];

  List<NotificationModel> get getNotifications => _notifications;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    await _getLatestNotification();
  }

  Future<void> _getLatestNotification() async {
    try {
      final res = await _notificationRepository.getLatestNotification();
      if (res != null && res.data.isNotEmpty) {
        _notifications.clear();
        _notifications.addAll(res.data);
      }
    } on Exception {
      LogUtils.i("Error get status Notification");
    }
    updateUI();
  }

  Future<void> removeNotification(
    int index,
    String newStatus,
  ) async {
    try {
      final id = _notifications[index].id!;
      _notifications.removeAt(index);
      notifyListeners();
      await _notificationRepository.updateStatusNotification(
        status: newStatus,
        idNotification: id,
      );
    } on ApiException catch (e) {
      showToastError(
        e.failure?.message ?? Strings.of(context)!.anErrorHasOccurred,
      );
    } on Exception {
      showToastError(Strings.of(context)!.anErrorHasOccurred);
    }
  }

  Future<void> markReadNotification(
    int index,
    String newStatus,
    String? oldStatus,
  ) async {
    try {
      _notifications[index].status = newStatus;
      updateUI();
      await _notificationRepository.updateStatusNotification(
        status: newStatus,
        idNotification: _notifications[index].id!,
      );
    } on ApiException catch (e) {
      _notifications[index].status = oldStatus;
      notifyListeners();
      showToastError(
        e.failure?.message ?? Strings.of(context)!.anErrorHasOccurred,
      );
    } on Exception {
      _notifications[index].status = oldStatus;
      notifyListeners();
      showToastError(Strings.of(context)!.anErrorHasOccurred);
    }
  }
}
