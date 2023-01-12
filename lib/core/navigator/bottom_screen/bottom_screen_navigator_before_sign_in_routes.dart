import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/views/course/list_courses_view.dart';
import 'package:elearning/ui/views/home/home_view.dart';
import 'package:elearning/ui/views/setting/setting_view.dart';
import 'package:flutter/material.dart';

/// BottomNavigatorBar毎の画面遷移を管理
class BottomScreenNavigatorBeforeSignInRoutes {
  static const Map<BottomTabItemBeforeSignIn, String> _routes = {
    BottomTabItemBeforeSignIn.home: "home",
    BottomTabItemBeforeSignIn.course: "course",
    BottomTabItemBeforeSignIn.setting: "setting",
  };

  static BottomScreenNavigatorBeforeSignInRoutes? _instance;

  BottomScreenNavigatorBeforeSignInRoutes._();

  factory BottomScreenNavigatorBeforeSignInRoutes() =>
      _instance ??= BottomScreenNavigatorBeforeSignInRoutes._();

  void destroyInstance() {
    _instance = null;
  }

  String initialRoute() => _routes[BottomTabItemBeforeSignIn.setting]!;

  /// Define routes
  Map<String, Widget Function(BuildContext)> routeBuilders(
    BuildContext context,
  ) {
    return {
      _routes[BottomTabItemBeforeSignIn.home]!: (context) => const HomeView(),
      _routes[BottomTabItemBeforeSignIn.course]!: (context) =>
          const ListCoursesView(),
      _routes[BottomTabItemBeforeSignIn.setting]!: (context) =>
          const SettingView(),
    };
  }

  /// Get Route name with bottom tab item
  String routeName(BottomTabItemBeforeSignIn tabItem) {
    return _routes[tabItem]!;
  }
}
