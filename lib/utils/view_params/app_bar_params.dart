import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/pullable_call.dart';

class AppBarParams extends InheritedWidget {
  const AppBarParams({
    required this.systemNotificationsEnabled,
    required this.pullableCalls,
    required super.child,
    super.key,
  });

  final bool systemNotificationsEnabled;
  final List<PullableCall> pullableCalls;
  static AppBarParams of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppBarParams>();
    if (result == null) {
      throw Exception('AppBarParams not found in context');
    }
    return result;
  }

  @override
  bool updateShouldNotify(AppBarParams oldWidget) {
    return systemNotificationsEnabled != oldWidget.systemNotificationsEnabled ||
        pullableCalls != oldWidget.pullableCalls;
  }
}
