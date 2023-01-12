import 'dart:collection';

import 'package:elearning/core/enums/enums.dart';
import 'package:elearning/core/utils/log_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';

import 'package:flutter/cupertino.dart';

class LandingViewModel extends BaseViewModel {
  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
    LogUtils.d("[$runtimeType][LANDING_VIEW_MODEL] => RUNNING");
  }

  BottomTabItemBeforeSignIn _currentBottomTab = BottomTabItemBeforeSignIn.course;

  BottomTabItemBeforeSignIn get currentBottomTab => _currentBottomTab;
  final ListQueue<BottomTabItemBeforeSignIn> _stackPrevBottomTab = ListQueue();

  void changeTab(BottomTabItemBeforeSignIn tab, {bool isBackClick = false}) {
    LogUtils.d("[CHANGE_TAB] $_currentBottomTab -> $tab");
    if (_currentBottomTab != tab) {
      if (!isBackClick) {
        if (!_stackPrevBottomTab.contains(currentBottomTab)) {
          _stackPrevBottomTab.addLast(currentBottomTab);
        } else {
          _stackPrevBottomTab
              .remove(currentBottomTab); // Remove old index stack
          _stackPrevBottomTab
              .addLast(currentBottomTab); // Replace new index stack
        }
      }
      _currentBottomTab = tab;
    }
    updateUI();
  }
}
