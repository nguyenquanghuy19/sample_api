import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/language_model.dart';
import 'package:elearning/core/data/share_preference/spref_locale_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/dialog/dialog_widget.dart';
import 'package:elearning/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SwitchLanguageViewModel extends BaseViewModel {
  String? locale;

  String languageChoose = Constants.en;

  List<LanguageModel> checkBoxList = [];

  @override
  void onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    locale = SPrefLocaleModel().getLocale();
    languageChoose = SPrefLocaleModel().getLocale() ?? Constants.en;
  }

  void inItLanguage() {
    checkBoxList.clear();
    checkBoxList.addAll([
      LanguageModel(
        id: Constants.en,
        value: false,
        title: Strings.of(context)!.english,
      ),
      LanguageModel(
        id: Constants.ja,
        value: false,
        title: Strings.of(context)!.japan,
      ),
      LanguageModel(
        id: Constants.vi,
        value: false,
        title: Strings.of(context)!.vietnam,
      ),
    ]);
  }

  void initValue() {
    if (locale == null) {
      checkBoxList[0].value = true;
    }
    for (int i = 0; i < checkBoxList.length; i++) {
      if (checkBoxList[i].id == languageChoose) {
        checkBoxList[i].value = true;
        break;
      }
    }
  }

  void _onSubmitSwitchLanguage() {
    if (languageChoose == Constants.ja) {
      Strings.load(const Locale(Constants.ja));
      SPrefLocaleModel().setLocale(Constants.ja);
    } else if (languageChoose == Constants.en) {
      Strings.load(const Locale(Constants.en));
      SPrefLocaleModel().setLocale(Constants.en);
    } else {
      Strings.load(const Locale(Constants.vi));
      SPrefLocaleModel().setLocale(Constants.vi);
    }
    Phoenix.rebirth(context);
  }

  void onTapChangeLanguage(int index) {
    DialogWidget().showBasicDialog(
      context: context,
      title: Strings.of(context)!.languageChange,
      content: Strings.of(context)!.reStartApp,
      positiveOnClickListener: () {
        for (int i = 0; i < checkBoxList.length; i++) {
          if (i == index) {
            checkBoxList[i].value = true;
            languageChoose = checkBoxList[i].id;
          } else {
            checkBoxList[i].value = false;
          }
        }
        _onSubmitSwitchLanguage();
      },
    );
  }
}
