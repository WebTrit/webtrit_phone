import 'package:json_annotation/json_annotation.dart';

class IntToStringConverter implements JsonConverter<String, Object?> {
  const IntToStringConverter();

  @override
  String fromJson(Object? json) {
    if (json == null) {
      throw ArgumentError('Value is required but was null');
    }
    if (json is int) return json.toString();
    if (json is String) return json;
    throw ArgumentError('Unsupported type for id: $json');
  }

  @override
  Object toJson(String object) => object;
}

class IntToStringOptionalConverter implements JsonConverter<String?, Object?> {
  const IntToStringOptionalConverter();

  @override
  String? fromJson(Object? json) {
    if (json == null) return null;
    if (json is int) return json.toString();
    if (json is String) return json;
    throw ArgumentError('Unsupported type for id: $json');
  }

  @override
  Object? toJson(String? object) => object;
}
