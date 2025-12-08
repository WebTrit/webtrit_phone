import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBarStyle with Diagnosticable {
  const AppBarStyle({this.backgroundColor, this.foregroundColor, this.primary = true, this.showBackButton = true});

  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool primary;
  final bool showBackButton;

  /// Shallow updates; null keeps current value.
  AppBarStyle copyWith({Color? backgroundColor, Color? foregroundColor, bool? primary, bool? showBackButton}) {
    return AppBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      primary: primary ?? this.primary,
      showBackButton: showBackButton ?? this.showBackButton,
    );
  }

  AppBarStyle merge(AppBarStyle? other) {
    if (other == null) return this;
    return AppBarStyle(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      foregroundColor: other.foregroundColor ?? foregroundColor,
      primary: other.primary,
      showBackButton: other.showBackButton,
    );
  }

  static AppBarStyle? lerp(AppBarStyle? a, AppBarStyle? b, double t) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;
    return AppBarStyle(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      foregroundColor: Color.lerp(a?.foregroundColor, b?.foregroundColor, t),
      primary: b?.primary ?? a?.primary ?? true,
      showBackButton: b?.showBackButton ?? a?.showBackButton ?? true,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(FlagProperty('primary', value: primary, ifTrue: 'primary'))
      ..add(FlagProperty('showBackButton', value: showBackButton, ifTrue: 'showBackButton'));
  }

  @override
  bool operator ==(Object other) {
    return other is AppBarStyle &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.primary == primary &&
        other.showBackButton == showBackButton;
  }

  @override
  int get hashCode => Object.hash(backgroundColor, foregroundColor, primary, showBackButton);
}
