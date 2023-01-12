import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/core/navigator/bottom_screen/bottom_screen_navigator_before_sign_in_routes.dart';
import 'package:flutter/material.dart';

class BottomBodyNavigationBeforeSignInWidget extends StatelessWidget {
  BottomBodyNavigationBeforeSignInWidget({
    required this.bottomMenuBar,
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  final BottomTabItemBeforeSignIn bottomMenuBar;
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomScreenNavigatorBeforeSignInRoutes _navigatorRoutes =
      BottomScreenNavigatorBeforeSignInRoutes();

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _navigatorRoutes.routeBuilders(context);

    return Navigator(
      key: navigatorKey,
      initialRoute: _navigatorRoutes.initialRoute(),
      onGenerateRoute: (routeSettings) {
        return PageRouteBuilder<dynamic>(
          pageBuilder: (_, __, ___) =>
              routeBuilders[_navigatorRoutes.routeName(bottomMenuBar)]!(
            context,
          ),
          transitionDuration: Duration.zero,
        );
      },
    );
  }
}
