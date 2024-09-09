import 'dart:core';

import 'package:flutter/foundation.dart';

class AppErrorFilter {
  static late AppErrorFilter _instance;

  final List<String> _ignoreErrors;
  final List<String> _nonFatalErrors;
  final bool ignoreRecording;

  AppErrorFilter._(this._ignoreErrors, this._nonFatalErrors, this.ignoreRecording);

  factory AppErrorFilter() {
    return _instance;
  }

  static Future<void> init() async {
    final filteredErrors = [
      'Timed out',
      'No address associated with hostname',
    ];

    final nonFatalErrors = <String>[];

    _instance = AppErrorFilter._(filteredErrors, nonFatalErrors, kIsWeb);
  }

  bool _containsMessage(Object error, List<String> messages) {
    if (ignoreRecording) {
      return false;
    }

    final errorMessage = error.toString().toLowerCase();

    for (var message in messages) {
      if (errorMessage.contains(message.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  bool shouldRecord(Object error) {
    return !_containsMessage(error, _ignoreErrors);
  }

  bool shouldRecordButNotFatal(Object error) {
    return _containsMessage(error, _nonFatalErrors);
  }
}
