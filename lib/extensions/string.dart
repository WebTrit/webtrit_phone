import 'package:flutter/painting.dart';

import 'package:characters/characters.dart';

extension StringExtension on String {
  String get capitalize {
    if (isEmpty) {
      return this;
    } else {
      return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    }
  }

  String get initialism {
    final trimmed = trim();
    if (trimmed.isEmpty) {
      return '';
    } else {
      return trimmed.split(' ').where((v) => v.isNotEmpty).map((v) => Characters(v).first).take(3).join();
    }
  }
}

extension StringToColorExtension on String {
  Color? toColor() {
    if (!startsWith('#')) {
      return null;
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
      return null;
    }

    final colorInt = int.tryParse(colorString, radix: 16);

    if (colorInt == null) {
      return null;
    } else {
      return Color(colorInt);
    }
  }
}
