import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

/// What a button falls back to for a color the theme leaves empty.
///
/// Without one, an empty slot stays empty and whatever the widget is merged
/// into decides - which is what most editors want. A screen that paints its own
/// buttons passes one, and then every state resolves to a real color.
class ButtonStyleFallback {
  const ButtonStyleFallback({
    required this.background,
    required this.foreground,
    required this.icon,
    this.selectedBackground,
    this.selectedForeground,
    this.selectedIcon,
    this.disabledBackground,
    this.disabledIcon,
    this.disabledOpacity = 0.40,
  });

  final Color background;
  final Color foreground;
  final Color icon;

  /// Used while the button is switched on. Null means a toggle is not expected
  /// here, and the resting colors are kept.
  final Color? selectedBackground;
  final Color? selectedForeground;
  final Color? selectedIcon;

  /// Disabled colors are the resting ones faded by [disabledOpacity], except
  /// these two when they are set.
  final Color? disabledBackground;
  final Color? disabledIcon;

  /// How much of the resting color is left while the button is unavailable.
  /// Applied as a factor, so a translucent color keeps fading instead of being
  /// snapped to a fixed alpha - which could leave it unchanged, or brighter.
  final double disabledOpacity;
}

extension ButtonStyleConfigExtension on ButtonStyleConfig {
  ButtonStyle toButtonStyle({required String? defaultFontFamily, ButtonStyleFallback? fallback}) {
    final resolvedForeground = _resolveColor(
      foregroundColor,
      disabledForegroundColor,
      selected: selectedForegroundColor,
      fallback: fallback,
      restingFallback: fallback?.foreground,
      selectedFallback: fallback?.selectedForeground,
    );

    return ButtonStyle(
      textStyle: textStyle != null
          ? WidgetStateProperty.all(textStyle!.toTextStyle(defaultFontFamily: defaultFontFamily))
          : null,
      backgroundColor: _resolveColor(
        backgroundColor,
        disabledBackgroundColor,
        selected: selectedBackgroundColor,
        fallback: fallback,
        restingFallback: fallback?.background,
        selectedFallback: fallback?.selectedBackground,
        disabledFallback: fallback?.disabledBackground,
      ),
      foregroundColor: resolvedForeground,
      // Material derives the ripple from the foreground; keep that when the
      // theme does not name a color of its own.
      overlayColor: overlayColor != null
          ? WidgetStateProperty.all(overlayColor!.toColor())
          : (fallback == null ? null : _overlayFrom(resolvedForeground)),
      shadowColor: _resolveColor(shadowColor, disabledShadowColor),
      surfaceTintColor: surfaceTintColor != null ? WidgetStateProperty.all(surfaceTintColor!.toColor()) : null,
      elevation: elevation != null ? WidgetStateProperty.all(elevation) : null,
      padding: padding != null ? WidgetStateProperty.all(padding!.toEdgeInsets()) : null,
      minimumSize: minimumSize != null ? WidgetStateProperty.all(minimumSize!.toSize()) : null,
      fixedSize: fixedSize != null ? WidgetStateProperty.all(fixedSize!.toSize()) : null,
      maximumSize: maximumSize != null ? WidgetStateProperty.all(maximumSize!.toSize()) : null,
      iconColor: _resolveColor(
        iconColor,
        disabledIconColor,
        selected: selectedIconColor,
        fallback: fallback,
        restingFallback: fallback?.icon,
        selectedFallback: fallback?.selectedIcon,
        disabledFallback: fallback?.disabledIcon,
      ),
      iconSize: iconSize != null ? WidgetStateProperty.all(iconSize) : null,
      side: side != null ? WidgetStateProperty.all(side!.toBorderSide()) : null,
      shape: shape != null ? WidgetStateProperty.all(shape!.toOutlinedBorder()) : null,
      visualDensity: visualDensity?.toVisualDensity(),
      animationDuration: animationDuration != null ? Duration(milliseconds: animationDuration!) : null,
    );
  }

  /// Resolves one color across the states a button can be in.
  ///
  /// Note that [ButtonStyle.merge] works property by property, not state by
  /// state: a resolver that answers null for one state wipes that state on
  /// whatever it is merged over. So once a fallback is given, every state
  /// answers with a color.
  WidgetStateProperty<Color?>? _resolveColor(
    String? resting,
    String? disabled, {
    String? selected,
    ButtonStyleFallback? fallback,
    Color? restingFallback,
    Color? selectedFallback,
    Color? disabledFallback,
  }) {
    if (fallback == null) {
      // Without a fallback the answer for an unset state has to be null, and a
      // null answer does not mean "keep what you had": composition happens per
      // property, so the whole property would be replaced and the base color
      // lost. A style that names only a switched-on color therefore stays out
      // of the way here - it takes a fallback for that color to mean anything.
      if (resting == null && disabled == null) return null;
      return WidgetStateProperty.resolveWith(
        (states) => _pickColor(
          states,
          resting: resting?.toColor(),
          selected: selected?.toColor(),
          disabled: disabled?.toColor(),
          selectedDisabled: disabled?.toColor(),
        ),
      );
    }

    final restingColor = resting?.toColor() ?? restingFallback;
    final selectedColor = selected?.toColor() ?? selectedFallback ?? restingColor;
    final statedDisabled = disabled?.toColor() ?? disabledFallback;

    return WidgetStateProperty.resolveWith(
      (states) => _pickColor(
        states,
        resting: restingColor,
        selected: selectedColor,
        disabled: statedDisabled ?? _faded(restingColor, fallback.disabledOpacity),
        // A switched-on control that becomes unavailable keeps reading as on,
        // only dimmed - otherwise the state silently disappears.
        selectedDisabled: statedDisabled ?? _faded(selectedColor, fallback.disabledOpacity),
      ),
    );
  }

  WidgetStateProperty<Color?>? _overlayFrom(WidgetStateProperty<Color?>? foreground) {
    if (foreground == null) return null;
    return WidgetStateProperty.resolveWith((states) => _overlayColor(states, foreground.resolve(states)));
  }
}

/// Which color a state asks for. Unavailable wins over switched-on, but a
/// control that is both gets its own answer, so the switched-on look survives
/// as a dimmed version of itself.
Color? _pickColor(
  Set<WidgetState> states, {
  Color? resting,
  Color? selected,
  Color? disabled,
  Color? selectedDisabled,
}) {
  if (states.contains(WidgetState.disabled)) {
    return states.contains(WidgetState.selected) ? selectedDisabled ?? disabled : disabled;
  }
  if (states.contains(WidgetState.selected)) return selected ?? resting;
  return resting;
}

/// The ripple Material would have derived from the foreground itself.
Color? _overlayColor(Set<WidgetState> states, Color? foreground) {
  if (foreground == null) return null;
  if (states.contains(WidgetState.pressed)) return foreground.withValues(alpha: 0.1);
  if (states.contains(WidgetState.hovered)) return foreground.withValues(alpha: 0.08);
  if (states.contains(WidgetState.focused)) return foreground.withValues(alpha: 0.1);
  return null;
}

/// Fades a color by a factor, so a translucent one keeps fading instead of
/// being snapped to a fixed alpha.
Color? _faded(Color? color, double opacity) => color?.withValues(alpha: color.a * opacity);

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
