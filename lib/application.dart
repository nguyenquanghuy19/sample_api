import 'package:testproject/core/constants/constants.dart';
import 'package:testproject/core/utils/log_utils.dart';
import 'package:testproject/ui/shared/app_theme.dart';
import 'package:testproject/view_models/application_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/l10n/strings.dart';
import 'core/navigator/top_screen/top_screen_routes.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver {
  //TODO kWidgetGroupId
  final String kWidgetGroupId = "";
  final ApplicationViewModel _applicationViewModel = ApplicationViewModel();
  String? locale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
  }

  void _onBuildCompleted(Duration timestamp) {
    LogUtils.d("onBuildCompleted");
  }

  @override
  Widget build(BuildContext context) {
    return _buildApplication();
  }

  Widget _buildApplication() {
    return ChangeNotifierProvider<ApplicationViewModel>(
      create: (_) => _applicationViewModel,
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, chile) {
          return MaterialApp(
            onGenerateTitle: (context) => "Name project",
            theme: ThemeData(
              primarySwatch: AppColor.primary,
              unselectedWidgetColor: Colors.white,
            ),
            localizationsDelegates: const [
              _MyLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ja', 'JP'),
              Locale('vi', 'VN'),
            ],
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              // Check if the current device locale is supported
              for (var supportedLocale in supportedLocales) {
                if (deviceLocale != null) {
                  if (supportedLocale.languageCode ==
                      deviceLocale.languageCode) {
                    if (supportedLocale.countryCode ==
                            deviceLocale.countryCode ||
                        supportedLocale.scriptCode == deviceLocale.scriptCode) {
                      if (locale != null) {
                        return Locale(locale ?? 'en', '');
                      }

                      return Locale(
                        supportedLocale.languageCode,
                        supportedLocale.countryCode,
                      );
                    }
                  }
                }
              }

              // If the locale of the device is not supported set default English
              return const Locale(
                'en',
              );
            },
            initialRoute: TopScreenRoutes().initialRoute(),
            onGenerateRoute: TopScreenRoutes().routeBuilders,
            navigatorKey: Constants.navigatorKey,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _applicationViewModel.destroySingletonObject();
    super.dispose();
  }
}

class _MyLocalizationsDelegate extends LocalizationsDelegate<Strings> {
  const _MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ja', 'vi'].contains(locale.languageCode);

  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<Strings> old) => false;
}
