import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class MainViewBeforeSignInViewModel extends BaseViewModel {
  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
    LogUtils.d("[$runtimeType][LANDING_VIEW_MODEL] => RUNNING");
  }

  BottomTabItemBeforeSignIn _currentBottomTab = BottomTabItemBeforeSignIn.home;

  BottomTabItemBeforeSignIn get currentBottomTab => _currentBottomTab;

  void changeTab(BottomTabItemBeforeSignIn tab, {bool isBackClick = false}) {
    LogUtils.d("[CHANGE_TAB] $_currentBottomTab -> $tab");
    if (_currentBottomTab != tab) {
      _currentBottomTab = tab;
    }
    updateUI();
  }
}
