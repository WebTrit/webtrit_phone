import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_field_mask_config.freezed.dart';

part 'text_field_mask_config.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class MaskConfig with _$MaskConfig {
  const MaskConfig({this.pattern, this.filter});

  /// The mask pattern, e.g. "+380 (##) ###-##-##"
  @override
  final String? pattern;

  /// Regex filter map, e.g. {"#": "[0-9]"}
  /// Note: Values are regex strings, need to be converted to RegExp in UI code.
  @override
  final Map<String, String>? filter;

  factory MaskConfig.fromJson(Map<String, Object?> json) => _$MaskConfigFromJson(json);

  Map<String, Object?> toJson() => _$MaskConfigToJson(this);
}
