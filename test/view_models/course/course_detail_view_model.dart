import 'package:elearning/core/data/models/course_mock_model.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class CourseDetailViewModel extends BaseViewModel {
  List<CommentModel> comments = [];

  List<LectureModel> lectures = [];

  bool _isLoading = false;

  bool _isLoadMore = false;

  bool get isLoading => _isLoading;

  bool get isLoadMore => _isLoadMore;

  bool hasData = true;

  ScrollController scrollController = ScrollController();

  bool isShowButtonScrollTop = false;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    scrollController.addListener(() {
      if (scrollController.position.extentBefore > 350) {
        handleShowButtonScrollTop(true);
      } else {
        handleShowButtonScrollTop(false);
      }
    });
    await getDataOptionCourses();
  }

  Future<void> getListComment({bool loadMore = false}) async {
    try {
      if (loadMore) {
        _isLoadMore = true;
      }
      notifyListeners();
      _isLoadMore = false;
      notifyListeners();
    } on Exception {
      _isLoadMore = false;
      LogUtils.d("[$runtimeType][GET_LIST_COMMENT] => ERROR");
    }
  }

  void handleShowButtonScrollTop(bool value) {
    isShowButtonScrollTop = value;
    notifyListeners();
  }

  Future<void> getListLecture() async {
    try {
      notifyListeners();
    } on Exception {
      LogUtils.d("[$runtimeType][GET_LIST_LECTURE] => ERROR");
    }
  }

  Future<void> getDataOptionCourses() async {
    try {
      _isLoading = true;
      await getListComment();
      await getListLecture();
      _isLoading = false;
    } on Exception {
      _isLoading = false;
    }
  }
}
