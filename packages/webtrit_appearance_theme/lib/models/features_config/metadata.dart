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

  /// Retrieves an integer value associated with the given [key].
  bool? getBool(String key) => attributes[key] as bool?;

  /// Retrieves an integer value associated with the given [key].
  double? getDouble(String key) => attributes[key] as double?;

  /// Retrieves a map value associated with the given [key].
  ///
  /// Returns a copy of the map or `null` if the key does not exist or the value is not a map.
  Map<String, dynamic>? getMap(String key) {
    final value = attributes[key];
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return null;
  }
}
