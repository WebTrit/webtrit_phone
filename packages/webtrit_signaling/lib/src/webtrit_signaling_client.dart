import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:logging/logging.dart';

import 'events/events.dart';
import 'exceptions.dart';
import 'handshakes/handshakes.dart';
import 'requests/requests.dart';
import 'transaction.dart';

typedef HandshakeStateHandler = void Function(HandshakeState handshakeState);
typedef EventHandler = void Function(Event event);
typedef ErrorHandler = void Function(Object error, StackTrace? stackTrace);
typedef DisconnectHandler = void Function(int? code, String? reason);

class WebtritSignalingClient {
  static final _callIdRandom = Random();
  static const _callIdChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  static String generateCallId([int length = 24]) {
    return List.generate(length, (index) => _callIdChars[_callIdRandom.nextInt(_callIdChars.length)]).join();
  }

  static const subprotocol = 'webtrit-protocol';

  static const defaultExecuteTransactionTimeoutDuration = Duration(milliseconds: 5000);

  static int _createCounter = 0;

  WebtritSignalingClient._(
    this._ws,
  )   : _id = _createCounter,
        _logger = Logger('$WebtritSignalingClient-$_createCounter') {
    _createCounter++;

    _logger.fine('connected');
  }

  final int _id;
  final Logger _logger;

  final WebSocket _ws;
  StreamSubscription? _wsSubscription;

  late final HandshakeStateHandler _onHandshakeState;
  late final EventHandler _onEvent;
  late final ErrorHandler _onError;
  late final DisconnectHandler _onDisconnect;

  late final Duration _keepaliveInterval;
  Timer? _keepaliveTimer;

  final _transactions = <String, Transaction>{};

  static Future<WebtritSignalingClient> connect(String url, String token, bool force,
      {HttpClient? customHttpClient}) async {
    final signalingUrl = Uri.parse(url).replace(
      pathSegments: ['signaling', 'v1'],
      queryParameters: {
        'token': token,
        'force': force.toString(),
      },
    ).toString();
    final ws = await WebSocket.connect(
      signalingUrl,
      protocols: [subprotocol],
      customClient: customHttpClient,
    );
    return WebtritSignalingClient._(ws);
  }

  void listen({
    required HandshakeStateHandler onHandshakeState,
    required EventHandler onEvent,
    required ErrorHandler onError,
    required DisconnectHandler onDisconnect,
  }) {
    _logger.fine('listen');

    // listen call first to prevent calling this method more then one time
    _wsSubscription = _ws.listen(
      _wsOnData,
      onError: _wsOnError,
      onDone: () => _wsOnDone(_ws.closeCode, _ws.closeReason),
    );
    _onHandshakeState = onHandshakeState;
    _onEvent = onEvent;
    _onError = onError;
    _onDisconnect = onDisconnect;
  }

  Future<void> disconnect([int? code, String? reason]) {
    if (_ws.readyState != WebSocket.open) {
      _logger.fine('already disconnected state: ${_ws.readyState} code: ${_ws.closeCode} reason: ${_ws.closeReason}');
      return Future.value();
    }
    _logger.fine('disconnect code: $code reason: $reason');

    _stopKeepaliveTimer();

    for (final transaction in _transactions.values) {
      transaction.terminateByDisconnect(code, reason);
    }
    _transactions.clear();

    // to prevent call disconnect handler if websocket closed this call
    _wsSubscription?.onDone(null);

    return _ws.close(code, reason);
  }

  //

  void _wsOnData(dynamic data) {
    _logger.finer('_wsOnData: $data');

    final Map<String, dynamic> messageJson = jsonDecode(data);
    _onMessage(messageJson);
  }

  void _wsOnError(dynamic error, StackTrace stackTrace) {
    _logger.warning('_wsOnError', error, stackTrace);

    _onError(error, stackTrace);
  }

  void _wsOnDone(int? closeCode, String? closeReason) {
    _logger.fine('_wsOnDone code: $closeCode reason: $closeReason');

    _stopKeepaliveTimer();

    for (final transaction in _transactions.values) {
      transaction.terminateByDisconnect(closeCode, closeReason);
    }
    _transactions.clear();

    _onDisconnect(closeCode, closeReason);
  }

  //

  Future<void> execute(Request request, [Duration timeoutDuration = defaultExecuteTransactionTimeoutDuration]) async {
    if (_ws.readyState != WebSocket.open) {
      throw WebtritSignalingDisconnectedException(_id);
    }
    _restartKeepaliveTimer();

    final requestJson = request.toJson();
    final responseJson = await _executeTransaction(requestJson, timeoutDuration);
    final type = responseJson['response'];
    if (type == 'ack') {
      return;
    } else if (type == 'error') {
      final Map<String, dynamic> responseErrorJson = responseJson['error'];
      throw WebtritSignalingErrorException(_id, responseErrorJson['code'], responseErrorJson['reason']);
    } else {
      throw WebtritSignalingUnknownResponseException(_id, responseJson);
    }
  }

  //

  void _onMessage(Map<String, dynamic> messageJson) {
    if (messageJson.containsKey('transaction')) {
      final responseJson = messageJson;

      final transactionId = responseJson['transaction'];
      final transaction = _transactions.remove(transactionId);

      if (transaction != null) {
        transaction.handleResponse(responseJson);
      } else {
        _onError(WebtritSignalingTransactionUnavailableException(_id, transactionId), StackTrace.current);
      }
    } else if (messageJson.containsKey('event')) {
      final eventJson = messageJson;

      try {
        final event = _toEvent(eventJson);
        _onEvent(event);
      } catch (error, stackTrace) {
        _onError(error, stackTrace);
      }
    } else if (messageJson['handshake'] == HandshakeState.type) {
      final handshakeStateJson = messageJson;

      try {
        final handshakeState = HandshakeState.fromJson(handshakeStateJson);
        _onHandshakeState(handshakeState);

        _keepaliveInterval = handshakeState.keepaliveInterval;
        _startKeepaliveTimer();
      } catch (error, stackTrace) {
        _onError(error, stackTrace);
      }
    } else {
      _onError(WebtritSignalingUnknownMessageException(_id, messageJson), StackTrace.current);
    }
  }

  Future<Map<String, dynamic>> _executeTransaction(Map<String, dynamic> requestJson, Duration timeoutDuration) async {
    final transaction = Transaction(_id, timeoutDuration);

    _transactions[transaction.id] = transaction;
    requestJson['transaction'] = transaction.id;

    _addMessage(requestJson);

    try {
      final responseJson = await transaction.future;
      responseJson.remove('transaction');

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

    _ws.add(data);
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
      final requestJson = HandshakeKeepalive().toJson();
      stopwatch.start();
      final responseJson = await _executeTransaction(requestJson, defaultExecuteTransactionTimeoutDuration);
      stopwatch.stop();
      HandshakeKeepalive.fromJson(responseJson);
      _logger.finest('handshake keepalive latency: ${stopwatch.elapsed}');
    } on WebtritSignalingTransactionTimeoutException catch (error) {
      _onError(WebtritSignalingKeepaliveTimeoutException(error.id, error.transactionId), StackTrace.current);
    } catch (error, stackTrace) {
      _onError(error, stackTrace);
    }

    _startKeepaliveTimer();
  }

  //

  Event _toEvent(Map<String, dynamic> eventJson) {
    final eventType = eventJson['event'];
    switch (eventJson['event']) {
      case RegisteringEvent.event:
        return RegisteringEvent.fromJson(eventJson);
      case RegisteredEvent.event:
        return RegisteredEvent.fromJson(eventJson);
      case RegistrationFailedEvent.event:
        return RegistrationFailedEvent.fromJson(eventJson);
      case UnregisteringEvent.event:
        return UnregisteringEvent.fromJson(eventJson);
      case UnregisteredEvent.event:
        return UnregisteredEvent.fromJson(eventJson);
      case CallingEvent.event:
        return CallingEvent.fromJson(eventJson);
      case RingingEvent.event:
        return RingingEvent.fromJson(eventJson);
      case ProceedingEvent.event:
        return ProceedingEvent.fromJson(eventJson);
      case ProgressEvent.event:
        return ProgressEvent.fromJson(eventJson);
      case AcceptedEvent.event:
        return AcceptedEvent.fromJson(eventJson);
      case AcceptingEvent.event:
        return AcceptingEvent.fromJson(eventJson);
      case IncomingCallEvent.event:
        return IncomingCallEvent.fromJson(eventJson);
      case UpdatingCallEvent.event:
        return UpdatingCallEvent.fromJson(eventJson);
      case MissedCallEvent.event:
        return MissedCallEvent.fromJson(eventJson);
      case HangingupEvent.event:
        return HangingupEvent.fromJson(eventJson);
      case HangupEvent.event:
        return HangupEvent.fromJson(eventJson);
      case DecliningEvent.event:
        return DecliningEvent.fromJson(eventJson);
      case UpdatingEvent.event:
        return UpdatingEvent.fromJson(eventJson);
      case UpdatedEvent.event:
        return UpdatedEvent.fromJson(eventJson);
      case TransferringEvent.event:
        return TransferringEvent.fromJson(eventJson);
      case TransferEvent.event:
        return TransferEvent.fromJson(eventJson);
      case HoldingEvent.event:
        return HoldingEvent.fromJson(eventJson);
      case ResumingEvent.event:
        return ResumingEvent.fromJson(eventJson);
      case IceWebrtcUpEvent.event:
        return IceWebrtcUpEvent.fromJson(eventJson);
      case IceMediaEvent.event:
        return IceMediaEvent.fromJson(eventJson);
      case IceSlowLinkEvent.event:
        return IceSlowLinkEvent.fromJson(eventJson);
      case IceHangupEvent.event:
        return IceHangupEvent.fromJson(eventJson);
      case CallErrorEvent.event:
        return CallErrorEvent.fromJson(eventJson);
      case ErrorEvent.event:
        return ErrorEvent.fromJson(eventJson);
      default:
        throw ArgumentError.value(eventType, "eventType", "Unknown event type");
    }
  }
}
