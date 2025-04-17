import 'package:flutter/widgets.dart';

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

  Uri get toUri => Uri.parse(this);

  bool get isAudioPath {
    final ext = toUri.path.split('.').last;
    return ['mp3', 'wav', 'aac', 'flac', 'ogg'].contains(ext);
  }

  bool get isLocalPath => toUri.host.isEmpty && toUri.path.isNotEmpty;

  String get fileName {
    final segments = toUri.pathSegments;
    if (segments.isEmpty) return '';
    return segments.last.split('.').first;
  }

  String get fileExtension {
    final segments = toUri.pathSegments;
    if (segments.isEmpty) return '';
    return segments.last.split('.').last;
  }

  /// Converts a hex string (e.g., "0xf1cf") to an [IconData].
  /// Defaults to the MaterialIcons font family.
  IconData toIconData({String fontFamily = 'MaterialIcons'}) {
    try {
      final codePoint = int.parse(replaceAll('0x', ''), radix: 16);
      return IconData(codePoint, fontFamily: fontFamily);
    } catch (e) {
      throw FormatException('Invalid IconData hex string: $this');
    }
  }
}
