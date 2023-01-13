import 'package:testproject/core/navigator/top_screen/top_screen_routes.dart';
import 'package:testproject/core/utils/info_utils.dart';
import 'package:testproject/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ApplicationViewModel extends BaseViewModel {
  ThemeMode? _mode;

  ThemeMode? get mode => _mode;

  void toggleMode(int index) {
    _mode = index == 0 ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  ApplicationViewModel({
    ThemeMode mode = ThemeMode.light,
  }) {
    _mode = mode;
    loadTheme();
  }

  void loadTheme() async {
    notifyListeners();
  }

  Future<void> destroySingletonObject() async {
    _destroyRouteInstance();
    // SharedPreference
    _destroySharedPreferenceInstance();
    // InfoUtils
    _destroyInfoUtils();
  }

  void _destroyRouteInstance() {
    TopScreenRoutes().destroyInstance();
  }

  void _destroySharedPreferenceInstance() {
    // TODO(後で処理する)
  }

  void _destroyInfoUtils() {
    InfoUtils().destroyInstance();
  }
}
