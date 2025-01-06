import 'package:webtrit_appearance_theme/webtrit_appearance_theme.dart';

class LerpTools {
  static double lerpDouble(double? a, double? b, double t) {
    if (a == null || b == null) return a ?? b ?? 0;
    return (1.0 - t) * a + t * b;
  }

  static ElevatedButtonStyleType? lerpButtonStyleType(
    ElevatedButtonStyleType? a,
    ElevatedButtonStyleType? b,
    double t,
  ) {
    if (a == null || b == null) {
      return a ?? b;
    } else {
      return t < 0.5 ? a : b;
    }
  }
}
