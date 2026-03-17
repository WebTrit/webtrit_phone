import 'package:flutter/material.dart';

class PresenceViewParams extends InheritedWidget {
  const PresenceViewParams({
    required this.hybridPresenceSupport,
    required this.blfViaSipSupport,
    required this.presenceViaSipSupport,
    required super.child,
    super.key,
  });

  final bool hybridPresenceSupport;
  final bool blfViaSipSupport;
  final bool presenceViaSipSupport;

  static PresenceViewParams of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<PresenceViewParams>();
    if (result == null) {
      throw Exception('PresenceViewParams not found in context');
    }
    return result;
  }

  @override
  bool updateShouldNotify(PresenceViewParams oldWidget) {
    return hybridPresenceSupport != oldWidget.hybridPresenceSupport ||
        blfViaSipSupport != oldWidget.blfViaSipSupport ||
        presenceViaSipSupport != oldWidget.presenceViaSipSupport;
  }
}
