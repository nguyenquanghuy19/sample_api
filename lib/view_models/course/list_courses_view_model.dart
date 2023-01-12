import 'dart:async';

import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/course_model.dart';
import 'package:elearning/core/data/repositories/courses_repository.dart';
import 'package:elearning/core/data/repositories/media_repository.dart';
import 'package:elearning/core/data/share_preference/spref_user_model.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListCoursesViewModel extends BaseViewModel {
  final TextEditingController searchController = TextEditingController();

  final CoursesRepository _coursesRepository = CoursesRepository();

  final MediaRepository _mediaRepository = MediaRepository();

  List<CourseModel> courses = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  RefreshController refreshControllerLatest = RefreshController();
  RefreshController refreshControllerDaily = RefreshController();
  RefreshController refreshControllerWeekly = RefreshController();
  RefreshController refreshControllerMonthly = RefreshController();

  int _totalRecord = 0;

  int _page = 1;

  double _time = Constants.latest;

  bool get isLoadMore => courses.length < _totalRecord;

  bool get checkSignIn => SPrefUserModel().getIsSignIn();

  Timer? _debounce;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    LogUtils.d("[$runtimeType][LIST_COURSES_VIEW_MODEL] => INIT");
    await getDataCourses(
      refreshController: refreshControllerLatest,
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void onTapChange(int index) {
    _totalRecord = 0;
    switch (index) {
      case 0:
        // Handler call api with yearly case
        // Todo: Review why Need to dispose
        refreshControllerLatest.dispose();
        refreshControllerDaily.dispose();
        refreshControllerWeekly.dispose();
        refreshControllerMonthly.dispose();
        refreshControllerLatest = RefreshController();
        refreshControllerDaily = RefreshController();
        refreshControllerWeekly = RefreshController();
        refreshControllerMonthly = RefreshController();
        _time = Constants.latest;
        getDataCourses(
          refreshController: refreshControllerLatest,
        );
        break;
      case 1:
        // Handler call api with daily case
        refreshControllerLatest.dispose();
        refreshControllerDaily.dispose();
        refreshControllerWeekly.dispose();
        refreshControllerMonthly.dispose();
        refreshControllerLatest = RefreshController();
        refreshControllerDaily = RefreshController();
        refreshControllerWeekly = RefreshController();
        refreshControllerMonthly = RefreshController();
        _time = Constants.daily;
        getDataCourses(
          refreshController: refreshControllerDaily,
        );
        break;
      case 2:
        // Handler call api with weekly case
        refreshControllerLatest.dispose();
        refreshControllerDaily.dispose();
        refreshControllerWeekly.dispose();
        refreshControllerMonthly.dispose();
        refreshControllerLatest = RefreshController();
        refreshControllerDaily = RefreshController();
        refreshControllerWeekly = RefreshController();
        refreshControllerMonthly = RefreshController();
        _time = Constants.weekly;
        getDataCourses(
          refreshController: refreshControllerWeekly,
        );
        break;
      case 3:
        // Handler call api with monthly case
        _time = Constants.monthly;
        refreshControllerLatest.dispose();
        refreshControllerDaily.dispose();
        refreshControllerWeekly.dispose();
        refreshControllerMonthly.dispose();
        refreshControllerLatest = RefreshController();
        refreshControllerDaily = RefreshController();
        refreshControllerWeekly = RefreshController();
        refreshControllerMonthly = RefreshController();
        getDataCourses(
          refreshController: refreshControllerMonthly,
        );
        break;
    }
  }

  Future<void> getDataCourses({
    required RefreshController refreshController,
    bool isSearch = false,
    bool isFirstLoad = true,
  }) async {
    try {
      if (isFirstLoad && !isSearch) {
        _isLoading = true;
        _page = 1;
        notifyListeners();
        courses.clear();
      }
      if (isSearch) {
        _page = 1;
        courses.clear();
      }
      final String param =
          "?Page=$_page&PerPage=10&Name=${searchController.text.trim()}&Time=$_time";
      final res = await _coursesRepository.getAllListCourses(param: param);
      if (res != null && res.data.isNotEmpty) {
        courses.addAll(res.data);
        getListImage(courses, res.data.length);
        _totalRecord = res.total!;
        _page++;
      }

      refreshController.loadComplete();
      _isLoading = false;
    } on Exception {
      _isLoading = false;
      refreshController.loadComplete();
    }
    updateUI();
  }

  Future<void> getImage(CourseModel course) async {
    try {
      if (course.featuredImage != null) {
        course.isLoadingImage = true;
        final res =
            await _mediaRepository.getLmsFeatureImage(course.featuredImage!);
        course.image = res.data;
        course.isSvg = res.headers["content-type"]?[0].contains("svg") ?? false;
        course.isLoadingImage = false;
      } else {
        course.isLoadingImage = false;
      }
    } on Exception {
      course.isLoadingImage = false;
      LogUtils.i("Error get image");
    }
    updateUI();
  }

  void getListImage(List<CourseModel> course, int length) {
    for (int i = course.length - length; i < course.length; i++) {
      getImage(course[i]);
    }
  }

  void onCloseSearch(int index) {
    if (searchController.text.trim().isNotEmpty) {
      searchController.clear();
      if (index == 0) {
        getDataCourses(
          refreshController: refreshControllerLatest,
          isSearch: true,
        );

        return;
      }
      if (index == 1) {
        getDataCourses(
          refreshController: refreshControllerDaily,
          isSearch: true,
        );

        return;
      }
      if (index == 2) {
        getDataCourses(
          refreshController: refreshControllerWeekly,
          isSearch: true,
        );

        return;
      }
      if (index == 3) {
        getDataCourses(
          refreshController: refreshControllerMonthly,
          isSearch: true,
        );

        return;
      }
    } else {
      searchController.clear();
    }
  }

  void onSearch(int index) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      searchController.text.trim();
      if (index == 0) {
        getDataCourses(
          refreshController: refreshControllerLatest,
          isSearch: true,
        );

        return;
      }

      if (index == 1) {
        getDataCourses(
          refreshController: refreshControllerDaily,
          isSearch: true,
        );

        return;
      }

      if (index == 2) {
        getDataCourses(
          refreshController: refreshControllerWeekly,
          isSearch: true,
        );

        return;
      }

      if (index == 3) {
        getDataCourses(
          refreshController: refreshControllerMonthly,
          isSearch: true,
        );

        return;
      }
    });
  }
}
