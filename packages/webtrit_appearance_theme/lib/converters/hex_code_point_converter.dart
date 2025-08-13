import 'package:freezed_annotation/freezed_annotation.dart';

class HexCodePointConverter implements JsonConverter<int, String> {
  const HexCodePointConverter();

  @override
  int fromJson(String json) {
    var s = json.trim();
    if (s.startsWith('0x') || s.startsWith('0X')) {
      s = s.substring(2);
    }
    return int.parse(s, radix: 16);
  }

  @override
  String toJson(int object) => '0x${object.toRadixString(16)}';
}
