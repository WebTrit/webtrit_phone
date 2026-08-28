import 'package:flutter/material.dart';

class PresenceViewParams extends InheritedWidget {
  const PresenceViewParams({
    required this.directPresenceEnabled,
    required this.presenceOverSipEnabled,
    required this.dialogsOverSipEnabled,
    required super.child,
    super.key,
  });

  final bool directPresenceEnabled;
  final bool presenceOverSipEnabled;
  final bool dialogsOverSipEnabled;

  bool get anyPresenceEnabled => directPresenceEnabled || presenceOverSipEnabled;

  static PresenceViewParams of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<PresenceViewParams>();
    if (result == null) {
      throw Exception('PresenceViewParams not found in context');
    }
    return result;
  }

  @override
  bool updateShouldNotify(PresenceViewParams oldWidget) {
    return directPresenceEnabled != oldWidget.directPresenceEnabled ||
        presenceOverSipEnabled != oldWidget.presenceOverSipEnabled ||
        dialogsOverSipEnabled != oldWidget.dialogsOverSipEnabled;
  }
}
