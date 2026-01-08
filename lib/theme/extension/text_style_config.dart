import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/common/common.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

extension TextStyleConfigExtension on TextStyleConfig {
  TextStyle toTextStyle({
    String? defaultFontFamily,
    double? defaultFontSize,
    FontWeight? defaultFontWeight,
    FontStyle defaultFontStyle = FontStyle.normal,
    double? defaultLetterSpacing,
    double? defaultWordSpacing,
    double? defaultHeight,
    TextDecoration? defaultDecoration,
    Color? defaultBackgroundColor,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? defaultFontFamily,
      fontSize: fontSize ?? defaultFontSize,
      fontWeight: fontWeight?.toFontWeight() ?? defaultFontWeight ?? FontWeight.normal,
      fontStyle: fontStyle?.value == 'italic' ? FontStyle.italic : defaultFontStyle,
      color: color?.toColor(),
      letterSpacing: letterSpacing ?? defaultLetterSpacing,
      wordSpacing: wordSpacing ?? defaultWordSpacing,
      height: height ?? defaultHeight,
      decoration: _resolveTextDecoration(decoration) ?? defaultDecoration,
      backgroundColor: backgroundColor?.toColor() ?? defaultBackgroundColor,
    );
  }

  TextDecoration? _resolveTextDecoration(TextDecorationConfig? config) {
    if (config?.types.isEmpty ?? true) return null;

    final decorations = config!.types.map((type) {
      switch (type) {
        case 'underline':
          return TextDecoration.underline;
        case 'lineThrough':
          return TextDecoration.lineThrough;
        case 'overline':
          return TextDecoration.overline;
        default:
          return TextDecoration.none;
      }
    }).toList();

    return TextDecoration.combine(decorations);
  }
}

extension FontWeightConfigExtension on FontWeightConfig {
  FontWeight? toFontWeight() {
    return FontWeight.values.firstWhere((fw) => fw.value == weight, orElse: () => FontWeight.normal);
  }
}
