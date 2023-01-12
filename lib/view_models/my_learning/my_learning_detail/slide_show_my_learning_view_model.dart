import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/my_learning_model.dart';
import 'package:elearning/core/data/repositories/my_learning_repository.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class SlideShowMyLearningViewModel extends BaseViewModel {
  final MyLearningRepository _myLearningRepository = MyLearningRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<TypeDataModel> dataTypes = [];

  @override
  Future<void> onInitViewModel(BuildContext context, {int? courseId}) async {
    super.onInitViewModel(context);
    await _getContentOnRoadMap(
      courseId: courseId,
      screenType: Constants.paramSlideShow,
    );
  }

  Future<void> _getContentOnRoadMap({
    required courseId,
    required screenType,
  }) async {
    try {
      _isLoading = true;
      if (courseId != null) {
        String param = "?Type=$screenType&ClassroomId=$courseId";
        final res = await _myLearningRepository.getContentOnRoadMap(
          param: param,
        );
        if (res != null && res.data.isNotEmpty) {
          dataTypes.clear();
          dataTypes.addAll(res.data);
        }
      }
      _isLoading = false;
      notifyListeners();
    } on Exception {
      _isLoading = false;
      notifyListeners();
      LogUtils.d("[$runtimeType][GET_DATA_MY_LEARNING_FLASH_CARD => ERROR");
    }
  }
}
