import 'dart:async';

import 'exceptions.dart';

class Transaction {
  static int _createCounter = 0;

  static String generateId() => 'transaction-${_createCounter++}';

  final int signalingClientId;
  late final String id;
  late final bool isIdGenerate;

  final _completer = Completer<Map<String, dynamic>>();
  late final Timer _timer;

  Transaction({
    required this.signalingClientId,
    String? id,
    required Duration timeoutDuration,
  }) {
    if (id != null) {
      this.id = id;
      isIdGenerate = false;
    } else {
      this.id = generateId();
      isIdGenerate = true;
    }

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
    _completer.completeError(
        WebtritSignalingTransactionTerminateByDisconnectException(
            signalingClientId, id, closeCode, closeReason));
  }

  void _onTimeout() {
    if (_completer.isCompleted) {
      return;
    }
    _completer.completeError(
        WebtritSignalingTransactionTimeoutException(signalingClientId, id),
        StackTrace.current);
  }
}
