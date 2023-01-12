import 'package:elearning/core/data/share_preference/spref_locale_model.dart';
import 'package:elearning/core/data/share_preference/spref_theme_model.dart';
import 'package:elearning/core/utils/wait_apply_screen_size.dart';
import 'package:elearning/ui/widgets/banners/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'application.dart';
import 'core/enums/enums.dart';

const Flavor flavorName = Flavor.develop;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Wait for calculator size
  await WaitApplyScreenSize().waitScreenSizeAvailable();
  await SPrefLocaleModel().onInit();
  await SPrefThemeModel().onInit();
  // Setup Flavor
  _setUpFlavorDevelop();
  runApp(Phoenix(child: const Application()));
}

void _setUpFlavorDevelop() {
  FlavorConfig(
    flavor: flavorName,
    color: Colors.redAccent,
    // それ以外のAPIの接続先
    baseApiUrl: "https://elms-be-dev.rikkeisolution.com/api/",
    versionAPI: "v1",
    othersVersionApi: {},
    supportMailAddress: "",
    saveRidingLogApiUrl: "",
    saveRidingLogVersionApi: "",
    hasMockAPI: false,
  );
}
