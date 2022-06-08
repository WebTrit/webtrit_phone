import 'dart:async';

import 'exceptions.dart';

class Transaction {
  static int _createCounter = 0;

  final String id;
  final _completer = Completer<Map<String, dynamic>>();

  late Timer _timer;

  Transaction(Duration timeoutDuration) : id = 'transaction-$_createCounter' {
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

  void terminateByDisconnect([int? closeCode, String? closeReason]) {
    _timer.cancel();
    _completer.completeError(WebtritSignalingTerminateByDisconnectException(closeCode, closeReason));
  }

  void terminateByError(dynamic error, StackTrace stackTrace) {
    _timer.cancel();
    _completer.completeError(WebtritSignalingTerminateByErrorException(error, stackTrace));
  }

  void _onTimeout() {
    if (_completer.isCompleted) {
      return;
    }
    _completer.completeError(WebtritSignalingTimeoutException(), StackTrace.current);
  }
}
