import 'dart:convert';
import 'dart:typed_data';

import 'package:testproject/core/data/share_preference/spref_base_model.dart';

class SPrefUserModel extends SPrefBaseModel {
  static SPrefUserModel? _instance;

  static const String accessTokenKey = "ACCESS_TOKEN";

  SPrefUserModel._();

  factory SPrefUserModel() => _instance ??= SPrefUserModel._();

  Future<bool> setAccessToken(String accessToken) async {
    return await setString(key: accessTokenKey, value: accessToken);
  }

  String? getAccessToken() {
    return getString(key: accessTokenKey, defaultValue: null);
  }
}
