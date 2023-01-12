import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class InformationMyLearningViewModel extends BaseViewModel {
  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  MyLearningDetailResponse? myLearningDetailResponse;

  MyLearningDetailModel? get myLearning => myLearningDetailResponse?.data;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  Future<void> onInitViewModel(BuildContext context, {int? courseId}) async {
    super.onInitViewModel(context);
    await _getDataMyLearningDetail(courseId);
  }

  Future<void> _getDataMyLearningDetail(int? courseId) async {
    try {
      _isLoading = true;
      if (courseId != null) {
        final res = await _myLearningRepository.getMyLearningDetailData(
          courseId: courseId,
        );
        if (res != null) {
          myLearningDetailResponse = res;
        }
      }
      _isLoading = false;
      updateUI();
    } on Exception {
      updateUI();
      _isLoading = false;
      LogUtils.d("[$runtimeType][GET_DATA_MY_LEARNING_DETAIL] => ERROR");
    }
  }
}
