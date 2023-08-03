import 'package:flutter/foundation.dart';

class ExceptionModel {
  ExceptionModel({
    this.error,
    this.stackTrace,
  });

  final Object? error;
  final StackTrace? stackTrace;
}

class ExceptionHandler extends ChangeNotifier {
  final List<VoidCallback> _listeners = [];

  ExceptionModel? exceptionModel;

  void addFilteredListener(
    VoidCallback listener, {
    bool Function(Object?)? filter,
  }) {
    filteredListener() {
      if (filter == null || filter(exceptionModel?.error)) {
        listener();
      }
    }

    _listeners.add(filteredListener);
  }

  @override
  void notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  void emitError(ExceptionModel error) {
    exceptionModel = error;
    notifyListeners();
  }
}
