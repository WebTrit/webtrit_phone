import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/dialog_info.dart';

class AppBarParams extends InheritedWidget {
  const AppBarParams({
    required this.systemNotificationsEnabled,
    required this.pullableCallDialogs,
    required super.child,
    super.key,
  });

  final bool systemNotificationsEnabled;
  final List<DialogInfo> pullableCallDialogs;

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
        pullableCallDialogs != oldWidget.pullableCallDialogs;
  }
}
