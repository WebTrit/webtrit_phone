import 'package:freezed_annotation/freezed_annotation.dart';

part 'caller_id_settings.freezed.dart';
part 'caller_id_settings.g.dart';

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PrefixMatcher with _$PrefixMatcher {
  const PrefixMatcher({required this.prefix, required this.number});

  @override
  final String prefix;

  @override
  final String number;

  factory PrefixMatcher.fromJson(Map<String, Object?> json) => _$PrefixMatcherFromJson(json);

  Map<String, Object?> toJson() => _$PrefixMatcherToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CallerIdSettings with _$CallerIdSettings {
  const CallerIdSettings({
    this.defaultNumber,
    required this.prefixMatchers,
    required this.version,
    required this.modifiedAt,
  });

  @override
  final String? defaultNumber;

  @override
  final List<PrefixMatcher> prefixMatchers;

  @override
  final int version;

  @override
  final DateTime modifiedAt;

  factory CallerIdSettings.fromJson(Map<String, Object?> json) => _$CallerIdSettingsFromJson(json);

  Map<String, Object?> toJson() => _$CallerIdSettingsToJson(this);
}
