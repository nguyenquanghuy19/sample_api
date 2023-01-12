import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/bottom_navigations/bottom_navigation_before_sign_in/bottom_body_navigation_before_sign_in_widget.dart';
import 'package:elearning/ui/widgets/bottom_navigations/bottom_navigation_before_sign_in/bottom_navigation_before_sign_in_widget.dart';
import 'package:elearning/view_models/mains/main_view_before_sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainViewBeforeSignIn extends BaseView {
  const MainViewBeforeSignIn({Key? key}) : super(key: key);

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState
    extends BaseViewState<MainViewBeforeSignIn, MainViewBeforeSignInViewModel> {
  final Map<BottomTabItemBeforeSignIn, Widget?> _cacheBottomTabWidgets = {
    BottomTabItemBeforeSignIn.home: null,
    BottomTabItemBeforeSignIn.course: null,
    BottomTabItemBeforeSignIn.setting: null,
  };

  final Map<BottomTabItemBeforeSignIn, GlobalKey<NavigatorState>>
      _bottomTabKeys = {
    BottomTabItemBeforeSignIn.home: GlobalKey<NavigatorState>(),
    BottomTabItemBeforeSignIn.course: GlobalKey<NavigatorState>(),
    BottomTabItemBeforeSignIn.setting: GlobalKey<NavigatorState>(),
  };

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MainViewBeforeSignInViewModel()..onInitViewModel(context);
  }

  Future<void> _onPressBackDevice() async {
    final navigator = _bottomTabKeys[
      viewModel.currentBottomTab
    ];
    navigator!.currentState!.maybePop();
  }


  @override
  Widget buildView(BuildContext context) {
    return Selector<MainViewBeforeSignInViewModel, BottomTabItemBeforeSignIn>(
      selector: (_, viewModel) => viewModel.currentBottomTab,
      builder: (_, currentBottomTab, __) {
        return WillPopScope(
          onWillPop: () async {
            _onPressBackDevice();

            return false;
          },
          child: Scaffold(
            backgroundColor: AppColor.neutrals.shade900,
            body: _buildBody(),
            bottomNavigationBar: BottomNavigationBeforeSignInWidget(
              currentTab: currentBottomTab,
              onSelectTab: _selectTab,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    if (viewModel.currentBottomTab ==
        BottomTabItemBeforeSignIn.home) {
      return _buildTabItem(
        BottomTabItemBeforeSignIn.home,
        _cacheBottomTabWidgets[BottomTabItemBeforeSignIn.home],
      );
    } else if (viewModel.currentBottomTab == BottomTabItemBeforeSignIn.course) {
      return _buildTabItem(
        BottomTabItemBeforeSignIn.course,
        _cacheBottomTabWidgets[BottomTabItemBeforeSignIn.course],
      );
    } else {
      return _buildTabItem(
        BottomTabItemBeforeSignIn.setting,
        _cacheBottomTabWidgets[BottomTabItemBeforeSignIn.setting],
      );
    }
  }

  Widget _buildTabItem(BottomTabItemBeforeSignIn tabItem, Widget? child) {
    // Cache Widget
    return Offstage(
      offstage: viewModel.currentBottomTab != tabItem,
      child: child ??
          (viewModel.currentBottomTab == tabItem
              ? _buildCacheTab(tabItem)
              : Container()),
    );
  }

  Widget _buildCacheTab(BottomTabItemBeforeSignIn tabItem) {
    return _cacheBottomTabWidgets[tabItem] =
        BottomBodyNavigationBeforeSignInWidget(
      bottomMenuBar: tabItem,
      navigatorKey: _bottomTabKeys[tabItem]!,
    );
  }

  void _selectTab(BottomTabItemBeforeSignIn bottomMenuBar) {
    viewModel.changeTab(bottomMenuBar);
  }
}
