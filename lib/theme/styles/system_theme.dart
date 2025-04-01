import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kSystemThemeLight = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.white,
  statusBarColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarDividerColor: Colors.white,
);

const kSystemThemeDarkTransparent = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.transparent,
  statusBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarDividerColor: Colors.transparent,
);
