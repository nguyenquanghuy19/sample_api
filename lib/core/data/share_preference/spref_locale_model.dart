import 'package:elearning/core/data/share_preference/spref_base_model.dart';

class SPrefLocaleModel extends SPrefBaseModel {
  static SPrefLocaleModel? _instance;

  static const String localeKey = "LOCALE_LANGUAGE";

  SPrefLocaleModel._();

  factory SPrefLocaleModel() => _instance ??= SPrefLocaleModel._();

  Future<bool> setLocale(String locale) async {
    return await setString(key: localeKey, value: locale);
  }

  String? getLocale() {
    return getString(key: localeKey, defaultValue: null);
  }
}
