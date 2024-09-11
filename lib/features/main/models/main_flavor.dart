import 'package:flutter/widgets.dart';

enum MainFlavorType {
  keypad('keypad'),
  contacts('contacts'),
  recents('recents'),
  favorites('favorites'),
  embedded('embedded');

  final String value;

  const MainFlavorType(this.value);
}

@immutable
class MainFlavor {
  final String title;
  final IconData icon;
  final bool initial;

  final MainFlavorType type;
  final String path;

  final FlavorData? data;

  const MainFlavor({
    required this.icon,
    required this.title,
    required this.type,
    required this.path,
    required this.initial,
    required this.data,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MainFlavor && runtimeType == other.runtimeType && path == other.path;

  @override
  int get hashCode => path.hashCode;

  @override
  String toString() {
    return 'path: $path';
  }
}

@immutable
class FlavorData {
  final String url;
  final String path;

  const FlavorData({
    required this.url,
    required this.path,
  });

  @override
  String toString() {
    return 'path';
  }
}
