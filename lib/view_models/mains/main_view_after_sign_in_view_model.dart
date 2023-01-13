import 'package:testproject/core/enums/enums.dart';
import 'package:testproject/core/utils/log_utils.dart';
import 'package:testproject/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class MainViewAfterSignInViewModel extends BaseViewModel {
  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
    LogUtils.d("[$runtimeType][LANDING_VIEW_MODEL] => RUNNING");
  }

  BottomTabItemAfterSignIn _currentBottomTab = BottomTabItemAfterSignIn.home;

  BottomTabItemAfterSignIn get currentBottomTab => _currentBottomTab;

  void changeTab(BottomTabItemAfterSignIn tab, {bool isBackClick = false}) {
    LogUtils.d("[CHANGE_TAB] $_currentBottomTab -> $tab");
    if (_currentBottomTab != tab) {
      _currentBottomTab = tab;
    }
    updateUI();
  }
}
