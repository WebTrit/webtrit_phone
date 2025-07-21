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
      decoration: decoration?.types.contains('underline') == true
          ? TextDecoration.underline
          : decoration?.types.contains('lineThrough') == true
              ? TextDecoration.lineThrough
              : null,
      backgroundColor: backgroundColor?.toColor(),
    );
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
