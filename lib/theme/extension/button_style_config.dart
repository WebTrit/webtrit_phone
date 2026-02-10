import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

extension ButtonStyleConfigExtension on ButtonStyleConfig {
  ButtonStyle toButtonStyle({required String? defaultFontFamily}) {
    return ButtonStyle(
      textStyle: textStyle != null
          ? WidgetStateProperty.all(textStyle!.toTextStyle(defaultFontFamily: defaultFontFamily))
          : null,
      backgroundColor: _resolveColor(backgroundColor, disabledBackgroundColor),
      foregroundColor: _resolveColor(foregroundColor, disabledForegroundColor),
      overlayColor: overlayColor != null ? WidgetStateProperty.all(overlayColor!.toColor()) : null,
      shadowColor: _resolveColor(shadowColor, disabledShadowColor),
      surfaceTintColor: surfaceTintColor != null ? WidgetStateProperty.all(surfaceTintColor!.toColor()) : null,
      elevation: elevation != null ? WidgetStateProperty.all(elevation) : null,
      padding: padding != null ? WidgetStateProperty.all(padding!.toEdgeInsets()) : null,
      minimumSize: minimumSize != null ? WidgetStateProperty.all(minimumSize!.toSize()) : null,
      fixedSize: fixedSize != null ? WidgetStateProperty.all(fixedSize!.toSize()) : null,
      maximumSize: maximumSize != null ? WidgetStateProperty.all(maximumSize!.toSize()) : null,
      iconColor: _resolveColor(iconColor, disabledIconColor),
      iconSize: iconSize != null ? WidgetStateProperty.all(iconSize) : null,
      side: side != null ? WidgetStateProperty.all(side!.toBorderSide()) : null,
      shape: shape != null ? WidgetStateProperty.all(shape!.toOutlinedBorder()) : null,
      visualDensity: visualDensity?.toVisualDensity(),
      animationDuration: animationDuration != null ? Duration(milliseconds: animationDuration!) : null,
    );
  }

  WidgetStateProperty<Color?>? _resolveColor(String? normal, String? disabled) {
    if (normal == null && disabled == null) return null;
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return disabled?.toColor();
      }
      return normal?.toColor();
    });
  }
}

extension SizeConfigExtension on SizeConfig {
  Size toSize() => Size(width, height);
}

extension EdgeInsetsConfigExtension on EdgeInsetsConfig {
  EdgeInsets toEdgeInsets() => EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
}

extension BorderSideConfigExtension on BorderSideConfig {
  BorderSide toBorderSide() {
    final resolvedColor = color?.toColor();
    if (resolvedColor == null) return BorderSide.none;

    return BorderSide(
      color: resolvedColor,
      width: width,
      style: style == 'none' ? BorderStyle.none : BorderStyle.solid,
    );
  }
}

extension ShapeBorderConfigExtension on ShapeBorderConfig {
  OutlinedBorder toOutlinedBorder() {
    switch (type) {
      case 'rounded':
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 0.0));
      case 'circle':
        return const CircleBorder();
      case 'stadium':
        return const StadiumBorder();
      case 'beveled':
        return BeveledRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 0.0));
      default:
        return const RoundedRectangleBorder();
    }
  }
}

extension VisualDensityConfigExtension on VisualDensityConfig {
  VisualDensity toVisualDensity() => VisualDensity(horizontal: horizontal, vertical: vertical);
}
