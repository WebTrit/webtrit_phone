import 'package:freezed_annotation/freezed_annotation.dart';

part 'padding_config.freezed.dart';

part 'padding_config.g.dart';

@freezed
class PaddingConfig with _$PaddingConfig {
  const factory PaddingConfig({
    @Default(0.0) double left,
    @Default(0.0) double top,
    @Default(0.0) double right,
    @Default(0.0) double bottom,
  }) = _PaddingConfig;

  factory PaddingConfig.fromJson(Map<String, dynamic> json) => _$PaddingConfigFromJson(json);

  /// Convenience: uniform padding on all sides.
  factory PaddingConfig.all(double value) => PaddingConfig(left: value, top: value, right: value, bottom: value);

  static const PaddingConfig default2 = PaddingConfig(left: 2, top: 2, right: 2, bottom: 2);
}
