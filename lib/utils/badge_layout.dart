import 'dart:ui';

/// Where to anchor the badge inside a rectangular host.
enum BadgeAnchor { topLeft, topRight, bottomLeft, bottomRight, center }

/// Generic badge layouter that computes a Rect for a badge
/// inside a rectangular host (width x height).
class BadgeLayout {
  /// Places a square badge whose side = `min(width, height) * sizeFactor`
  /// at the given [anchor]. Optional [dxFactor]/[dyFactor] nudge it.
  ///
  /// - [sizeFactor] is relative to the host's min dimension.
  /// - [dxFactor]/[dyFactor] are also relative to the min dimension (can be negative).
  static Rect rectFor({
    required double width,
    required double height,
    required double sizeFactor,
    required BadgeAnchor anchor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) {
    final minSide = width < height ? width : height;
    final side = minSide * sizeFactor;

    double x, y;
    switch (anchor) {
      case BadgeAnchor.topLeft:
        x = 0.0;
        y = 0.0;
        break;
      case BadgeAnchor.topRight:
        x = width - side;
        y = 0.0;
        break;
      case BadgeAnchor.bottomLeft:
        x = 0.0;
        y = height - side;
        break;
      case BadgeAnchor.bottomRight:
        x = width - side;
        y = height - side;
        break;
      case BadgeAnchor.center:
        x = (width - side) / 2.0;
        y = (height - side) / 2.0;
        break;
    }

    x += minSide * dxFactor;
    y += minSide * dyFactor;

    return Rect.fromLTWH(x, y, side, side);
  }

  /// Convenience for square hosts (e.g., circular avatars).
  static Rect rectForSquare({
    required double size,
    required double sizeFactor,
    required BadgeAnchor anchor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) {
    return rectFor(
      width: size,
      height: size,
      sizeFactor: sizeFactor,
      anchor: anchor,
      dxFactor: dxFactor,
      dyFactor: dyFactor,
    );
  }

  static Rect topLeft({
    required double width,
    required double height,
    required double sizeFactor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) => rectFor(
    width: width,
    height: height,
    sizeFactor: sizeFactor,
    anchor: BadgeAnchor.topLeft,
    dxFactor: dxFactor,
    dyFactor: dyFactor,
  );

  static Rect topRight({
    required double width,
    required double height,
    required double sizeFactor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) => rectFor(
    width: width,
    height: height,
    sizeFactor: sizeFactor,
    anchor: BadgeAnchor.topRight,
    dxFactor: dxFactor,
    dyFactor: dyFactor,
  );

  static Rect bottomLeft({
    required double width,
    required double height,
    required double sizeFactor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) => rectFor(
    width: width,
    height: height,
    sizeFactor: sizeFactor,
    anchor: BadgeAnchor.bottomLeft,
    dxFactor: dxFactor,
    dyFactor: dyFactor,
  );

  static Rect bottomRight({
    required double width,
    required double height,
    required double sizeFactor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) => rectFor(
    width: width,
    height: height,
    sizeFactor: sizeFactor,
    anchor: BadgeAnchor.bottomRight,
    dxFactor: dxFactor,
    dyFactor: dyFactor,
  );

  static Rect center({
    required double width,
    required double height,
    required double sizeFactor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) => rectFor(
    width: width,
    height: height,
    sizeFactor: sizeFactor,
    anchor: BadgeAnchor.center,
    dxFactor: dxFactor,
    dyFactor: dyFactor,
  );

  static Rect topLeftSquare({
    required double size,
    required double sizeFactor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) => rectForSquare(
    size: size,
    sizeFactor: sizeFactor,
    anchor: BadgeAnchor.topLeft,
    dxFactor: dxFactor,
    dyFactor: dyFactor,
  );

  static Rect topRightSquare({
    required double size,
    required double sizeFactor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) => rectForSquare(
    size: size,
    sizeFactor: sizeFactor,
    anchor: BadgeAnchor.topRight,
    dxFactor: dxFactor,
    dyFactor: dyFactor,
  );

  static Rect bottomLeftSquare({
    required double size,
    required double sizeFactor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) => rectForSquare(
    size: size,
    sizeFactor: sizeFactor,
    anchor: BadgeAnchor.bottomLeft,
    dxFactor: dxFactor,
    dyFactor: dyFactor,
  );

  static Rect bottomRightSquare({
    required double size,
    required double sizeFactor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) => rectForSquare(
    size: size,
    sizeFactor: sizeFactor,
    anchor: BadgeAnchor.bottomRight,
    dxFactor: dxFactor,
    dyFactor: dyFactor,
  );

  static Rect centerSquare({
    required double size,
    required double sizeFactor,
    double dxFactor = 0.0,
    double dyFactor = 0.0,
  }) => rectForSquare(
    size: size,
    sizeFactor: sizeFactor,
    anchor: BadgeAnchor.center,
    dxFactor: dxFactor,
    dyFactor: dyFactor,
  );
}
