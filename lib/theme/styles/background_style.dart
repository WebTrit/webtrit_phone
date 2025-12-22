import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

/// A base class defining the background style of a screen or widget.
///
/// This sealed class allows for strictly typed background variants:
/// - [SolidBackgroundStyle] for single colors.
/// - [GradientBackgroundStyle] for linear gradients.
/// - [ImageBackgroundStyle] for network or asset images.
@immutable
sealed class BackgroundStyle extends Equatable with Diagnosticable {
  const BackgroundStyle();

  /// Linearly interpolates between two [BackgroundStyle]s.
  ///
  /// - If both are [SolidBackgroundStyle], it interpolates the color.
  /// - If both are [GradientBackgroundStyle], it interpolates the gradient.
  /// - If both are [ImageBackgroundStyle], it performs a cross-fade (fading out [a] then fading in [b]).
  /// - If types differ, it swaps instantly at t=0.5.
  static BackgroundStyle? lerp(BackgroundStyle? a, BackgroundStyle? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b;
    if (b == null) return a;

    if (a is SolidBackgroundStyle && b is SolidBackgroundStyle) {
      return SolidBackgroundStyle(color: Color.lerp(a.color, b.color, t)!);
    }

    if (a is GradientBackgroundStyle && b is GradientBackgroundStyle) {
      return GradientBackgroundStyle(gradient: LinearGradient.lerp(a.gradient, b.gradient, t)!);
    }

    if (a is ImageBackgroundStyle && b is ImageBackgroundStyle) {
      // Cross-fade logic:
      // 0.0 -> 0.5: Fade out 'a' (opacity -> 0)
      // 0.5 -> 1.0: Fade in 'b' (opacity 0 -> target)
      if (t < 0.5) {
        return a.copyWith(opacity: ui.lerpDouble(a.opacity, 0, t * 2));
      } else {
        return b.copyWith(opacity: ui.lerpDouble(0, b.opacity, (t - 0.5) * 2));
      }
    }

    // Fallback for mismatched types
    return t < 0.5 ? a : b;
  }

  @override
  List<Object?> get props => [];
}

/// A background style represented by a single solid color.
final class SolidBackgroundStyle extends BackgroundStyle {
  const SolidBackgroundStyle({required this.color});

  /// The solid color to paint.
  final Color color;

  @override
  List<Object?> get props => [color];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
  }
}

/// A background style represented by a linear gradient.
final class GradientBackgroundStyle extends BackgroundStyle {
  const GradientBackgroundStyle({required this.gradient});

  /// The linear gradient configuration.
  final LinearGradient gradient;

  @override
  List<Object?> get props => [gradient];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<LinearGradient>('gradient', gradient));
  }
}

/// A background style represented by an image URL.
final class ImageBackgroundStyle extends BackgroundStyle {
  const ImageBackgroundStyle({required this.imageUrl, this.fit = BoxFit.cover, this.opacity = 1.0});

  /// The URL source of the image.
  final String imageUrl;

  /// How the image should be inscribed into the background space.
  ///
  /// Defaults to [BoxFit.cover].
  final BoxFit fit;

  /// The opacity of the image, ranging from 0.0 to 1.0.
  final double opacity;

  /// Creates a copy of this style with the given fields replaced with the new values.
  ImageBackgroundStyle copyWith({String? imageUrl, BoxFit? fit, double? opacity}) {
    return ImageBackgroundStyle(
      imageUrl: imageUrl ?? this.imageUrl,
      fit: fit ?? this.fit,
      opacity: opacity ?? this.opacity,
    );
  }

  @override
  List<Object?> get props => [imageUrl, fit, opacity];

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('imageUrl', imageUrl));
    properties.add(EnumProperty<BoxFit>('fit', fit));
    properties.add(DoubleProperty('opacity', opacity));
  }
}
