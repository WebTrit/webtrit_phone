import 'package:freezed_annotation/freezed_annotation.dart';

part 'metadata.freezed.dart';

part 'metadata.g.dart';

/// Represents metadata for a page or component, allowing storage of key-value pairs
/// that are not directly related to the UI but provide additional context or configuration.
@freezed
class Metadata with _$Metadata {
  const Metadata._();

  /// Creates a metadata object with optional attributes.
  ///
  /// [attributes] is a map storing arbitrary key-value pairs. Defaults to an empty map.
  const factory Metadata({
    @Default({}) Map<String, dynamic> attributes,
  }) = _Metadata;

  /// Creates an instance of `Metadata` from a JSON map.
  ///
  /// This is used for serialization and deserialization of metadata objects.
  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

  /// Retrieves a string value associated with the given [key].
  ///
  /// Returns `null` if the key does not exist or the value is not a string.
  String? getString(String key) => attributes[key] as String?;

  /// Creates a new `Metadata` instance with an updated key-value pair in `attributes`.
  ///
  /// This method does not mutate the existing object but instead returns a modified copy.
  ///
  /// [key] - The attribute key to update or add.
  /// [value] - The new value to assign to the key.
  Metadata copyWithKey(String key, dynamic value) {
    final updatedAttributes = Map<String, dynamic>.from(attributes);
    updatedAttributes[key] = value;
    return copyWith(attributes: updatedAttributes);
  }
}
