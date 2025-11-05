import 'package:flutter/material.dart';

import '../../extension/extension.dart';
import '../theme_style_factory.dart';

class InputDecorationStyleFactory implements ThemeStyleFactory<InputDecorations> {
  InputDecorationStyleFactory(this.colors);

  final ColorScheme colors;

  @override
  InputDecorations create() {
    return const InputDecorations(
      search: InputDecoration(isDense: false, filled: false, isCollapsed: true, border: InputBorder.none),
      keypad: InputDecoration(filled: false, border: InputBorder.none),
    );
  }
}
