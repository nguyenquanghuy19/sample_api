import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ForumCourseViewModel extends BaseViewModel {
  ForumModel? forumCourseModel;

  DataForumCourse? get general =>
      (forumCourseModel != null && forumCourseModel!.data.isNotEmpty)
          ? forumCourseModel?.data[0]
          : null;

  DataForumCourse? get major =>
      (forumCourseModel != null && forumCourseModel!.data.length > 1)
          ? forumCourseModel?.data[1]
          : null;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    await getTopics();
  }

  Future<void> getTopics({bool isFirstLoad = true}) async {
    try {
      if (isFirstLoad) {
        _isLoading = true;
      }
      _isLoading = false;
      updateUI();
    } on Exception {
      _isLoading = false;
    }
    notifyListeners();
  }
}
