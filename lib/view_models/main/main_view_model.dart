import 'package:flutter/material.dart';
import 'package:testproject/core/data/local/app_database.dart';
import 'package:testproject/core/data/local/dao/category_dao.dart';
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
    await initDatabase();
    await getListCategory();
    // await getListCategoryFromDB();
    LogUtils.d("[$runtimeType][MainView_MODEL] => INIT");
  }

  /// Get list category from Api
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

  /// Get list category from DB
  Future<void> getListCategoryFromDB() async {
    final res = await _mainRepository.getListCategoryFromDB();
    if (res != null) {
      categories = res;
    }
  }

  Future<void> initDatabase() async {
    await Future.wait(
      [
        AppDatabase().onInit().then((database) async {
          if (database != null) {
            // DAO
            CategoryDao().init();
          }

          return database;
        }),
        // PackageUtils
      ],
    );
  }

  void onTapSaveListCategory() {
    _mainRepository.saveItemCategoryToDB(categories);
  }
}
