import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kSystemThemeLight = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.white,
  statusBarColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarDividerColor: Colors.white,
);

const kSystemThemeDark = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.black,
  statusBarColor: Colors.black,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarDividerColor: Colors.black,
);
