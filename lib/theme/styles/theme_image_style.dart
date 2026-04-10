import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

/// Defines the visual styling properties for an image or SVG asset within the app theme.
///
/// This style class encapsulates properties for rendering, positioning,
/// and decorating visual assets, allowing for consistent theming across the application.
class ThemeImageStyle with Diagnosticable {
  /// Creates a theme image style.
  const ThemeImageStyle({
    this.picture,
    this.widthFactor,
    this.heightFactor,
    this.padding,
    this.alignment,
    this.fit,
    this.color,
    this.blendMode,
    this.backgroundColor,
    this.borderRadius,
  });

  /// The SVG asset specific to this style.
  final ThemeSvgAsset? picture;

  /// If non-null, the width of the image is multiplied by this factor.
  final double? widthFactor;

  /// If non-null, the height of the image is multiplied by this factor.
  final double? heightFactor;

  /// The amount of space by which to inset the image.
  final EdgeInsets? padding;

  /// How to align the image within its bounds.
  final AlignmentGeometry? alignment;

  /// How to inscribe the image into the space allocated during layout.
  final BoxFit? fit;

  /// If non-null, this color is blended with each image pixel using [blendMode].
  final Color? color;

  /// The blend mode applied to [color] and the image.
  final BlendMode? blendMode;

  /// The background color to fill behind the image.
  final Color? backgroundColor;

  /// If non-null, the corners of this image are rounded by this radius.
  final BorderRadius? borderRadius;

  /// Creates a copy of [ThemeImageStyle] where values from [b] take precedence over [a].
  ///
  /// If [a] is null, returns [b] (or an empty style if [b] is also null).
  /// If [b] is null, returns [a].
  static ThemeImageStyle merge(ThemeImageStyle? a, ThemeImageStyle? b) {
    if (a == null) return b ?? const ThemeImageStyle();
    if (b == null) return a;

    return ThemeImageStyle(
      picture: b.picture ?? a.picture,
      widthFactor: b.widthFactor ?? a.widthFactor,
      heightFactor: b.heightFactor ?? a.heightFactor,
      padding: b.padding ?? a.padding,
      alignment: b.alignment ?? a.alignment,
      fit: b.fit ?? a.fit,
      color: b.color ?? a.color,
      blendMode: b.blendMode ?? a.blendMode,
      backgroundColor: b.backgroundColor ?? a.backgroundColor,
      borderRadius: b.borderRadius ?? a.borderRadius,
    );
  }

  /// Linearly interpolates between two [ThemeImageStyle]s.
  ///
  /// For properties that cannot be interpolated (like [picture], [fit], [blendMode]),
  /// the value from [a] is used if [t] < 0.5, otherwise the value from [b] is used.
  static ThemeImageStyle? lerp(ThemeImageStyle? a, ThemeImageStyle? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return ThemeImageStyle(
      picture: t < 0.5 ? a?.picture : b?.picture,
      widthFactor: LerpTools.lerpDouble(a?.widthFactor, b?.widthFactor, t),
      heightFactor: LerpTools.lerpDouble(a?.heightFactor, b?.heightFactor, t),
      padding: EdgeInsets.lerp(a?.padding, b?.padding, t),
      alignment: AlignmentGeometry.lerp(a?.alignment, b?.alignment, t),
      fit: t < 0.5 ? a?.fit : b?.fit,
      color: Color.lerp(a?.color, b?.color, t),
      blendMode: t < 0.5 ? a?.blendMode : b?.blendMode,
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      borderRadius: BorderRadius.lerp(a?.borderRadius, b?.borderRadius, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeSvgAsset?>('picture', picture));
    properties.add(DiagnosticsProperty<double?>('widthFactor', widthFactor));
    properties.add(DiagnosticsProperty<double?>('heightFactor', heightFactor));
    properties.add(DiagnosticsProperty<EdgeInsets?>('padding', padding));
    properties.add(DiagnosticsProperty<AlignmentGeometry?>('alignment', alignment));
    properties.add(EnumProperty<BoxFit?>('fit', fit));
    properties.add(ColorProperty('color', color));
    properties.add(EnumProperty<BlendMode?>('blendMode', blendMode));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(DiagnosticsProperty<BorderRadius?>('borderRadius', borderRadius));
  }
}
