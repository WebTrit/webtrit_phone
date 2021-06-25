part of '../janus_client.dart';

class Gateway {
  static const subprotocol = 'janus-protocol';
  static int _createCounter = 0;

  final _transactions = <String, Transaction>{};
  final _sessions = <int, Session>{};
  final WebSocket _webSocket;
  final _logger;

  StreamSubscription<dynamic>? _subscription;
  void Function(dynamic error, [StackTrace stackTrace]) _onError;
  Function() _onDone;

  static Future<Gateway> connect(String url, Function(dynamic, [StackTrace]) onError, Function() onDone) async {
    return Gateway(await WebSocket.connect(url, protocols: [subprotocol]), onError, onDone);
  }

  Gateway(this._webSocket, this._onError, this._onDone) : _logger = Logger('Gateway-$_createCounter') {
    _createCounter++;
  }

  void listen() {
    _subscription = _webSocket.listen(
      _onDataCallback,
      onError: _onErrorCallback,
      onDone: _onDoneCallback,
    );
  }

  Future<void> close() {
    _subscription?.cancel();
    return _webSocket.close();
  }

  Future<Map<String, dynamic>> info() async {
    final requestMessage = <String, dynamic>{
      'janus': 'info',
    };

    final responseMessage = await _executeTransaction(requestMessage, true);

    if (responseMessage['janus'] == 'server_info') {
      return responseMessage;
    } else {
      throw JanusGatewayException();
    }
  }

  Future<void> ping() async {
    final requestMessage = <String, dynamic>{
      'janus': 'ping',
    };

    final responseMessage = await _executeTransaction(requestMessage, true);

    if (responseMessage['janus'] == 'pong') {
      return;
    } else {
      throw JanusGatewayException();
    }
  }

  _create(Session session) {
    _sessions[session.id!] = session;
  }

  _destroy(Session session) {
    _sessions.remove(session);
  }

  Future<Map<String, dynamic>> _executeTransaction(Map<String, dynamic> requestMessage, bool synchronous) async {
    final transaction = Transaction(synchronous);

    _transactions[transaction.id] = transaction;
    requestMessage['transaction'] = transaction.id;

    _addMessage(requestMessage);

    final responseMessage = await transaction.future;
    return responseMessage;
  }

  _addMessage(Map<String, dynamic> message) {
    final data = JsonEncoder.withIndent('  ').convert(message);
    _addData(data);
  }

  _addData(dynamic data) {
    _webSocket.add(data);

    _logger.finer(() => '>> sent\n$data');
  }

  _onDataCallback(dynamic data) {
    _logger.finer(() => '<< received\n$data');

    final Map<String, dynamic> message = JsonDecoder().convert(data);
    _onMessageCallback(message);
  }

  _onMessageCallback(Map<String, dynamic> message) {
    if (message.containsKey('transaction')) {
      final responseMessage = message;

      final String? transactionId = responseMessage['transaction'];
      final transaction = _transactions[transactionId!];

      if (transaction != null) {
        transaction.handleResponse(responseMessage);
        if (transaction.isCompleted) {
          _transactions.remove(transaction.id);
        }
      } else {
        _onError(JanusGatewayTransactionUnavailableException(transactionId));
      }
    } else if (message.containsKey('session_id')) {
      final eventMessage = message;

      final int? sessionId = eventMessage['session_id'];
      final session = _sessions[sessionId];

      if (session != null) {
        session._handleEvent(eventMessage);
      } else {
        _onError(JanusGatewaySessionUnavailableException(sessionId!));
      }
    } else {
      throw JanusGatewayException();
    }
  }

  _onErrorCallback(error, StackTrace stackTrace) {
    _onError(error, stackTrace);
  }

  _onDoneCallback() {
    _onDone();
  }
}
