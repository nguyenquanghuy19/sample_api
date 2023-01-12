import 'package:elearning/core/l10n/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'ui/views/profile/update_profile_view.dart';

void main() {
  testGoldens('Forum Course view test', (tester) async {
    // Create multiple devices to test UI
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletLandscape,
        Device.tabletPortrait,
      ])
      ..addScenario(
        widget: const UpdateProfileView(),
        name: 'Update Profile View none',
      );
    // Load font from app
    await loadAppFonts();
    // Pumps the device builder into the widget tester.
    await tester.pumpDeviceBuilder(
      builder,
      wrapper: materialAppWrapper(
        theme: ThemeData.light(),
        localizations: const [
          _MyLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeOverrides: const [
          Locale('en'),
          Locale('ja', 'JP'),
        ],
      ),
    );
    await screenMatchesGolden(tester, 'update_profile_view');
  });
}

class _MyLocalizationsDelegate extends LocalizationsDelegate<Strings> {
  const _MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);

  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<Strings> old) => false;
}
