import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '_web_socket_channel/_web_socket_channel.dart'
    if (dart.library.html) '_web_socket_channel/_web_socket_channel_html.dart'
    if (dart.library.io) '_web_socket_channel/_web_socket_channel_io.dart' as platform;
import '_web_socket_connect/_web_socket_connect.dart'
    if (dart.library.html) '_web_socket_connect/_web_socket_connect_html.dart'
    if (dart.library.io) '_web_socket_connect/_web_socket_connect_io.dart' as platform;
import 'events/events.dart';
import 'exceptions.dart';
import 'handshakes/handshakes.dart';
import 'requests/requests.dart';
import 'responses/responses.dart';
import 'transaction.dart';

typedef StateHandshakeHandler = void Function(StateHandshake stateHandshake);
typedef EventHandler = void Function(Event event);
typedef ErrorHandler = void Function(Object error, StackTrace? stackTrace);
typedef DisconnectHandler = void Function(int? code, String? reason);

class WebtritSignalingClient {
  static final _callIdRandom = Random();
  static const _callIdChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  static String generateTransactionId() {
    return Transaction.generateId();
  }

  static String generateCallId([int length = 24]) {
    return List.generate(length, (index) => _callIdChars[_callIdRandom.nextInt(_callIdChars.length)]).join();
  }

  static const subprotocol = 'webtrit-protocol';

  static const defaultExecuteTransactionTimeoutDuration = Duration(milliseconds: 5000);

  static int _createCounter = 0;

  @visibleForTesting
  WebtritSignalingClient.inner(this._wsc)
      : _id = _createCounter,
        _logger = Logger('$WebtritSignalingClient-$_createCounter') {
    _createCounter++;

    _logger.fine('connected');
  }

  final int _id;
  final Logger _logger;

  final WebSocketChannel _wsc;
  StreamSubscription? _wscStreamSubscription;

  late final StateHandshakeHandler _onStateHandshake;
  late final EventHandler _onEvent;
  late final ErrorHandler _onError;
  late final DisconnectHandler _onDisconnect;

  late final Duration _keepaliveInterval;
  Timer? _keepaliveTimer;

  final _transactions = <String, Transaction>{};

  static const defaultApiVersionPathSegments = ['signaling', 'v1'];

  static Future<WebtritSignalingClient> connect(
    String url,
    String token,
    bool force, {
    Duration? connectionTimeout,
    List<String>? customSegments,
  }) async {
    final signalingUrl = Uri.parse(url).replace(
      pathSegments: customSegments ?? defaultApiVersionPathSegments,
      queryParameters: {
        'token': token,
        'force': force.toString(),
      },
    ).toString();

    final ws = await platform.connect(
      signalingUrl,
      protocols: [subprotocol],
      connectionTimeout: connectionTimeout,
    );
    final wsc = platform.createWebSocketChannel(ws);
    return WebtritSignalingClient.inner(wsc);
  }

  void listen({
    required StateHandshakeHandler onStateHandshake,
    required EventHandler onEvent,
    required ErrorHandler onError,
    required DisconnectHandler onDisconnect,
  }) {
    if (_wscStreamSubscription != null) {
      throw StateError('$WebtritSignalingClient with id: $_id has already been listened to');
    }
    _logger.fine('listen');

    _onStateHandshake = onStateHandshake;
    _onEvent = onEvent;
    _onError = onError;
    _onDisconnect = onDisconnect;

    _wscStreamSubscription = _wsc.stream.listen(
      _wscStreamOnData,
      onError: _wscStreamOnError,
      onDone: _wscStreamOnDone,
    );
  }

  Future<void> disconnect([int? code, String? reason]) {
    if (_wscStreamSubscription == null) {
      _logger.fine('already disconnected with code: ${_wsc.closeCode} reason: ${_wsc.closeReason}');
      return Future.value();
    }
    _logger.fine('disconnect code: $code reason: $reason');

    _stopKeepaliveTimer();

    _cleanupTransactions(code, reason);

    _wscStreamSubscription!.onDone(null); // to prevent onDisconnect handler call
    _wscStreamSubscription = null;

    return _wsc.sink.close(code, reason);
  }

  //

  void _wscStreamOnData(dynamic data) {
    _logger.finer('_wsOnData: $data');

    final Map<String, dynamic> messageJson = jsonDecode(data);
    _onMessage(messageJson);
  }

  void _wscStreamOnError(dynamic error, StackTrace stackTrace) {
    _logger.warning('_wsOnError', error, stackTrace);

    _onError(error, stackTrace);
  }

  void _wscStreamOnDone() {
    final closeCode = _wsc.closeCode;
    final closeReason = _wsc.closeReason;

    _logger.fine('_wsOnDone code: $closeCode reason: $closeReason');

    _stopKeepaliveTimer();

    _cleanupTransactions(closeCode, closeReason);

    _wscStreamSubscription = null;

    _onDisconnect(closeCode, closeReason);
  }

  //

  Future<void> execute(Request request, [Duration timeoutDuration = defaultExecuteTransactionTimeoutDuration]) async {
    if (_wscStreamSubscription == null) {
      throw WebtritSignalingDisconnectedException(_id);
    }

    _restartKeepaliveTimer();

    final requestJson = request.toJson();
    final responseJson = await _executeTransaction(requestJson, timeoutDuration);
    final response = Response.fromJson(responseJson);
    if (response is AckResponse) {
      return;
    } else if (response is ErrorResponse) {
      throw WebtritSignalingErrorException(_id, response.code, response.reason);
    } else {
      throw WebtritSignalingUnknownResponseException(_id, responseJson);
    }
  }

  //

  void _onMessage(Map<String, dynamic> messageJson) {
    if (messageJson.containsKey(Response.typeKey) || messageJson[Handshake.typeKey] == KeepaliveHandshake.typeValue) {
      final responseJson = messageJson;

      final transactionId = responseJson['transaction'];
      final transaction = _transactions.remove(transactionId);

      if (transaction != null) {
        transaction.handleResponse(responseJson);
      } else {
        _onError(WebtritSignalingTransactionUnavailableException(_id, transactionId), StackTrace.current);
      }
    } else if (messageJson.containsKey(Event.typeKey)) {
      final eventJson = messageJson;

      try {
        final event = Event.fromJson(eventJson);
        _onEvent(event);
      } catch (error, stackTrace) {
        _onError(error, stackTrace);
      }
    } else if (messageJson[Handshake.typeKey] == StateHandshake.typeValue) {
      final stateHandshakeJson = messageJson;

      try {
        final stateHandshake = StateHandshake.fromJson(stateHandshakeJson);
        _onStateHandshake(stateHandshake);

        _keepaliveInterval = stateHandshake.keepaliveInterval;
        _startKeepaliveTimer();
      } catch (error, stackTrace) {
        _onError(error, stackTrace);
      }
    } else {
      _onError(WebtritSignalingUnknownMessageException(_id, messageJson), StackTrace.current);
    }
  }

  Future<Map<String, dynamic>> _executeTransaction(Map<String, dynamic> requestJson, Duration timeoutDuration) async {
    final transaction = Transaction(
      signalingClientId: _id,
      id: requestJson['transaction'],
      timeoutDuration: timeoutDuration,
    );

    _transactions[transaction.id] = transaction;
    if (transaction.isIdGenerate) {
      requestJson['transaction'] = transaction.id;
    }

    _addMessage(requestJson);

    try {
      final responseJson = await transaction.future;
      if (transaction.isIdGenerate) {
        responseJson.remove('transaction');
      }

      return responseJson;
    } catch (e) {
      _transactions.remove(transaction.id);
      rethrow;
    }
  }

  void _addMessage(Map<String, dynamic> messageJson) {
    final data = jsonEncode(messageJson);
    _addData(data);
  }

  void _addData(dynamic data) {
    _logger.finer(() => '_addData add: $data');

    _wsc.sink.add(data);
  }

  void _cleanupTransactions(int? code, String? reason) {
    for (final transaction in _transactions.values) {
      transaction.terminateByDisconnect(code, reason);
    }
    _transactions.clear();
  }

  //

  void _startKeepaliveTimer() {
    _keepaliveTimer = Timer(_keepaliveInterval, _onKeepalive);
  }

  void _stopKeepaliveTimer() {
    _keepaliveTimer?.cancel();
  }

  void _restartKeepaliveTimer() {
    _stopKeepaliveTimer();
    _startKeepaliveTimer();
  }

  void _onKeepalive() async {
    final stopwatch = Stopwatch();
    try {
      final requestJson = KeepaliveHandshake().toJson();
      stopwatch.start();
      final responseJson = await _executeTransaction(requestJson, defaultExecuteTransactionTimeoutDuration);
      stopwatch.stop();
      KeepaliveHandshake.fromJson(responseJson);
      _logger.finest('handshake keepalive latency: ${stopwatch.elapsed}');
    } on WebtritSignalingTransactionTimeoutException catch (error) {
      _onError(WebtritSignalingKeepaliveTimeoutException(error.id, error.transactionId), StackTrace.current);
    } catch (error, stackTrace) {
      _onError(error, stackTrace);
    }

    _startKeepaliveTimer();
  }
}
