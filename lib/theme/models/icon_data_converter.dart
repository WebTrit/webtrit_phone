import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

class IconDataConverter implements JsonConverter<IconData, String> {
  const IconDataConverter();

  @override
  IconData fromJson(String json) {
    return IconData(int.parse(json.replaceFirst('0x', ''), radix: 16), fontFamily: 'MaterialIcons');
  }

  @override
  String toJson(IconData icon) {
    return '0x${icon.codePoint.toRadixString(16)}';
  }
}
