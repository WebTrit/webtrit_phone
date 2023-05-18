import 'package:flutter/material.dart';

class ConstTexts extends ThemeExtension<ConstTexts> {
  const ConstTexts({
    required this.appName,
  });

  final String? appName;

  @override
  ThemeExtension<ConstTexts> copyWith({
    String? appName,
  }) {
    return ConstTexts(
      appName: appName ?? this.appName,
    );
  }

  @override
  ThemeExtension<ConstTexts> lerp(ThemeExtension<ConstTexts>? other, double t) {
    if (other is! ConstTexts) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}
