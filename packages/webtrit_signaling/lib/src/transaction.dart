import 'dart:async';

import 'exceptions.dart';

class Transaction {
  static int _createCounter = 0;

  final Duration timeoutDuration;
  final String id;
  final _completer = Completer<Map<String, dynamic>>();

  late Timer _timer;

  Transaction(this.timeoutDuration) : id = 'transaction-$_createCounter' {
    _createCounter++;

    _timer = Timer(
      timeoutDuration,
      _onTimeout,
    );
  }

  Future<Map<String, dynamic>> get future => _completer.future;

  void handleResponse(Map<String, dynamic> responseMessage) {
    _timer.cancel();
    _completer.complete(responseMessage);
  }

  void terminate([int? closeCode, String? closeReason]) {
    _timer.cancel();
    _completer.completeError(WebtritSignalingTerminateException());
  }

  void _onTimeout() {
    if (_completer.isCompleted) {
      return;
    }
    _completer.completeError(WebtritSignalingTimeoutException());
  }
}
