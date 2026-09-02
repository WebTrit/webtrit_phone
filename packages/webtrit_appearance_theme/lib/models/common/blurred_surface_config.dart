import 'package:freezed_annotation/freezed_annotation.dart';

part 'blurred_surface_config.freezed.dart';

part 'blurred_surface_config.g.dart';

/// Declarative configuration for a blurred surface overlay.
///
/// Maps to [BlurredSurface] widget parameters: color, sigmaX, sigmaY.
@freezed
@JsonSerializable(explicitToJson: true)
class BlurredSurfaceConfig with _$BlurredSurfaceConfig {
  const BlurredSurfaceConfig({this.color, this.sigmaX, this.sigmaY});

  /// Overlay color (hex string, e.g. `#000000`).
  @override
  final String? color;

  /// Horizontal gaussian blur sigma.
  @override
  final double? sigmaX;

  /// Vertical gaussian blur sigma.
  @override
  final double? sigmaY;

  factory BlurredSurfaceConfig.fromJson(Map<String, Object?> json) => _$BlurredSurfaceConfigFromJson(json);

  Map<String, Object?> toJson() => _$BlurredSurfaceConfigToJson(this);
}
