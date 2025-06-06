import 'package:flutter/widgets.dart';

mixin WidgetStateMixin<T extends StatefulWidget> on State<T> {
  /// Calls [updateStateHandler] in [setState] function if widget is mounted,
  /// otherwise calls it without setting state
  void safeSetState(final VoidCallback updateStateHandler) =>
      mounted ? setState(updateStateHandler) : updateStateHandler();
}
