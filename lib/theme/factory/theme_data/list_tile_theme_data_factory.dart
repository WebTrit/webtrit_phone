import 'package:flutter/material.dart';

import '../theme_style_factory.dart';

class ListTileThemeDataFactory implements ThemeStyleFactory<ListTileThemeData> {
  ListTileThemeDataFactory(this.colors);

  final ColorScheme colors;

  @override
  ListTileThemeData create() {
    return ListTileThemeData(iconColor: colors.secondary);
  }
}
