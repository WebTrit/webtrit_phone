import 'package:flutter/material.dart';

import 'call_controller.dart';

class CallControllerScope extends InheritedWidget {
  const CallControllerScope({required this.controller, required super.child, super.key});

  final CallController controller;

  static CallController of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<CallControllerScope>();
    if (result == null) throw Exception('CallControllerScope not found in context');
    return result.controller;
  }

  @override
  bool updateShouldNotify(CallControllerScope oldWidget) => false;
}
