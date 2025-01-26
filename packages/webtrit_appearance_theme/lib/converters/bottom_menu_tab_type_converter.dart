import 'package:json_annotation/json_annotation.dart';

import '../models/models.dart';

class BottomMenuTabTypeConverter implements JsonConverter<BottomMenuTabType, String> {
  const BottomMenuTabTypeConverter();

  @override
  BottomMenuTabType fromJson(String json) {
    return BottomMenuTabType.values.firstWhere(
      (type) => type.toString().split('.').last == json,
      orElse: () => throw ArgumentError('Invalid type: $json'),
    );
  }

  @override
  String toJson(BottomMenuTabType type) => type.toString().split('.').last;
}
