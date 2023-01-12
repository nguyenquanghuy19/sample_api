import 'package:elearning/core/data/models/theme_model.dart';
import 'package:elearning/core/data/share_preference/spref_theme_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';

class DarkModeViewModel extends BaseViewModel {
  List<ThemeModel> checkBoxList = [];
  int modeChoose = 0;

  @override
  void onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    modeChoose = SPrefThemeModel().getTheme() ? 1 : 0;
  }

  void inItLanguage() {
    checkBoxList.clear();
    checkBoxList.addAll([
      ThemeModel(
        id: 0,
        value: false,
        title: Strings.of(context)!.lightMode,
      ),
      ThemeModel(
        id: 1,
        value: false,
        title: Strings.of(context)!.darkMode,
      ),
    ]);
  }

  void initValue() {
    for (int i = 0; i < checkBoxList.length; i++) {
      if (checkBoxList[i].id == modeChoose) {
        checkBoxList[i].value = true;
        break;
      }
    }
  }

  void onTapChangeMode(int index) {
    for (int i = 0; i < checkBoxList.length; i++) {
      if (i == index) {
        checkBoxList[i].value = true;
        modeChoose = checkBoxList[i].id;
      } else {
        checkBoxList[i].value = false;
      }
    }
    updateUI();
  }
}
