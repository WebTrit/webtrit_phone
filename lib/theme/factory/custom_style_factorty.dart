import 'package:flutter/material.dart';

abstract class ThemeStyleGenerator {
  List<ThemeExtension> generateExtensions(
      ColorScheme colorScheme,
      ThemeWidgetConfig? widgetConfig,
      ThemePageConfig? pageConfig,
      );
}