import '../models/models.dart';

class LerpTools {
  static double lerpDouble(double? a, double? b, double t) {
    if (a == null || b == null) return a ?? b!;
    return (1.0 - t) * a + t * b;
  }

  static ElevatedButtonStyleType? lerpButtonStyleType(
    ElevatedButtonStyleType? a,
    ElevatedButtonStyleType? b,
    double t,
  ) {
    if (a == null || b == null) {
      return a ?? b;
    }
    final int lerpValue = (lerpDouble(a.index.toDouble(), b.index.toDouble(), t) + 0.5).round();
    return ElevatedButtonStyleType.values[lerpValue];
  }
}
