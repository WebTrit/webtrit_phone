import 'package:freezed_annotation/freezed_annotation.dart';

part 'metadata.freezed.dart';

part 'metadata.g.dart';

@freezed
class Metadata with _$Metadata {
  const Metadata._();

  const factory Metadata({
    @Default({}) Map<String, dynamic> attributes,
  }) = _Metadata;

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

  String? getValue(String key) => attributes[key] as String?;

  Metadata copyWithKey(String key, dynamic value) {
    final updatedAttributes = Map<String, dynamic>.from(attributes);
    updatedAttributes[key] = value;
    return copyWith(attributes: updatedAttributes);
  }
}
