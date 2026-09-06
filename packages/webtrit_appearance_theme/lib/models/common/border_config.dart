import 'package:freezed_annotation/freezed_annotation.dart';

import 'style_types.dart';

part 'border_config.freezed.dart';

part 'border_config.g.dart';

/// Declarative configuration for input borders.
///
/// Mirrors Flutter's [InputBorder] types such as [UnderlineInputBorder]
/// and [OutlineInputBorder].
@freezed
@JsonSerializable(explicitToJson: true)
class BorderConfig with _$BorderConfig {
  const BorderConfig({this.type = BorderTypeConfig.underline, this.borderRadius, this.borderColor, this.borderWidth});

  /// Border type:
  /// - [`BorderTypeConfig.underline`]
  /// - [`BorderTypeConfig.outline`]
  /// - [`BorderTypeConfig.none`]
  @override
  final BorderTypeConfig type;

  /// Corner radius for outline borders.
  @override
  final double? borderRadius;

  /// Border color (hex string, e.g. `#000000`).
  @override
  final String? borderColor;

  /// Stroke width of the border.
  @override
  final double? borderWidth;

  factory BorderConfig.fromJson(Map<String, Object?> json) => _$BorderConfigFromJson(json);

  Map<String, Object?> toJson() => _$BorderConfigToJson(this);
}
