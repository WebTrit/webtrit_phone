import 'package:freezed_annotation/freezed_annotation.dart';

part 'geometry_config.freezed.dart';

part 'geometry_config.g.dart';

/// Represents a 2D size.
@freezed
@JsonSerializable()
class SizeConfig with _$SizeConfig {
  const SizeConfig({required this.width, required this.height});

  @override
  final double width;

  @override
  final double height;

  factory SizeConfig.fromJson(Map<String, Object?> json) => _$SizeConfigFromJson(json);

  Map<String, Object?> toJson() => _$SizeConfigToJson(this);
}

/// Represents immutable set of offsets in each of the four cardinal directions.
@freezed
@JsonSerializable()
class EdgeInsetsConfig with _$EdgeInsetsConfig {
  const EdgeInsetsConfig({this.left = 0.0, this.top = 0.0, this.right = 0.0, this.bottom = 0.0});

  @override
  final double left;
  @override
  final double top;
  @override
  final double right;
  @override
  final double bottom;

  factory EdgeInsetsConfig.fromJson(Map<String, Object?> json) => _$EdgeInsetsConfigFromJson(json);

  Map<String, Object?> toJson() => _$EdgeInsetsConfigToJson(this);

  /// Helper factory for symmetric padding.
  factory EdgeInsetsConfig.symmetric({double vertical = 0.0, double horizontal = 0.0}) {
    return EdgeInsetsConfig(left: horizontal, top: vertical, right: horizontal, bottom: vertical);
  }

  /// Helper factory for all-sides padding.
  factory EdgeInsetsConfig.all(double value) {
    return EdgeInsetsConfig(left: value, top: value, right: value, bottom: value);
  }
}

/// Represents a border side configuration.
@freezed
@JsonSerializable()
class BorderSideConfig with _$BorderSideConfig {
  const BorderSideConfig({this.color, this.width = 1.0, this.style = 'solid'});

  /// Color in hex format.
  @override
  final String? color;

  @override
  final double width;

  /// Border style (e.g., 'solid', 'none').
  @override
  final String style;

  factory BorderSideConfig.fromJson(Map<String, Object?> json) => _$BorderSideConfigFromJson(json);

  Map<String, Object?> toJson() => _$BorderSideConfigToJson(this);
}

/// Represents the shape of the button (e.g., RoundedRectangleBorder, CircleBorder).
@freezed
@JsonSerializable()
class ShapeBorderConfig with _$ShapeBorderConfig {
  const ShapeBorderConfig({this.type = 'rounded', this.borderRadius});

  /// The type of shape. Common values: 'rounded', 'circle', 'stadium', 'beveled'.
  @override
  final String type;

  /// The border radius value (for rounded/beveled shapes).
  @override
  final double? borderRadius;

  factory ShapeBorderConfig.fromJson(Map<String, Object?> json) => _$ShapeBorderConfigFromJson(json);

  Map<String, Object?> toJson() => _$ShapeBorderConfigToJson(this);
}

/// Represents visual density (compactness).
@freezed
@JsonSerializable()
class VisualDensityConfig with _$VisualDensityConfig {
  const VisualDensityConfig({this.horizontal = 0.0, this.vertical = 0.0});

  @override
  final double horizontal;

  @override
  final double vertical;

  factory VisualDensityConfig.fromJson(Map<String, Object?> json) => _$VisualDensityConfigFromJson(json);

  Map<String, Object?> toJson() => _$VisualDensityConfigToJson(this);
}
