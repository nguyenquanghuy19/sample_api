import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/data/repositories/forum_repository.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ForumTopicViewModel extends BaseViewModel {
  String slug;

  ForumTopicViewModel({required this.slug});

  final ForumRepository _forumRepository = ForumRepository();
  List<TopicModel> listAllCourseOfTopic = [];

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    await _getDataCourseDevelopment();
  }

  Future<void> _getDataCourseDevelopment() async {
    try {
      setLoading(isShow: true);
      final res = await _forumRepository.getAllCourseOfTopic(slug);
      if (res != null && res.data != null) {
        listAllCourseOfTopic = res.data!.listTopic;
      }
    } on Exception {
      LogUtils.d("Load all course of topic failed");
    }
    setLoading(isShow: false);
    updateUI();
  }
}
