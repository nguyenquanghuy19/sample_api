import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/data/remote/api/api_exception.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyLearningNotificationViewModel extends BaseViewModel {
  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  List<NotificationModel> listNotificationDetails = [];

  int _totalRecordNotification = 0;

  bool get isLoadMoreNotification =>
      listNotificationDetails.length < _totalRecordNotification;

  int _pageNotificationDetail = 1;

  RefreshController refreshController = RefreshController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  Future<void> onInitViewModel(BuildContext context, {int? courseId}) async {
    super.onInitViewModel(context);
    LogUtils.d("[MY_LEARNING_DETAIL_NOTIFICATION_VIEW_MODEL] => INIT");
    await getDataNotificationDetailMyLearning(courseId);
  }

  Future<void> getDataNotificationDetailMyLearning(
    int? courseId,{bool isFirstLoad = true,}
  ) async {
    try {
      if (courseId != null) {
        _isLoading = true;
        if(isFirstLoad){
          _pageNotificationDetail = 1;
          notifyListeners();
          listNotificationDetails.clear();
        }
        String param = "?Page=$_pageNotificationDetail&PerPage=10&Id=$courseId";
        final res =
            await _myLearningRepository.getNotificationDetail(param: param);
        if (res != null && res.data.isNotEmpty) {
          listNotificationDetails.addAll(res.data);
          _totalRecordNotification = res.total!;
          _pageNotificationDetail++;
        }
        _isLoading = false;
        refreshController.loadComplete();
      }
    } on Exception {
      _isLoading = false;
      refreshController.loadComplete();
      LogUtils.d(
        "[$runtimeType][GET_LIST_NOTIFICATION_MY_LEARNING_DETAIL] => ERROR",
      );
    }
    notifyListeners();
  }

  Future<void> removeNotification(int index, String newStatus) async {
    try {
      final id = listNotificationDetails[index].id!;
      listNotificationDetails.removeAt(index);
      notifyListeners();
      await _myLearningRepository.updateStatusNotification(
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
      listNotificationDetails[index].status = newStatus;
      updateUI();
      await _myLearningRepository.updateStatusNotification(
        status: newStatus,
        idNotification: listNotificationDetails[index].id!,
      );
    } on ApiException catch (e) {
      listNotificationDetails[index].status = oldStatus;
      notifyListeners();
      showToastError(
        e.failure?.message ?? Strings.of(context)!.anErrorHasOccurred,
      );
    } on Exception {
      listNotificationDetails[index].status = oldStatus;
      notifyListeners();
      showToastError(Strings.of(context)!.anErrorHasOccurred);
    }
  }
}
