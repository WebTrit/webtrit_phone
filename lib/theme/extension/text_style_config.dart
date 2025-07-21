import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/common/common.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

extension TextStyleConfigExtension on TextStyleConfig {
  TextStyle toTextStyle({required Color fallbackColor}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight?.toFontWeight(),
      fontStyle: fontStyle?.value == 'italic' ? FontStyle.italic : FontStyle.normal,
      color: color?.toColor() ?? fallbackColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: _resolveTextDecoration(decoration),
      backgroundColor: backgroundColor?.toColor(),
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
    return FontWeight.values.firstWhere(
      (fw) => fw.value == weight,
      orElse: () => FontWeight.normal,
    );
  }
}
