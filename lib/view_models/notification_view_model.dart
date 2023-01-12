import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/data/remote/api/api_exception.dart';
import 'package:elearning/core/data/repositories/notification_repository.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationViewModel extends BaseViewModel {
  TextEditingController searchController = TextEditingController();

  final NotificationRepository _notificationRepository =
      NotificationRepository();

  final List<NotificationModel> _notifications = [];

  List<RefreshController> refreshControllers = [];

  List<NotificationModel> get getNotifications => _notifications;

  bool _isLoading = false;

  int _totalRecord = 0;

  bool get isLoadMore => _notifications.length < _totalRecord;

  int _page = 1;

  bool get isLoading => _isLoading;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    _initRefreshController();
    await getNotificationData(refreshController: refreshControllers[0]);
  }

  List<RefreshController> _initRefreshController() {
    return refreshControllers = List.generate(
      Constants.sizeTabBarNotification,
      (_) => RefreshController(initialRefresh: false),
    );
  }

  Future<void> getNotificationData({
    required RefreshController refreshController,
    String type = Constants.typeGeneral,
    bool isFirstLoad = true,
  }) async {
    try {
      if (isFirstLoad) {
        _isLoading = true;
        _page = 1;
        notifyListeners();
        _notifications.clear();
      }
      String param = "?Page=$_page&Type=$type";
      final res =
          await _notificationRepository.getNotificationData(param: param);
      if (res != null && res.data.isNotEmpty) {
        _notifications.addAll(res.data);
        _totalRecord = res.total!;
        _page++;
      }
      _isLoading = false;
      refreshController.loadComplete();
      notifyListeners();
    } on Exception {
      _isLoading = false;
      refreshController.loadComplete();
      notifyListeners();
    }
  }

  void handlerChangeTabBar(int index, {bool isFirstLoad = true}) {
    _initRefreshController();
    switch (index) {
      case 0:
        getNotificationData(
          type: Constants.typeGeneral,
          refreshController: refreshControllers[index],
          isFirstLoad: isFirstLoad,
        );
        break;
      case 1:
        getNotificationData(
          type: Constants.typeAccount,
          refreshController: refreshControllers[index],
          isFirstLoad: isFirstLoad,
        );
        break;
      case 2:
        getNotificationData(
          type: Constants.typeCourse,
          refreshController: refreshControllers[index],
          isFirstLoad: isFirstLoad,
        );
        break;
      case 3:
        getNotificationData(
          type: Constants.typeClassRoom,
          refreshController: refreshControllers[index],
          isFirstLoad: isFirstLoad,
        );
        break;
      case 4:
        getNotificationData(
          type: Constants.typeQuiz,
          refreshController: refreshControllers[index],
          isFirstLoad: isFirstLoad,
        );
        break;
      case 5:
        getNotificationData(
          type: Constants.flashcard,
          refreshController: refreshControllers[index],
          isFirstLoad: isFirstLoad,
        );
        break;
      case 6:
        getNotificationData(
          type: Constants.typeSlideShow,
          refreshController: refreshControllers[index],
          isFirstLoad: isFirstLoad,
        );
        break;
    }
  }

  void handleReadNotificationAll() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i].status = Constants.readStatus;
    }
    notifyListeners();
  }

  void handleDeleteNotificationAll() {
    _notifications.clear();
    notifyListeners();
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
