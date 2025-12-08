import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../tools/lerp_tools.dart';

class SmartIndicatorStyle with Diagnosticable {
  const SmartIndicatorStyle({this.backgroundColor, this.icon, this.sizeFactor});

  final Color? backgroundColor;
  final IconData? icon;

  final double? sizeFactor;

  static SmartIndicatorStyle merge(SmartIndicatorStyle? base, SmartIndicatorStyle? override) {
    if (base == null && override == null) return const SmartIndicatorStyle();
    base ??= const SmartIndicatorStyle();
    override ??= const SmartIndicatorStyle();
    return SmartIndicatorStyle(
      backgroundColor: override.backgroundColor ?? base.backgroundColor,
      icon: override.icon ?? base.icon,
      sizeFactor: override.sizeFactor ?? base.sizeFactor,
    );
  }

  static SmartIndicatorStyle? lerp(SmartIndicatorStyle? a, SmartIndicatorStyle? b, double t) {
    if (identical(a, b)) return a;
    if (a == null && b == null) return null;

    return SmartIndicatorStyle(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      // icon: non-animatable; prefer target when present
      icon: b?.icon ?? a?.icon,
      sizeFactor: LerpTools.lerpDouble(a?.sizeFactor, b?.sizeFactor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(DoubleProperty('sizeFactor', sizeFactor));
  }
}
