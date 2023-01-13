import 'package:flutter/material.dart';
import 'package:testproject/ui/widgets/banners/flavor_config.dart';

import 'application.dart';
import 'core/enums/enums.dart';

const Flavor flavorName = Flavor.develop;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Setup Flavor
  _setUpFlavorDevelop();
  runApp(const Application());
}

void _setUpFlavorDevelop() {
  FlavorConfig(
    flavor: flavorName,
    color: Colors.redAccent,
    // それ以外のAPIの接続先
    baseApiUrl: "http://streaming.nexlesoft.com:4000/api/",
    versionAPI: "",
    othersVersionApi: {},
    supportMailAddress: "",
    saveRidingLogApiUrl: "",
    saveRidingLogVersionApi: "",
    hasMockAPI: false,
  );
}
