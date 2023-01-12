import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/bottom_navigations/bottom_navigation_after_sign_in/bottom_body_navigation_after_sign_in_widget.dart';
import 'package:elearning/ui/widgets/bottom_navigations/bottom_navigation_after_sign_in/bottom_navigation_after_sign_in_widget.dart';
import 'package:elearning/view_models/mains/main_view_after_sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainViewAfterSignIn extends BaseView {
  const MainViewAfterSignIn({Key? key}) : super(key: key);

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState
    extends BaseViewState<MainViewAfterSignIn, MainViewAfterSignInViewModel> {
  final Map<BottomTabItemAfterSignIn, Widget?> _cacheBottomTabWidgets = {
    BottomTabItemAfterSignIn.home: null,
    BottomTabItemAfterSignIn.course: null,
    BottomTabItemAfterSignIn.myLearning: null,
    BottomTabItemAfterSignIn.setting: null,
  };

  final Map<BottomTabItemAfterSignIn, GlobalKey<NavigatorState>>
      _bottomTabKeys = {
    BottomTabItemAfterSignIn.home: GlobalKey<NavigatorState>(),
    BottomTabItemAfterSignIn.course: GlobalKey<NavigatorState>(),
    BottomTabItemAfterSignIn.myLearning: GlobalKey<NavigatorState>(),
    BottomTabItemAfterSignIn.setting: GlobalKey<NavigatorState>(),
  };

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MainViewAfterSignInViewModel()..onInitViewModel(context);
  }

  Future<void> _onPressBackDevice() async {
    final navigator = _bottomTabKeys[viewModel.currentBottomTab];
    navigator!.currentState!.maybePop();
  }

  @override
  Widget buildView(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onPressBackDevice();

        return false;
      },
      child: Selector<MainViewAfterSignInViewModel, BottomTabItemAfterSignIn>(
        selector: (_, viewModel) => viewModel.currentBottomTab,
        builder: (_, currentBottomTab, __) {
          return Scaffold(
            backgroundColor: AppColor.neutrals.shade900,
            body: _buildBody(),
            bottomNavigationBar: BottomNavigationAfterSignInWidget(
              currentTab: currentBottomTab,
              onSelectTab: _selectTab,
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    if (viewModel.currentBottomTab == BottomTabItemAfterSignIn.home) {
      return _buildTabItem(
        BottomTabItemAfterSignIn.home,
        _cacheBottomTabWidgets[BottomTabItemAfterSignIn.home],
      );
    } else if (viewModel.currentBottomTab == BottomTabItemAfterSignIn.course) {
      return _buildTabItem(
        BottomTabItemAfterSignIn.course,
        _cacheBottomTabWidgets[BottomTabItemAfterSignIn.course],
      );
    } else if (viewModel.currentBottomTab ==
        BottomTabItemAfterSignIn.myLearning) {
      return _buildTabItem(
        BottomTabItemAfterSignIn.myLearning,
        _cacheBottomTabWidgets[BottomTabItemAfterSignIn.myLearning],
      );
    } else {
      return _buildTabItem(
        BottomTabItemAfterSignIn.setting,
        _cacheBottomTabWidgets[BottomTabItemBeforeSignIn.setting],
      );
    }
  }

  Widget _buildTabItem(BottomTabItemAfterSignIn tabItem, Widget? child) {
    // Cache Widget
    return Offstage(
      offstage: viewModel.currentBottomTab != tabItem,
      child: child ??
          (viewModel.currentBottomTab == tabItem
              ? _buildCacheTab(tabItem)
              : Container()),
    );
  }

  Widget _buildCacheTab(BottomTabItemAfterSignIn tabItem) {
    return _cacheBottomTabWidgets[tabItem] =
        BottomBodyNavigationAfterSignInWidget(
      bottomMenuBar: tabItem,
      navigatorKey: _bottomTabKeys[tabItem]!,
    );
  }

  void _selectTab(BottomTabItemAfterSignIn bottomMenuBar) {
    viewModel.changeTab(bottomMenuBar);
  }
}
