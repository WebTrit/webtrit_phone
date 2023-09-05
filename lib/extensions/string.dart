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
