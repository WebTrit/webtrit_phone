import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/common/common.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

extension TextFieldConfigToStyle on TextFieldConfig {
  TextFieldStyle toStyle({required ColorScheme colors, required ThemeData theme, TextFieldStyle? base}) {
    final baseTextStyle = base?.textStyle ?? theme.textTheme.bodyLarge ?? const TextStyle();

    final configTextStyle = style?.toTextStyle(
      defaultFontSize: baseTextStyle.fontSize,
      defaultFontWeight: baseTextStyle.fontWeight,
    );

    final effectiveTextStyle = baseTextStyle.merge(configTextStyle);

    final styleFromConfig = TextFieldStyle(
      decoration: decoration?.toInputDecoration(colors: colors, baseStyle: effectiveTextStyle),
      textStyle: effectiveTextStyle.copyWith(color: colors.onSurface),
      textAlign: _mapTextAlign(textAlign),
      showCursor: showCursor,
      keyboardType: _mapKeyboardType(keyboardType),
      mask: mask != null ? _mapMask(mask) : null,
      inputValue: _mapInputValue(inputValue),
    );

    return TextFieldStyle.merge(base, styleFromConfig);
  }

  InputValue? _mapInputValue(InputValueConfig? config) {
    if (config == null) return null;
    return InputValue(includePrefixInData: config.includePrefixInData, initialValue: config.initialValue);
  }

  InputMaskStyle? _mapMask(MaskConfig? config) {
    if (config == null) return null;
    return InputMaskStyle(pattern: config.pattern, filter: config.filter);
  }

  TextAlign _mapTextAlign(String? v) {
    switch (v) {
      case 'left':
        return TextAlign.left;
      case 'right':
        return TextAlign.right;
      case 'start':
        return TextAlign.start;
      case 'end':
        return TextAlign.end;
      case 'justify':
        return TextAlign.justify;
      case 'center':
      default:
        return TextAlign.center;
    }
  }

  TextInputType _mapKeyboardType(String? v) {
    switch (v) {
      case 'number':
        return TextInputType.number;
      case 'phone':
        return TextInputType.phone;
      case 'email':
        return TextInputType.emailAddress;
      case 'multiline':
        return TextInputType.multiline;
      case 'text':
        return TextInputType.text;
      case 'none':
      default:
        return TextInputType.none;
    }
  }
}
