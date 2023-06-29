import 'package:flutter/painting.dart';

class UtilityColor {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color? tryParseColorFromHex(
    String? hexString, {
    Color? defaultColor,
  }) {
    if (hexString == null) {
      return defaultColor;
    }

    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return defaultColor;
    }
  }
}
