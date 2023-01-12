import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/notification_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/notification_widget.dart';
import 'package:elearning/ui/widgets/tab_bar_widget.dart';
import 'package:elearning/view_models/my_learning/notification_activities_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationActivitiesView extends BaseView {
  const NotificationActivitiesView({Key? key}) : super(key: key);

  @override
  NotificationActivitiesViewState createState() =>
      NotificationActivitiesViewState();
}

class NotificationActivitiesViewState extends BaseViewState<
    NotificationActivitiesView,
    NotificationActivitiesViewModel> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSearch = false;

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = NotificationActivitiesViewModel()..onInitViewModel(context);
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Selector<NotificationActivitiesViewModel, List<NotificationModel>>(
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
            titleSpacing: 0.0,
            title: isSearch
                ? TextField(
                    controller: viewModel.searchController,
                    style: AppText.text16,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: Strings.of(context)!.searchTitle,
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(30.0.r),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.trim().isNotEmpty) {
                        viewModel.onChange(_tabController.index);
                      }
                    },
                  )
                : Text(
                    Strings.of(context)!.historyActivity,
                  ),
            centerTitle: true,

            //TODO: pending, use for after sprint
            // actions: <Widget>[
            //   IconButton(
            //     splashRadius: 30.r,
            //     onPressed: () {
            //       setState(
            //         () {
            //           isSearch = !isSearch;
            //           if (!isSearch) {
            //             viewModel.onChange(
            //               _tabController.index,
            //               isCloseSearch: true,
            //             );
            //           }
            //         },
            //       );
            //     },
            //     icon: isSearch
            //         ? const Icon(Icons.close)
            //         : const Icon(Icons.search),
            //   ),
            //   if (!isSearch) _buildIconNotification(notifications),
            // ],
          ),
          body: _buildContentNotification(notifications),
        );
      },
    );
  }

  //TODO: pending, use for after sprint
  // Widget _buildIconNotification(List<NotificationModel> notifications) {
  //   return PopupMenuButton<String>(
  //     position: PopupMenuPosition.under,
  //     icon: SvgPicture.asset(Images.iconThreeDots),
  //     onSelected: (value) {
  //       if (value == Constants.readAllNotifications) {
  //         viewModel.handleReadNotificationAll();
  //       } else if (value == Constants.removeAllNotifications) {
  //         viewModel.handleDeleteNotificationAll();
  //       }
  //     },
  //     itemBuilder: (context) => <PopupMenuEntry<String>>[
  //       if (notifications.isNotEmpty)
  //         PopupMenuItem<String>(
  //           value: Constants.readAllNotifications,
  //           height: 38.h,
  //           padding: EdgeInsets.only(left: 12.w),
  //           textStyle: AppText.text16.copyWith(color: AppColor.neutrals.shade800),
  //           child: Text(
  //             Strings.of(context)!.notificationMarkReadAll,
  //           ),
  //         ),
  //       if (notifications.isNotEmpty)
  //         PopupMenuItem<String>(
  //           value: Constants.removeAllNotifications,
  //           height: 38.h,
  //           padding: EdgeInsets.only(left: 12.w),
  //           textStyle: AppText.text16.copyWith(color: AppColor.neutrals.shade800),
  //           child: Text(
  //             Strings.of(context)!.notificationDeleteAll,
  //           ),
  //         ),
  //     ],
  //   );
  // }

  Widget _buildContentNotification(List<NotificationModel>? notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBarWidget(
          tabController: _tabController,
          hasLabelPadding: true,
          isScrollable: true,
          tabs: [
            Tab(text: Strings.of(context)!.general),
            Tab(text: Strings.of(context)!.course),
            Tab(text: Strings.of(context)!.titleQuiz),
            Tab(text: Strings.of(context)!.flashCard),
            Tab(text: Strings.of(context)!.slideShowMyLearningDetail),
          ],
          onTap: (index) {
            viewModel.handlerChangeTabBar(index);
          },
        ),
        Expanded(
          child: Selector<NotificationActivitiesViewModel, bool>(
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
      5,
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
          ? Selector<NotificationActivitiesViewModel, bool>(
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
