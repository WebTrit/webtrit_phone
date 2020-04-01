part of '../janus_client.dart';

class Transaction {
  static int _createCounter = 0;

  final bool synchronous;
  final Duration timeoutDuration;
  final id;
  final Completer<Map<String, dynamic>> _completer = new Completer();

  Timer _timer;
  bool _asynchronousAckReceived = false;

  Transaction(
    this.synchronous, {
    this.timeoutDuration = const Duration(milliseconds: 3000),
  }) : id = 'transaction-$_createCounter' {
    _createCounter++;

    _timer = Timer(
      timeoutDuration,
      _timeoutCallback,
    );
  }

  Future<Map<String, dynamic>> get future => _completer.future;

  get isCompleted => _completer.isCompleted && (synchronous || _asynchronousAckReceived);

  void handleResponse(Map<String, dynamic> responseMessage) {
    if (!synchronous && responseMessage['janus'] == 'ack') {
      _asynchronousAckReceived = true;
      return;
    }

    _timer.cancel();

    if (responseMessage['janus'] == 'error') {
      final Map<String, dynamic> responseError = responseMessage['error'];
      _completer.completeError(JanusErrorException(responseError['code'], responseError['reason']));
    } else {
      _completer.complete(responseMessage);
    }
  }

  void _timeoutCallback() {
    if (_completer.isCompleted) {
      return;
    }
    _completer.completeError(JanusTransactionTimeoutException());
  }
}
