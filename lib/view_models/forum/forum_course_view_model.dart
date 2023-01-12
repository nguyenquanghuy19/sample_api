import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/data/repositories/forum_repository.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ForumCourseViewModel extends BaseViewModel {
  ForumModel? _forumCourseModel;

  DataForumCourse? get general =>
      (_forumCourseModel != null && _forumCourseModel!.data.isNotEmpty)
          ? _forumCourseModel?.data[0]
          : null;

  DataForumCourse? get major =>
      (_forumCourseModel != null && _forumCourseModel!.data.length > 1)
          ? _forumCourseModel?.data[1]
          : null;

  final ForumRepository _forumCourseRepository = ForumRepository();

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
      final res = await _forumCourseRepository.getTopics();
      _forumCourseModel = res;
      _isLoading = false;
      updateUI();
    } on Exception {
      _isLoading = false;
    }
    notifyListeners();
  }
}
