import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/notification_widget.dart';
import 'package:elearning/view_models/my_learning/my_learning_detail/my_learning_notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationMyLearningWidget extends BaseView {
  final int? courseId;

  const NotificationMyLearningWidget({
    Key? key,
    this.courseId,
  }) : super(key: key);

  @override
  NotificationMyLearningWidgetState createState() =>
      NotificationMyLearningWidgetState();
}

class NotificationMyLearningWidgetState extends BaseViewState<
    NotificationMyLearningWidget, MyLearningNotificationViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MyLearningNotificationViewModel()
      ..onInitViewModel(context, courseId: widget.courseId);
  }

  @override
  void onBuildCompleted() {
    super.onBuildCompleted();
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<MyLearningNotificationViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoading,
      builder: (_, isLoading, __) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Selector<MyLearningNotificationViewModel,
                List<NotificationModel>>(
                selector: (_, viewModel) => viewModel.listNotificationDetails,
                shouldRebuild: (previous, next) => true,
                builder: (_, notifications, __) {
                  return Column(
                    children: [
                      _buildHeaderBottomSheet(),
                      Expanded(
                        child: _buildLoadMoreItemNotification(
                          notifications,
                        ),
                      ),
                    ],
                  );
                },
              );
      },
    );
  }

  Widget _buildHeaderBottomSheet() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 16),
        child: Text(
          Strings.of(context)!.notifications,
          style: AppText.text20.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadMoreItemNotification(
    List<NotificationModel> notifications,
  ) {
    return Selector<MyLearningNotificationViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoadMoreNotification,
      builder: (_, isLoadMore, __) {
        return SmartRefresher(
          enablePullUp: isLoadMore,
          enablePullDown: false,
          controller: viewModel.refreshController,
          onLoading: () {
            viewModel.getDataNotificationDetailMyLearning(
              widget.courseId,
              isFirstLoad: false,
            );
          },
          footer: CustomFooter(builder: (context, mode) {
            return mode == LoadStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox();
          }),
          child: notifications.isNotEmpty
              ? _buildListNotificationMyLearning(notifications)
              : _dataCoursesEmpty(),
        );
      },
    );
  }

  Widget _buildListNotificationMyLearning(
    List<NotificationModel> notifications,
  ) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        return NotificationWidget(
          onMarkRead: () {
            viewModel.markReadNotification(
              index,
              Constants.readStatus,
              notifications[index].status,
            );
          },
          onDelete: () {
            viewModel.removeNotification(index, Constants.removedStatus);
          },
          notification: notifications[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          thickness: 1.h,
          color: AppColor.neutrals.shade200,
          height: 0,
          indent: 20.w,
          endIndent: 20.w,
        );
      },
    );
  }

  Widget _dataCoursesEmpty() {
    return Center(
      child: Text(
        Strings.of(context)!.defaultValueProfile,
        style: AppText.text16,
      ),
    );
  }
}
