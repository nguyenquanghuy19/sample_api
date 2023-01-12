import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class MyLearningResultViewModel extends BaseViewModel {
  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
    LogUtils.d("[INIT_MY_LEARNING_RESULT_VIEW_MODEL]");
  }
}
