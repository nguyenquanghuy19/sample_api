import 'package:elearning/core/data/models/road_map_model.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class MyLearningDetailViewModel extends BaseViewModel {
  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  DataRoadmap? dataRoadmap;

  MenuMyLearningDetail menu = MenuMyLearningDetail.roadmap;

  @override
  Future<void> onInitViewModel(BuildContext context, {int? courseId}) async {
    super.onInitViewModel(context);
    await _getRoadMapMyLearningDetail(courseId: courseId);
  }

  Future<void> _getRoadMapMyLearningDetail({required courseId}) async {
    try {
      _isLoading = true;
      final res = await _myLearningRepository.getRoadMapMyLearningDetail(
        courseId: courseId,
      );
      if (res != null && res.data.isNotEmpty) {
        dataRoadmap = res.data[0];
      }
      _isLoading = false;
    } on Exception {
      _isLoading = false;
    }
    notifyListeners();
  }

  void onChangeMenu(value) {
    menu = value;
    updateUI();
  }
}
