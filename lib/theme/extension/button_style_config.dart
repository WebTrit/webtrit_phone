import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';

extension ButtonStyleConfigExtension on ButtonStyleConfig {
  ButtonStyle toButtonStyle() {
    return ButtonStyle(
      textStyle: textStyle != null ? WidgetStateProperty.all(textStyle!.toTextStyle()) : null,
      backgroundColor: backgroundColor != null ? WidgetStateProperty.all(backgroundColor!.toColor()) : null,
      foregroundColor: foregroundColor != null ? WidgetStateProperty.all(foregroundColor!.toColor()) : null,
      overlayColor: overlayColor != null ? WidgetStateProperty.all(overlayColor!.toColor()) : null,
      shadowColor: shadowColor != null ? WidgetStateProperty.all(shadowColor!.toColor()) : null,
      surfaceTintColor: surfaceTintColor != null ? WidgetStateProperty.all(surfaceTintColor!.toColor()) : null,
      elevation: elevation != null ? WidgetStateProperty.all(elevation) : null,
      padding: padding != null ? WidgetStateProperty.all(padding!.toEdgeInsets()) : null,
      minimumSize: minimumSize != null ? WidgetStateProperty.all(minimumSize!.toSize()) : null,
      fixedSize: fixedSize != null ? WidgetStateProperty.all(fixedSize!.toSize()) : null,
      maximumSize: maximumSize != null ? WidgetStateProperty.all(maximumSize!.toSize()) : null,
      iconColor: iconColor != null ? WidgetStateProperty.all(iconColor!.toColor()) : null,
      iconSize: iconSize != null ? WidgetStateProperty.all(iconSize) : null,
      side: side != null ? WidgetStateProperty.all(side!.toBorderSide()) : null,
      shape: shape != null ? WidgetStateProperty.all(shape!.toOutlinedBorder()) : null,
      visualDensity: visualDensity?.toVisualDensity(),
      animationDuration: animationDuration != null ? Duration(milliseconds: animationDuration!) : null,
    );
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
    return BorderSide(
      color: color?.toColor() ?? const Color(0xFF000000),
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
