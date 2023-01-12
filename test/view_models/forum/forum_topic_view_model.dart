import 'package:elearning/core/data/models/forum_model.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ForumTopicViewModel extends BaseViewModel {
  String slug;

  ForumTopicViewModel({required this.slug});

  List<TopicModel> listAllCourseOfTopic = [];

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    await _getDataCourseDevelopment();
  }

  Future<void> _getDataCourseDevelopment() async {
    try {
      setLoading(isShow: true);
    } on Exception {
      LogUtils.d("Load all course of topic failed");
    }
    setLoading(isShow: false);
    updateUI();
  }
}
