import 'package:elearning/ui/views/course/list_courses_view.dart';
import 'package:elearning/ui/views/home/home_view.dart';
import 'package:elearning/ui/views/my_learning/my_learning_view.dart';
import 'package:elearning/ui/views/setting/setting_view.dart';
import 'package:elearning/ui/views/splash_view.dart';
import 'package:elearning/ui/widgets/banners/flavor_banner.dart';
import 'package:flutter/material.dart';

/// TopScreenNavigator
/// 1画面で完結する画面の画面遷移を管理
/// Define route for application (1 route = 1 view).
class TopScreenRoutes {
  static const String splash = 'splash';
  static const String homeRoute = 'home';
  static const String course = 'course';
  static const String myLearning = 'my_learning';
  static const String settingRoute = 'setting';

  static TopScreenRoutes? _instance;

  const TopScreenRoutes._();

  factory TopScreenRoutes() => _instance ??= const TopScreenRoutes._();

  void destroyInstance() {
    //インスタンス破棄
    _instance = null;
  }

  String initialRoute() => splash;

  Route<dynamic> routeBuilders(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _buildViewWithBanner(
          view: const HomeView(),
        );
      case course:
        return _buildViewWithBanner(
          view: const ListCoursesView(),
        );
      case myLearning:
        return _buildViewWithBanner(
          view: const MyLearningView(),
        );
      case settingRoute:
        return _buildViewWithBanner(
          view: const SettingView(),
        );
      default:
        return _buildViewWithBanner(
          view: const SplashView(),
        );
    }
  }
}

MaterialPageRoute _buildViewWithBanner({required Widget view}) {
  return MaterialPageRoute<dynamic>(
    builder: (_) => FlavorBanner(
      child: view,
    ),
  );
}
