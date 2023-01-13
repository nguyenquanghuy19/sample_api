import 'package:flutter/material.dart';

class Constants {
  const Constants._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static const String stringEmpty = "";

  /// 15000msec
  static const int timeConnectTimeout = 15000;

  /// 15000msec
  static const int timeSendTimeout = 15000;

  /// 15000msec
  static const int timeReceiveTimeout = 15000;

  static const String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2M2MwZGQ0ZjZjYTliMjc1YmQ5YTI2NDMiLCJpYXQiOjE2NzM1ODM5NTEsImV4cCI6MTY3MzY3MDM1MX0.mzI0PCwnOXHKsfYuKWSdP21pxj4nh20LK_tAXwjCq6w';
}
