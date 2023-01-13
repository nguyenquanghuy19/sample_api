import 'package:flutter/material.dart';
import 'package:testproject/core/data/models/category_model.dart';
import 'package:testproject/core/data/repositories/main_repository.dart';
import 'package:testproject/core/utils/log_utils.dart';
import 'package:testproject/view_models/base_view_model.dart';

class MainViewModel extends BaseViewModel {
  final MainRepository _mainRepository = MainRepository();

  List<CategoryModel> categories = [];

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    getListCategory();
    LogUtils.d("[$runtimeType][MainView_MODEL] => INIT");
  }

  Future<void> getListCategory() async {
    try {
      final res = await _mainRepository.getListCategory();
      if (res != null) {
        categories = res.categories;
      }
    } on Exception catch (error) {
      LogUtils.d("[MainView_MODEL] => error: $error");
    }
    updateUI();
  }
}