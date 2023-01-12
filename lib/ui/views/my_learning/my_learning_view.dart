import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/look_up/look_up_data.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/my_learning/my_learning_detail_view.dart';
import 'package:elearning/ui/views/my_learning/my_learning_result_view.dart';
import 'package:elearning/ui/views/my_learning/notification_activities_view.dart';
import 'package:elearning/ui/widgets/avatar_widget.dart';
import 'package:elearning/ui/widgets/shimmer_widget.dart';
import 'package:elearning/view_models/my_learning/my_learning_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyLearningView extends BaseView {
  const MyLearningView({Key? key}) : super(key: key);

  @override
  MyLearningViewState createState() => MyLearningViewState();
}

class MyLearningViewState
    extends BaseViewState<MyLearningView, MyLearningViewModel>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  bool _activeSearch = false;
  String? lastInputSearchValue;

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MyLearningViewModel()..onInitViewModel(context);
    _tabController =
        TabController(length: Constants.sizeTabBarMyLearning, vsync: this);
  }

  @override
  void onBuildCompleted() {
    super.onBuildCompleted();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: _appBar(),
        drawer: Drawer(
          child: _buildDrawer(),
        ),
        body: Column(
          children: [
            _buildProgressLearning(),
            _buildTabBar(),
            _buildMyLearning(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return _activeSearch
        ? AppBar(
            automaticallyImplyLeading: false,
            title: TextFormField(
              controller: viewModel.searchController,
              style: AppText.text16,
              autofocus: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.of(context)!.hintTextSearchMyLearning,
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColor.neutrals.shade800,
                ),
              ),
              onChanged: (value) {
                if (lastInputSearchValue != value) {
                  lastInputSearchValue = value;
                  viewModel.onSearch(_tabController.index);
                }
              },
            ),
            actions: <Widget>[
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(
                  left: 0,
                  right: 16,
                ),
                icon: Icon(
                  Icons.close,
                  color: AppColor.neutrals.shade800,
                ),
                onPressed: () {
                  setState(() => _activeSearch = false);
                  viewModel.onCloseSearch(_tabController.index);
                },
              ),
            ],
          )
        : AppBar(
            iconTheme: IconThemeData(color: AppColor.neutrals.shade800),
            title: Text(
              Strings.of(context)!.myLearning,
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(left: 0, right: 16),
                icon: SvgPicture.asset(Images.iconSearch),
                onPressed: () => setState(() => _activeSearch = true),
              ),
            ],
          );
  }

  Widget _buildProgressLearning() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: Constants.contentPaddingHorizontal,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          image: DecorationImage(
            image: AssetImage(Images.imageBackgroundProgress),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 21.w),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: AvatarWidget(
                            radius: 30.r,
                            avatar: LookUpData.avatar,
                            isSvg: LookUpData.avatarType ?? false,
                          ),
                        ),
                      ),
                      Text(
                        "15/20",
                        style: AppText.text14.copyWith(
                          color: AppColor.neutrals.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Courses",
                        style: AppText.text14
                            .copyWith(color: AppColor.yellow.shade800),
                      ),
                    ],
                  ),
                  SizedBox(width: 25.w),
                  Expanded(
                    child: Selector<MyLearningViewModel, String>(
                      selector: (_, viewModel) => viewModel.displayName,
                      builder: (_, displayName, __) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(minHeight: 60.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    Strings.of(context)!.hello,
                                    style: AppText.text16.copyWith(
                                      color: AppColor.neutrals.shade700,
                                    ),
                                  ),
                                  Text(
                                    LookUpData.displayName ?? "",
                                    style: AppText.text18.copyWith(
                                      color: AppColor.neutrals.shade800,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            LinearPercentIndicator(
                              padding: EdgeInsets.zero,
                              percent: 70 / 100,
                              restartAnimation: true,
                              lineHeight: 14.h,
                              width: 170.w,
                              animation: true,
                              animationDuration: 1000,
                              backgroundColor: Colors.white,
                              progressColor: AppColor.primary.shade400,
                              barRadius: const Radius.circular(100),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyLearning() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: buildTabBarView(),
      ),
    );
  }

  List<Widget> buildTabBarView() {
    return List.generate(
      Constants.sizeTabBarMyLearning,
      (index) => _buildPageMyLearning(index),
    );
  }

  Widget _buildTabBar() {
    return SizedBox(
      height: 27.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          isScrollable: true,
          unselectedLabelColor: AppColor.neutrals.shade800,
          padding: EdgeInsets.only(left: 17.w),
          indicatorColor: AppColor.primary.shade400,
          indicatorWeight: 4.h,
          labelStyle: AppText.text14,
          labelColor: AppColor.primary.shade400,
          tabs: [
            Tab(text: Strings.of(context)!.all),
            Tab(text: Strings.of(context)!.complete),
            Tab(text: Strings.of(context)!.registered),
          ],
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: (index) {
            viewModel.onTapChange(index);
          },
        ),
      ),
    );
  }

  Widget _buildPageMyLearning(int index) {
    return Selector<MyLearningViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoading,
      builder: (_, isLoading, __) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Selector<MyLearningViewModel, List<MyLearningModel>>(
                selector: (_, viewModel) => viewModel.myLearnings,
                shouldRebuild: (pre, next) => true,
                builder: (_, myLearning, __) {
                  return myLearning.isNotEmpty
                      ? Selector<MyLearningViewModel, bool>(
                          selector: (_, viewModel) => viewModel.isLoadMore,
                          builder: (_, isLoadMore, __) {
                            return SmartRefresher(
                              enablePullUp: isLoadMore,
                              enablePullDown: false,
                              controller: viewModel.refreshControllers[index],
                              onLoading: () {
                                viewModel.getListMyLearning(
                                  refreshController:
                                      viewModel.refreshControllers[index],
                                  isFirstLoad: false,
                                );
                              },
                              footer: CustomFooter(builder: (context, mode) {
                                return mode == LoadStatus.loading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const SizedBox();
                              }),
                              child: _buildListMyLearning(myLearning),
                            );
                          },
                        )
                      : _dataCoursesEmpty();
                },
              );
      },
    );
  }

  Widget _buildListMyLearning(List<MyLearningModel> myLearnings) {
    return ListView.separated(
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 14.h, bottom: 14.h),
      shrinkWrap: true,
      primary: false,
      itemCount: myLearnings.length,
      itemBuilder: (context, index) {
        return _buildItemMyLearning(myLearnings[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 14.h,
        );
      },
    );
  }

  Widget _buildItemMyLearning(MyLearningModel myLearning) {
    return InkWell(
      onTap: () {
        if (myLearning.id != null) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) {
                return MyLearningDetailView(
                  courseId: myLearning.id!,
                  image: myLearning.image,
                  isSvg: myLearning.isSvg,
                  nameCourse: myLearning.name ?? "",
                );
              },
            ),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(myLearning),
              SizedBox(width: 18.w),
              Expanded(
                child: _buildContent(myLearning),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(MyLearningModel myLearning) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          myLearning.name!,
          style: AppText.text18.copyWith(
            color: AppColor.neutrals.shade800,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
        Text(
          "${myLearning.dateFormat}",
          style: AppText.text14.copyWith(
            color: AppColor.neutrals.shade300,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
        const SizedBox(height: 9),
        Row(
          children: [
            SizedBox(
              width: 12.w,
              child: SvgPicture.asset(
                Images.iconStatus,
                width: 12.w,
                height: 14.h,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              decoration: BoxDecoration(
                color: AppColor.yellow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                child: Text(
                  myLearning.status!,
                  style: AppText.text14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                        child: SvgPicture.asset(
                          Images.iconProgress,
                          width: 12.w,
                          height: 14.h,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      SizedBox(
                        width: 25,
                        child: Text(
                          // TODO insert road map
                          "0%",
                          style: AppText.text14,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          Strings.of(context)!.progress,
                          style: AppText.text14
                              .copyWith(color: AppColor.neutrals.shade300),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                        child: SvgPicture.asset(
                          Images.iconRoadmap,
                          width: 12.w,
                          height: 14.h,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      SizedBox(
                        width: 25,
                        child: Text(
                          myLearning.roadmaps.length < 10
                              ? "0${myLearning.roadmaps.length}"
                              : "${myLearning.roadmaps.length}",
                          style: AppText.text14,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          Strings.of(context)!.roadMap,
                          style: AppText.text14
                              .copyWith(color: AppColor.neutrals.shade300),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                        child: SvgPicture.asset(
                          Images.iconLecture,
                          width: 12.w,
                          height: 14.h,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      SizedBox(
                        width: 25,
                        child: Text(
                          // TODO insert lecture
                          "105",
                          style: AppText.text14,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          Strings.of(context)!.lecture,
                          style: AppText.text14
                              .copyWith(color: AppColor.neutrals.shade300),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Text(
              Strings.of(context)!.joinNow,
              style: AppText.text14.copyWith(
                color: AppColor.supporting.shade600,
              ),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(
              Images.iconArrowRight,
              color: AppColor.supporting.shade600,
              width: 10,
              height: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImage(MyLearningModel myLearning) {
    return SizedBox(
      width: (135.w + 135.h) / 2,
      height: (135.w + 135.h) / 2,
      child: myLearning.isLoadingImage
          ? const ShimmerWidget(
              height: double.infinity,
              width: double.infinity,
              shapeBorder: RoundedRectangleBorder(),
            )
          : (myLearning.image != null && myLearning.isSvg
              ? SvgPicture.memory(
                  fit: BoxFit.cover,
                  myLearning.image!,
                )
              : myLearning.image != null
                  ? Image.memory(
                      fit: BoxFit.cover,
                      myLearning.image!,
                    )
                  : SvgPicture.asset(
                      Images.defaultCourses,
                      fit: BoxFit.cover,
                    )),
    );
  }

  Widget _dataCoursesEmpty() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Center(
        child: Text(
          Strings.of(context)!.myLearningEmpty,
          style: AppText.text18,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildHeaderDrawer(),
          _buildBodyDrawer(),
        ],
      ),
    );
  }

  Widget _buildHeaderDrawer() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
      ),
      child: SafeArea(
        child: SizedBox(
          height: 40,
          child: Center(
            child: Text(
              'My Page',
              style: AppText.text24.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyDrawer() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildItemBodyDrawer(
            iconPrefix: Images.iconMyResult,
            iconSuffix: Images.iconArrowRight,
            title: Strings.of(context)!.myResult,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MyLearningResultView(),
                ),
              );
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 0,
            thickness: 1,
          ),
          _buildItemBodyDrawer(
            iconPrefix: Images.iconHistory,
            iconSuffix: Images.iconArrowRight,
            title: Strings.of(context)!.historyActivity,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationActivitiesView(),
                ),
              );
            },
          ),
          Divider(
            color: Colors.grey.shade200,
            height: 0,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildItemBodyDrawer({
    String? iconPrefix,
    String? iconSuffix,
    required String? title,
    required Function() onPressed,
  }) {
    return ListTile(
      leading: iconPrefix != null
          ? Tab(
              icon: SvgPicture.asset(
                iconPrefix,
              ),
            )
          : null,
      trailing: iconSuffix != null
          ? Tab(
              icon: SvgPicture.asset(
                iconSuffix,
              ),
            )
          : null,
      title: Text(
        title!,
        style: AppText.text18,
      ),
      onTap: onPressed,
    );
  }
}
