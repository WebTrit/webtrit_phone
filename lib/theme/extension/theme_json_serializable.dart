import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

const themeJsonSerializable = JsonSerializable(converters: [CSSColorConverter()]);

class CSSColorConverter implements JsonConverter<Color, String> {
  const CSSColorConverter();

  @override
  Color fromJson(String json) => json.toColor();

  @override
  String toJson(Color object) => object.toCSSColorString();
}

extension CSSColorStringToColorExtension on String {
  Color toColor() {
    if (!startsWith('#')) {
      throw FormatException('Incorrect CSS hexadecimal color prefix', this, 0);
    }
    var colorString = substring(1);
    if (colorString.length == 3) {
      final r = '${colorString[0]}${colorString[0]}';
      final g = '${colorString[1]}${colorString[1]}';
      final b = '${colorString[2]}${colorString[2]}';
      colorString = 'FF$r$g$b';
    } else if (colorString.length == 4) {
      final a = '${colorString[0]}${colorString[0]}';
      final r = '${colorString[1]}${colorString[1]}';
      final g = '${colorString[2]}${colorString[2]}';
      final b = '${colorString[3]}${colorString[3]}';
      colorString = '$a$r$g$b';
    } else if (colorString.length == 6) {
      colorString = 'FF$colorString';
    } else if (colorString.length != 8) {
      throw FormatException('Incorrect CSS hexadecimal color length', this, 0);
    }
    return Color(int.parse(colorString, radix: 16));
  }
}

extension ColorToCSSColorStringExtension on Color {
  String toCSSColorString() {
    return '#${toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0')}';
  }
}
