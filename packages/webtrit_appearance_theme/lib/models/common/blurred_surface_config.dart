import 'package:freezed_annotation/freezed_annotation.dart';

part 'blurred_surface_config.freezed.dart';

part 'blurred_surface_config.g.dart';

/// Declarative configuration for a blurred surface overlay.
///
/// Maps to [BlurredSurface] widget parameters: color, sigmaX, sigmaY.
@freezed
abstract class BlurredSurfaceConfig with _$BlurredSurfaceConfig {
  const factory BlurredSurfaceConfig({
    /// Overlay color (hex string, e.g. `#000000`).
    String? color,

    /// Horizontal gaussian blur sigma.
    @Default(0) double sigmaX,

    /// Vertical gaussian blur sigma.
    @Default(0) double sigmaY,
  }) = _BlurredSurfaceConfig;

  factory BlurredSurfaceConfig.fromJson(Map<String, dynamic> json) => _$BlurredSurfaceConfigFromJson(json);
}
