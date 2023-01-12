import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/views/course/course_detail_view.dart';
import 'package:elearning/ui/widgets/item_course_widget.dart';
import 'package:elearning/ui/widgets/tab_bar_widget.dart';
import 'package:elearning/view_models/course/list_courses_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListCoursesView extends BaseView {
  const ListCoursesView({super.key});

  @override
  ListCoursesViewState createState() => ListCoursesViewState();
}

class ListCoursesViewState
    extends BaseViewState<ListCoursesView, ListCoursesViewModel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _activeSearch = false;

  String? lastInputSearchValue;

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ListCoursesViewModel()..onInitViewModel(context);
    _tabController =
        TabController(length: Constants.sizeTabBarLecture, vsync: this);
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
        appBar: _appBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTabBar(),
            _searchCoursesDate(),
          ],
        ),
      ),
    );
  }

  /// CUSTOM APP BAR TO SEARCH VIEW
  PreferredSizeWidget _appBar() {
    return _activeSearch
        ? AppBar(
            title: TextFormField(
              controller: viewModel.searchController,
              style: AppText.text16,
              autofocus: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Strings.of(context)!.hintTextSearchCourses,
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
            title: Text(
              Strings.of(context)!.titleCourses,
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

  Widget _searchCoursesDate() {
    return Expanded(
      child: Selector<ListCoursesViewModel, bool>(
        selector: (_, viewModel) => viewModel.isLoading,
        builder: (_, isLoading, __) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Selector<ListCoursesViewModel, bool>(
                  selector: (_, viewModel) => viewModel.isLoadMore,
                  builder: (_, isLoadMore, __) {
                    return Selector<ListCoursesViewModel, List<CourseModel>>(
                      selector: (_, viewModel) => viewModel.courses,
                      shouldRebuild: (pre, next) => true,
                      builder: (_, courses, __) {
                        return TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            _buildListCourseLatest(isLoadMore, courses),
                            _buildListCourseDaily(isLoadMore, courses),
                            _buildListCourseWeekLy(isLoadMore, courses),
                            _buildListCourseMonthLy(isLoadMore, courses),
                          ],
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBarWidget(
      tabController: _tabController,
      hasLabelPadding: false,
      isScrollable: false,
      tabs: [
        Tab(text: Strings.of(context)!.latest),
        Tab(text: Strings.of(context)!.daily),
        Tab(text: Strings.of(context)!.weekly),
        Tab(text: Strings.of(context)!.monthly),
      ],
      onTap: (index) {
        viewModel.onTapChange(index);
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

  Widget _buildListCourseLatest(bool isLoadMore, List<CourseModel> courses) {
    return SmartRefresher(
      enablePullUp: isLoadMore,
      enablePullDown: false,
      controller: viewModel.refreshControllerLatest,
      onLoading: () {
        viewModel.getDataCourses(
          refreshController: viewModel.refreshControllerLatest,
          isFirstLoad: false,
        );
      },
      footer: CustomFooter(builder: (context, mode) {
        return mode == LoadStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox();
      }),
      child:
          courses.isNotEmpty ? _buildItemCourses(courses) : _dataCoursesEmpty(),
    );
  }

  Widget _buildListCourseDaily(bool isLoadMore, List<CourseModel> courses) {
    return SmartRefresher(
      enablePullUp: isLoadMore,
      enablePullDown: false,
      controller: viewModel.refreshControllerDaily,
      onLoading: () {
        viewModel.getDataCourses(
          refreshController: viewModel.refreshControllerDaily,
          isFirstLoad: false,
        );
      },
      footer: CustomFooter(builder: (context, mode) {
        return mode == LoadStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox();
      }),
      child:
          courses.isNotEmpty ? _buildItemCourses(courses) : _dataCoursesEmpty(),
    );
  }

  Widget _buildListCourseWeekLy(bool isLoadMore, List<CourseModel> courses) {
    return SmartRefresher(
      enablePullUp: isLoadMore,
      enablePullDown: false,
      controller: viewModel.refreshControllerWeekly,
      onLoading: () {
        viewModel.getDataCourses(
          refreshController: viewModel.refreshControllerWeekly,
          isFirstLoad: false,
        );
      },
      footer: CustomFooter(builder: (context, mode) {
        return mode == LoadStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox();
      }),
      child:
          courses.isNotEmpty ? _buildItemCourses(courses) : _dataCoursesEmpty(),
    );
  }

  Widget _buildListCourseMonthLy(bool isLoadMore, List<CourseModel> courses) {
    return SmartRefresher(
      enablePullUp: isLoadMore,
      enablePullDown: false,
      controller: viewModel.refreshControllerMonthly,
      onLoading: () {
        viewModel.getDataCourses(
          refreshController: viewModel.refreshControllerMonthly,
          isFirstLoad: false,
        );
      },
      footer: CustomFooter(builder: (context, mode) {
        return mode == LoadStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox();
      }),
      child:
          courses.isNotEmpty ? _buildItemCourses(courses) : _dataCoursesEmpty(),
    );
  }

  Widget _buildItemCourses(List<CourseModel> courses) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.contentPaddingHorizontal,
        vertical: 14.h,
      ),
      shrinkWrap: true,
      primary: false,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return _itemCardCourses(courses[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 14.h,
        );
      },
    );
  }

  Widget _itemCardCourses(CourseModel course) {
    return Selector<ListCoursesViewModel, bool>(
      selector: (_, viewModel) => viewModel.checkSignIn,
      builder: (_, checkSignIn, __) {
        return ItemCourseWidget(
          isSignIn: checkSignIn,
          course: course,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) {
                  return CourseDetailView(
                    uuid: course.uuid,
                    id: course.id,
                    image: course.image,
                    isSvg: course.isSvg,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
