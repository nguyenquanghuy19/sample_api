import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/fonts.dart';
import 'package:elearning/view_models/application_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'core/data/share_preference/spref_locale_model.dart';
import 'core/l10n/strings.dart';
import 'core/navigator/top_screen/top_screen_routes.dart';
import 'core/utils/log_utils.dart';

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
    locale = SPrefLocaleModel().getLocale();
  }

  void _onBuildCompleted(Duration timestamp) {
    LogUtils.d("onBuildCompleted");
  }

  @override
  Widget build(BuildContext context) {
    return _buildApplication();
  }

  Widget _buildApplication() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApplicationViewModel>(
          create: (_) => _applicationViewModel,
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, chile) {
          //TODO: cần review lại solution này
          return Consumer<ApplicationViewModel>(
            builder: (context, value, child) => OverlaySupport(
              child: MaterialApp(
                onGenerateTitle: (context) => "Name project",
                themeMode: value.mode,
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: AppColor.primary,
                  unselectedWidgetColor: Colors.white,
                  brightness: Brightness.light,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(),
                    bodyText2: TextStyle(),
                  ).apply(
                    bodyColor: AppColor.neutrals.shade800,
                    displayColor: AppColor.neutrals.shade800,
                  ),
                  appBarTheme: AppBarTheme(
                    backgroundColor: Colors.white,
                    toolbarHeight: Constants.appBarHeight,
                    elevation: 0,
                    titleTextStyle: AppText.text22.copyWith(
                      color: AppColor.neutrals.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  fontFamily: Fonts.notoSans,
                ),
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: Colors.black12,
                  primarySwatch: AppColor.primary,
                  unselectedWidgetColor: Colors.white,
                  brightness: Brightness.dark,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  backgroundColor: Colors.grey[900],
                  fontFamily: Fonts.notoSans,
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
                            supportedLocale.scriptCode ==
                                deviceLocale.scriptCode) {
                          if (locale != null) {
                            return Locale(locale ?? 'en', '');
                          }
                          SPrefLocaleModel()
                              .setLocale(deviceLocale.languageCode);

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
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    LogUtils.d("app killed ...");
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
