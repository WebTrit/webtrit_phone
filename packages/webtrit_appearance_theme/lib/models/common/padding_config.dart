import 'package:freezed_annotation/freezed_annotation.dart';

part 'padding_config.freezed.dart';

part 'padding_config.g.dart';

@freezed
@JsonSerializable()
class PaddingConfig with _$PaddingConfig {
  /// Creates a [PaddingConfig].
  const PaddingConfig({this.left = 0.0, this.top = 0.0, this.right = 0.0, this.bottom = 0.0});

  /// Left padding value.
  @override
  final double left;

  /// Top padding value.
  @override
  final double top;

  /// Right padding value.
  @override
  final double right;

  /// Bottom padding value.
  @override
  final double bottom;

  /// Deserializes a [PaddingConfig] from JSON.
  factory PaddingConfig.fromJson(Map<String, Object?> json) => _$PaddingConfigFromJson(json);

  /// Serializes this [PaddingConfig] to JSON.
  Map<String, Object?> toJson() => _$PaddingConfigToJson(this);

  /// Convenience: uniform padding on all sides.
  factory PaddingConfig.all(double value) => PaddingConfig(left: value, top: value, right: value, bottom: value);

  /// Default padding of 2 on all sides.
  static const PaddingConfig default2 = PaddingConfig(left: 2, top: 2, right: 2, bottom: 2);
}
