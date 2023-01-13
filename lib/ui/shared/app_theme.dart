import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText extends TextStyle {
  static TextStyle get text8 => TextStyle(
        fontSize: 8.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text10 => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text12 => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text13 => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text14 => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text15 => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text16 => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text18 => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text20 => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text21 => TextStyle(
        fontSize: 21.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text22 => TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text24 => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text26 => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text28 => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text33 => TextStyle(
        fontSize: 33.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text40 => TextStyle(
        fontSize: 40.sp,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get text60 => TextStyle(
        fontSize: 60.sp,
        fontWeight: FontWeight.normal,
      );
}

class AppColor extends MaterialColor {
  const AppColor(int primary, Map<int, Color> swatch) : super(primary, swatch);
  static const Color backgroundGradientStart = Color(0xFF1D2238);
  static const Color colorsPrimary = Color(0xFF647FFF);
  static const Color colorsBackgroundItem = Color(0xFF8A32A9);

  static const MaterialColor primary = MaterialColor(
    _deepOrangePrimaryValue,
    <int, Color>{
      50: Color(0xFFFFE8D9),
      100: Color(0xFFFFD0B5),
      200: Color(0xFFFFB088),
      300: Color(0xFFFF9466),
      400: Color(0xFFF9703E),
      500: Color(0xFFF35627),
      600: Color(0xFFDE3A11),
      700: Color(0xFFC52707),
      800: Color(0xFFAD1D07),
      900: Color(0xFF841003),
    },
  );
  static const int _deepOrangePrimaryValue = 0xFFF35627;

  static const MaterialColor neutrals = MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      50: Color(0xFFF5F7FA),
      100: Color(0xFFE4E7EB),
      200: Color(0xFFCBD2D9),
      300: Color(0xFF9AA5B1),
      400: Color(0xFF7B8794),
      500: Color(0xFF616E7C),
      600: Color(0xFF52606D),
      700: Color(0xFF3E4C59),
      800: Color(0xFF323F4B),
      900: Color(0xFF1F2933),
    },
  );
  static const int _greyPrimaryValue = 0xFF52606D;

  static const MaterialColor blueAccent = MaterialColor(
    _blueAccentPrimaryValue,
    <int, Color>{
      100: Color(0xFF82B1FF),
      200: Color(_blueAccentPrimaryValue),
      300: Color(0xFF2F80ED),
      400: Color(0xFF2979FF),
      700: Color(0xFF2962FF),
      800: Color(0xFF0A6CDF),
      900: Color(0xFF104583),
    },
  );
  static const int _blueAccentPrimaryValue = 0xFF64ABFF;

  static const MaterialColor greenAccent = MaterialColor(
    _greenAccentPrimaryValue,
    <int, Color>{
      50: Color(0xFFE3F9E5),
      100: Color(0xFFC1EAC5),
      200: Color(0xFFA3D9A5),
      300: Color(0xFF7BC47F),
      400: Color(0xFF57AE5B),
      500: Color(0xFF3F9142),
      600: Color(0xFF2F8132),
      700: Color(0xFF207227),
      800: Color(0xFF0E5814),
      900: Color(0xFF05400A),
    },
  );
  static const int _greenAccentPrimaryValue = 0xFF3F9142;

  static const MaterialColor redApp = MaterialColor(
    _redPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFEEEE),
      100: Color(0xFFFACDCD),
      200: Color(0xFFF29B9B),
      300: Color(0xFFE66A6A),
      400: Color(0xFFD64545),
      500: Color(0xFFBA2525),
      600: Color(0xFFA61B1B),
      700: Color(0xFF911111),
      800: Color(0xFF780A0A),
      900: Color(0xFF610404),
    },
  );
  static const int _redPrimaryValue = 0xFFBA2525;

  static const MaterialColor yellow = MaterialColor(
    _yellowPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFFAEB),
      100: Color(0xFFFCEFC7),
      200: Color(0xFFF8E3A3),
      300: Color(0xFFF9DA8B),
      400: Color(0xFFF7D070),
      500: Color(0xFFE9B949),
      600: Color(0xFFC99A2E),
      700: Color(0xFFA27C1A),
      800: Color(0xFF7C5E10),
      900: Color(0xFF513C06),
    },
  );
  static const int _yellowPrimaryValue = 0xFFE9B949;

  static const MaterialColor supporting = MaterialColor(
    _supportingPrimaryValue,
    <int, Color>{
      50: Color(0xFFE0E8F9),
      100: Color(0xFFBED0F7),
      200: Color(0xFF98AEEB),
      300: Color(0xFF7B93DB),
      400: Color(0xFF647ACB),
      500: Color(0xFF4C63B6),
      600: Color(0xFF4055A8),
      700: Color(0xFF35469C),
      800: Color(0xFF2D3A8C),
      900: Color(0xFF19216C),
    },
  );
  static const int _supportingPrimaryValue = 0xFF4C63B6;
}
