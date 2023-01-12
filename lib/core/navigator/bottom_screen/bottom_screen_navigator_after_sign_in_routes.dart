import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/views/course/list_courses_view.dart';
import 'package:elearning/ui/views/home/home_view.dart';
import 'package:elearning/ui/views/my_learning/my_learning_view.dart';
import 'package:elearning/ui/views/setting/setting_view.dart';
import 'package:flutter/material.dart';

/// BottomNavigatorBar毎の画面遷移を管理
class BottomScreenNavigatorAfterSignInRoutes {
  static const Map<BottomTabItemAfterSignIn, String> _routes = {
    BottomTabItemAfterSignIn.home: "home",
    BottomTabItemAfterSignIn.course: "course",
    BottomTabItemAfterSignIn.myLearning: "my_learning",
    BottomTabItemAfterSignIn.setting: "setting",
  };

  static BottomScreenNavigatorAfterSignInRoutes? _instance;

  BottomScreenNavigatorAfterSignInRoutes._();

  factory BottomScreenNavigatorAfterSignInRoutes() =>
      _instance ??= BottomScreenNavigatorAfterSignInRoutes._();

  void destroyInstance() {
    _instance = null;
  }

  String initialRoute() => _routes[BottomTabItemAfterSignIn.setting]!;

  /// Define routes
  Map<String, Widget Function(BuildContext)> routeBuilders(
    BuildContext context,
  ) {
    return {
      _routes[BottomTabItemAfterSignIn.home]!: (context) => const HomeView(),
      _routes[BottomTabItemAfterSignIn.course]!: (context) =>
          const ListCoursesView(),
      _routes[BottomTabItemAfterSignIn.myLearning]!: (context) =>
          const MyLearningView(),
      _routes[BottomTabItemAfterSignIn.setting]!: (context) =>
          const SettingView(),
    };
  }

  /// Get Route name with bottom tab item
  String routeName(BottomTabItemAfterSignIn tabItem) {
    return _routes[tabItem]!;
  }
}
