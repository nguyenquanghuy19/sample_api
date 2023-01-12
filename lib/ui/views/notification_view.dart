import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/notification_widget.dart';
import 'package:elearning/ui/widgets/tab_bar_widget.dart';
import 'package:elearning/view_models/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationView extends BaseView {
  const NotificationView({Key? key}) : super(key: key);

  @override
  NotificationViewState createState() => NotificationViewState();
}

class NotificationViewState
    extends BaseViewState<NotificationView, NotificationViewModel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = NotificationViewModel()..onInitViewModel(context);
    _tabController =
        TabController(length: Constants.sizeTabBarNotification, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<NotificationViewModel, List<NotificationModel>?>(
      selector: (_, viewModel) => viewModel.getNotifications,
      shouldRebuild: (previous, next) => true,
      builder: (_, notifications, __) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Tab(
                icon: SvgPicture.asset(Images.iconArrowLeft),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              Strings.of(context)!.notifications,
            ),
            centerTitle: true,

            //TODO: pending, use for after sprint
            // actions: <Widget>[
            //   _buildIconNotification(notifications),
            // ],
          ),
          body: _buildContentNotification(notifications),
        );
      },
    );
  }

  //TODO: pending, use for after sprint
  // Widget _buildIconNotification(List<NotificationModel>? notifications) {
  //   if (notifications!.isNotEmpty) {
  //     return PopupMenuButton<String>(
  //       position: PopupMenuPosition.under,
  //       icon: SvgPicture.asset(Images.iconThreeDots),
  //       onSelected: (value) {
  //         if (value == Constants.readAllNotifications) {
  //           viewModel.handleReadNotificationAll();
  //         } else if (value == Constants.removeAllNotifications) {
  //           viewModel.handleDeleteNotificationAll();
  //         }
  //       },
  //       itemBuilder: (context) => <PopupMenuEntry<String>>[
  //         PopupMenuItem<String>(
  //           value: Constants.readAllNotifications,
  //           height: 38.h,
  //           padding: EdgeInsets.only(left: 12.w),
  //           textStyle: AppText.text16.copyWith(color: AppColor.neutrals.shade800),
  //           child: Text(
  //             Strings.of(context)!.notificationMarkReadAll,
  //           ),
  //         ),
  //         PopupMenuItem<String>(
  //           value: Constants.removeAllNotifications,
  //           height: 38.h,
  //           padding: EdgeInsets.only(left: 12.w),
  //           textStyle: AppText.text16.copyWith(color: AppColor.neutrals.shade800),
  //           child: Text(
  //             Strings.of(context)!.notificationDeleteAll,
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  //
  //   return const SizedBox.shrink();
  // }

  Widget _buildContentNotification(List<NotificationModel>? notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBarWidget(
          tabController: _tabController,
          hasLabelPadding: true,
          isScrollable: true,
          tabs: [
            Tab(text: Strings.of(context)!.general),
            Tab(text: Strings.of(context)!.account),
            Tab(text: Strings.of(context)!.course),
            Tab(text: Strings.of(context)!.titleClassRoom),
            Tab(text: Strings.of(context)!.titleQuiz),
            Tab(text: Strings.of(context)!.flashCard),
            Tab(text: Strings.of(context)!.slideShowMyLearningDetail),
          ],
          onTap: (index) {
            viewModel.handlerChangeTabBar(index);
          },
        ),
        Expanded(
          child: Selector<NotificationViewModel, bool>(
            selector: (_, viewModel) => viewModel.isLoading,
            builder: (_, isLoading, __) {
              return isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: _buildTabBarView(notifications),
                    );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTabBarView(List<NotificationModel>? notifications) {
    return List.generate(
      Constants.sizeTabBarNotification,
      (index) => _itemNotifications(index, notifications),
    );
  }

  Widget _dataNotificationEmpty() {
    return Text(
      Strings.of(context)!.defaultValueProfile,
      style: AppText.text16,
    );
  }

  Widget _itemNotifications(int index, List<NotificationModel>? notifications) {
    return Center(
      child: notifications!.isNotEmpty
          ? Selector<NotificationViewModel, bool>(
              selector: (_, viewModel) => viewModel.isLoadMore,
              builder: (_, isLoadMore, __) {
                return SmartRefresher(
                  enablePullUp: isLoadMore,
                  enablePullDown: false,
                  controller: viewModel.refreshControllers[index],
                  onLoading: () {
                    viewModel.handlerChangeTabBar(index, isFirstLoad: false);
                  },
                  footer: CustomFooter(
                    builder: (context, mode) {
                      return mode == LoadStatus.loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox();
                    },
                  ),
                  child: _buildItemNotification(notifications),
                );
              },
            )
          : _dataNotificationEmpty(),
    );
  }

  Widget _buildItemNotification(List<NotificationModel> notifications) {
    return ListView.separated(
      itemCount: notifications.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return NotificationWidget(
          notification: notifications[index],
          onDelete: () {
            viewModel.removeNotification(index, Constants.removedStatus);
          },
          onMarkRead: () {
            viewModel.markReadNotification(
              index,
              Constants.readStatus,
              notifications[index].status,
            );
          },
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
}
