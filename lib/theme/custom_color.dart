import 'package:flutter/material.dart';

import 'theme_json_serializable.dart';
import 'theme.dart';

part 'custom_color.g.dart';

@themeJsonSerializable
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

  factory CustomColor.fromJson(Map<String, dynamic> json) => _$CustomColorFromJson(json);

  Map<String, dynamic> toJson() => _$CustomColorToJson(this);
}
