import 'package:flutter/material.dart';

import 'theme.dart';

class CustomColor {
  const CustomColor({
    required this.color,
    this.blend = true,
  });

  final Color color;
  final bool blend;

  Color value(ThemeProvider provider) {
    return provider.custom(this);
  }
}
