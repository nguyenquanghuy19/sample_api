import 'package:elearning/core/data/share_preference/spref_theme_model.dart';
import 'package:elearning/core/navigator/bottom_screen/bottom_screen_navigator_before_sign_in_routes.dart';
import 'package:elearning/core/navigator/top_screen/top_screen_routes.dart';
import 'package:elearning/core/utils/info_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class ApplicationViewModel extends BaseViewModel {
  ThemeMode? _mode;

  ThemeMode? get mode => _mode;

  void toggleMode(int index) {
    _mode = index == 0 ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void saveTheme() async {
    if (_mode == ThemeMode.light) {
      SPrefThemeModel().setTheme(false);
    } else {
      SPrefThemeModel().setTheme(true);
    }

    notifyListeners();
  }

  ApplicationViewModel({
    ThemeMode mode = ThemeMode.light,
  }) {
    _mode = mode;
    loadTheme();
  }

  void loadTheme() async {
    _mode = !SPrefThemeModel().getTheme() ? ThemeMode.light : ThemeMode.dark;
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
    BottomScreenNavigatorBeforeSignInRoutes().destroyInstance();
  }

  void _destroySharedPreferenceInstance() {
    // TODO(後で処理する)
  }

  void _destroyInfoUtils() {
    InfoUtils().destroyInstance();
  }
}
