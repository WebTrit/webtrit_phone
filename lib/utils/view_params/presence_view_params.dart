import 'package:flutter/material.dart';

enum PresenceViewSource { contactInfo, sipPresence }

class PresenceViewParams extends InheritedWidget {
  const PresenceViewParams({required this.viewSource, required super.child, super.key});

  final PresenceViewSource viewSource;
  static PresenceViewParams of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<PresenceViewParams>();
    if (result == null) {
      throw Exception('PresenceViewParams not found in context');
    }
    return result;
  }

  @override
  bool updateShouldNotify(PresenceViewParams oldWidget) {
    return viewSource != oldWidget.viewSource;
  }
}
