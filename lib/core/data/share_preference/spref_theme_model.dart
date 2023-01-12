import 'package:elearning/core/data/share_preference/spref_base_model.dart';

class SPrefThemeModel extends SPrefBaseModel {
  static SPrefThemeModel? _instance;

  static const String themeKey = "THEME_KEY";

  SPrefThemeModel._();

  factory SPrefThemeModel() => _instance ??= SPrefThemeModel._();

  Future<bool> setTheme(bool value) async {
    return await setBool(key: themeKey, value: value);
  }

  bool getTheme() {
    return getBool(key: themeKey, defaultValue: false);
  }
}