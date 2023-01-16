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

  /// Token to test transition to MainView
  static const String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2M2M0YWY5MDZjYTliMjc1YmQ5YTI2YTEiLCJpYXQiOjE2NzM4MzQzODQsImV4cCI6MTY3MzkyMDc4NH0.U9taAUXzQUGb0mrPkdJP1Bfm1cGZYLEpgopVEYvFcAM';
}
