import 'package:flutter/material.dart';
import 'package:testproject/ui/views/main/main_view.dart';
import 'package:testproject/ui/widgets/banners/flavor_banner.dart';

/// TopScreenNavigator
/// 1画面で完結する画面の画面遷移を管理
/// Define route for application (1 route = 1 view).
class TopScreenRoutes {
  static const String homeRoute = 'home';

  static TopScreenRoutes? _instance;

  const TopScreenRoutes._();

  factory TopScreenRoutes() => _instance ??= const TopScreenRoutes._();

  void destroyInstance() {
    //インスタンス破棄
    _instance = null;
  }

  String initialRoute() => homeRoute;

  Route<dynamic> routeBuilders(RouteSettings settings) {
    switch (settings.name) {
      default:
        return _buildViewWithBanner(
          view: const MainView(),
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
