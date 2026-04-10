import 'package:flutter/material.dart';

import 'call_controller.dart';

class CallControllerScope extends InheritedWidget {
  const CallControllerScope({required this.controller, required super.child, super.key});

  final CallController controller;

  static CallController of(BuildContext context) {
    final element = context.getElementForInheritedWidgetOfExactType<CallControllerScope>();
    assert(element != null, 'CallControllerScope not found in context');
    return (element!.widget as CallControllerScope).controller;
  }

  @override
  bool updateShouldNotify(CallControllerScope oldWidget) => false;
}
