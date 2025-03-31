import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:_web_socket_channel/_web_socket_channel.dart';

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

  @visibleForTesting
  static Uri buildTenantUrl(Uri baseUrl, String tenantId) {
    if (tenantId.isEmpty) {
      return baseUrl;
    } else {
      final baseUrlPathSegments = List.of(baseUrl.pathSegments.where((segment) => segment.isNotEmpty));
      if (baseUrlPathSegments.length >= 2 && baseUrlPathSegments[baseUrlPathSegments.length - 2] == 'tenant') {
        baseUrlPathSegments.removeRange(baseUrlPathSegments.length - 2, baseUrlPathSegments.length);
      }
      return baseUrl.replace(
        pathSegments: [
          ...baseUrlPathSegments,
          ...['tenant', tenantId],
        ],
      );
    }
  }

  static String generateTransactionId() {
    return Transaction.generateId();
  }

  static String generateCallId([int length = 24]) {
    return List.generate(length, (index) => _callIdChars[_callIdRandom.nextInt(_callIdChars.length)]).join();
  }

  static const subprotocol = 'webtrit-protocol';

  static const defaultExecuteTransactionTimeoutDuration = Duration(milliseconds: 10000);

  static int _createCounter = 0;

  @visibleForTesting
  WebtritSignalingClient.inner(this._wsc)
      : _id = _createCounter,
        _logger = Logger('WebtritSignalingClient-$_createCounter') {
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

  static Future<WebtritSignalingClient> connect(
    Uri baseUrl,
    String tenantId,
    String token,
    bool force, {
    Duration? connectionTimeout,
    TrustedCertificates certs = TrustedCertificates.empty,
  }) async {
    final tenantUrl = buildTenantUrl(baseUrl, tenantId);
    final signalingUrl = tenantUrl.replace(
      pathSegments: [
        ...tenantUrl.pathSegments,
        'signaling',
        'v1',
      ],
      queryParameters: {
        'token': token,
        'force': force.toString(),
      },
    ).toString();

    final ws = await connectWebSocket(
      signalingUrl,
      protocols: [subprotocol],
      connectionTimeout: connectionTimeout,
      certs: certs,
    );
    final wsc = createWebSocketChannel(ws);
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

  Future<void> disconnect([int? code, String? reason]) async {
    final wscStreamSubscription = _wscStreamSubscription;
    if (wscStreamSubscription == null) {
      _logger.fine('already disconnected with code: ${_wsc.closeCode} reason: ${_wsc.closeReason}');
    } else {
      _logger.fine('disconnect code: $code reason: $reason');

      _stopKeepaliveTimer();

      _cleanupTransactions(code, reason);

      _wscStreamSubscription = null;

      await wscStreamSubscription.cancel(); // to prevent onDisconnect and other handlers call

      await _wsc.sink.close(code, reason);
    }
  }

  //

  void _wscStreamOnData(dynamic data) {
    _logger.fine('_wsOnData: $data');

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
    _logger.fine(() => '_addData add: $data');

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
    try {
      final elapsed = await _executeKeepaliveTransaction(defaultExecuteTransactionTimeoutDuration);
      _logger.finest('handshake keepalive latency: $elapsed');

      _startKeepaliveTimer();
    } on WebtritSignalingTransactionTimeoutException catch (e, stackTrace) {
      _onError(WebtritSignalingKeepaliveTransactionTimeoutException(e.id, e.transactionId), stackTrace);
    } catch (error, stackTrace) {
      _onError(error, stackTrace);
    }
  }

  Future<Duration> _executeKeepaliveTransaction(Duration timeoutDuration) async {
    final stopwatch = Stopwatch();

    final keepaliveHandshakeRequest = KeepaliveHandshake();
    final requestJson = keepaliveHandshakeRequest.toJson();
    stopwatch.start();
    final responseJson = await _executeTransaction(requestJson, timeoutDuration);
    stopwatch.stop();
    // ignore: unused_local_variable
    final keepaliveHandshakeResponse = KeepaliveHandshake.fromJson(responseJson);

    return stopwatch.elapsed;
  }
}
