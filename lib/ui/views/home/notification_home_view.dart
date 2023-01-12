import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/notification_view.dart';
import 'package:elearning/ui/widgets/notification_widget.dart';
import 'package:elearning/view_models/home/notification_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NotificationHomeView extends BaseView {
  const NotificationHomeView({
    super.key,
  });

  @override
  NotificationHomeViewState createState() => NotificationHomeViewState();
}

class NotificationHomeViewState
    extends BaseViewState<NotificationHomeView, NotificationHomeViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = NotificationHomeViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<NotificationHomeViewModel, List<NotificationModel>>(
      selector: (_, viewModel) => viewModel.getNotifications,
      shouldRebuild: (previous, next) => true,
      builder: (_, notifications, __) {
        return Column(
          children: [
            _buildHeaderBottomSheet(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildListNotificationLatest(notifications),
                    notifications.isNotEmpty
                        ? _buildTextButtonMoreNotification()
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
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

  Widget _buildListNotificationLatest(
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

  Widget _buildTextButtonMoreNotification() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Center(
        child: AppButton(
          width: 188.w,
          height: 32.h,
          label: Strings.of(context)!.showAllNotification,
          styleLabel: AppText.text16.copyWith(
            color: AppColor.primary.shade400,
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) {
                  return const NotificationView();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
