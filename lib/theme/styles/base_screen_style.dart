import 'package:flutter/foundation.dart';

import 'background_style.dart';

export 'background_style.dart';

/// A base class for screen styles that includes common properties like background.
///
/// This abstract class provides the foundation for screen-specific styles,
/// managing shared attributes such as [BackgroundStyle].
abstract class BaseScreenStyle with Diagnosticable {
  /// Creates a base screen style.
  const BaseScreenStyle({this.background});

  /// The background style configuration for the screen.
  final BackgroundStyle? background;

  /// Linearly interpolates between two [BackgroundStyle]s.
  ///
  /// This is a convenience proxy to [BackgroundStyle.lerp].
  static BackgroundStyle? lerp(BackgroundStyle? a, BackgroundStyle? b, double t) {
    return BackgroundStyle.lerp(a, b, t);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BackgroundStyle?>('background', background));
  }
}
