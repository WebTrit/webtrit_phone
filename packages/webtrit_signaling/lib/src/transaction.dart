import 'dart:async';

import 'exceptions.dart';

class Transaction {
  static int _createCounter = 0;

  final int signalingClient;
  final String id;
  final _completer = Completer<Map<String, dynamic>>();

  late Timer _timer;

  Transaction(this.signalingClient, Duration timeoutDuration) : id = 'transaction-$_createCounter' {
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
    _completer
        .completeError(WebtritSignalingTerminateByDisconnectException(signalingClient, id, closeCode, closeReason));
  }

  void _onTimeout() {
    if (_completer.isCompleted) {
      return;
    }
    _completer.completeError(WebtritSignalingTransactionTimeoutException(signalingClient, id), StackTrace.current);
  }
}
