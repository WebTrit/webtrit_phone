import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:logging/logging.dart';

import 'events/events.dart';
import 'exceptions.dart';
import 'requests/requests.dart';
import 'transaction.dart';

class WebtritSignalingClient {
  static final _callIdRandom = Random();
  static const _callIdChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  static String generateCallId([int length = 24]) {
    return List.generate(length, (index) => _callIdChars[_callIdRandom.nextInt(_callIdChars.length)]).join();
  }

  static const subprotocol = 'webtrit-protocol';

  static const defaultExecuteRequestTimeoutDuration = Duration(milliseconds: 5000);

  static int _createCounter = 0;

  WebtritSignalingClient(
    this.url, {
    required this.onEvent,
    required this.onError,
    required this.onDisconnect,
  }) : _logger = Logger('$WebtritSignalingClient-$_createCounter') {
    _createCounter++;
  }

  final Logger _logger;

  final String url;

  final void Function(Event event) onEvent;
  final void Function(Object error, StackTrace? stackTrace) onError;
  final void Function(int? code, String? reason) onDisconnect;

  WebSocket? _ws;
  Duration? _keepaliveInterval;

  Timer? _keepaliveTimer;

  final _transactions = <String, Transaction>{};

  String _signalingUrl(String token, bool force) => Uri.parse(url).replace(
        pathSegments: ['signaling', 'websocket'],
        queryParameters: {
          'token': token,
          'force': force.toString(),
        },
      ).toString();

  Future<void> connect(String token, bool force) async {
    if (_ws != null) {
      throw WebtritSignalingAlreadyConnectException();
    } else {
      final ws = await WebSocket.connect(_signalingUrl(token, force), protocols: [subprotocol]);
      ws.listen(
        _wsOnData,
        onError: _wsOnError,
        onDone: () => _wsOnDone(ws.closeCode, ws.closeReason),
      );
      _ws = ws;
    }
  }

  //

  Future<void> disconnect([int? code, String? reason]) {
    _stopKeepaliveTimer();

    final ws = _ws;
    _ws = null;
    if (ws != null) {
      return ws.close(code, reason);
    } else {
      return Future.value();
    }
  }

  //

  void _wsOnData(dynamic data) {
    _logger.finer('_wsOnData: $data');
    final Map<String, dynamic> messageJson = jsonDecode(data);
    _onMessage(messageJson);
  }

  void _wsOnError(dynamic error, StackTrace stackTrace) {
    _logger.warning('_wsOnError', error, stackTrace);
    _stopKeepaliveTimer();
    onError(error, stackTrace);
  }

  void _wsOnDone(int? closeCode, String? closeReason) {
    _logger.fine('_wsOnDone code: $closeCode reason: $closeReason');
    _stopKeepaliveTimer();
    for (final transaction in _transactions.values) {
      transaction.terminate(closeCode, closeReason);
    }
    onDisconnect(closeCode, closeReason);
  }

  //

  Future<void> execute(Request request, [Duration timeoutDuration = defaultExecuteRequestTimeoutDuration]) async {
    final requestJson = request.toJson();
    await _execute(requestJson, timeoutDuration);
  }

  Future<void> _execute(Map<String, dynamic> requestJson, Duration timeoutDuration) async {
    _restartKeepaliveTimer();

    final responseJson = await _executeRequest(requestJson, timeoutDuration);
    final type = responseJson['response'];
    if (type == 'ack') {
      return;
    } else if (type == 'error') {
      final Map<String, dynamic> responseErrorJson = responseJson['error'];
      throw WebtritSignalingErrorException(responseErrorJson['code'], responseErrorJson['reason']);
    } else {
      throw WebtritSignalingResponseException(responseJson);
    }
  }

  //

  void _onMessage(Map<String, dynamic> messageJson) {
    if (messageJson.containsKey('transaction')) {
      final responseJson = messageJson;

      final String transactionId = responseJson['transaction'];
      final transaction = _transactions.remove(transactionId);

      if (transaction != null) {
        transaction.handleResponse(responseJson);
      } else {
        onError(WebtritSignalingTransactionUnavailableException(transactionId), StackTrace.current);
      }
    } else if (messageJson.containsKey('event')) {
      final eventJson = messageJson;

      try {
        final event = _toEvent(eventJson);
        onEvent(event);
      } catch (error, stackTrace) {
        onError(error, stackTrace);
      }
    } else {
      onError(WebtritSignalingUnknownMessageException(messageJson), StackTrace.current);
    }
  }

  Future<Map<String, dynamic>> _executeRequest(Map<String, dynamic> requestJson, Duration timeoutDuration) async {
    final transaction = Transaction(timeoutDuration);

    _transactions[transaction.id] = transaction;
    requestJson['transaction'] = transaction.id;

    _addMessage(requestJson);

    final responseJson = await transaction.future;
    responseJson.remove('transaction');

    return responseJson;
  }

  void _addMessage(Map<String, dynamic> messageJson) {
    final data = jsonEncode(messageJson);
    _addData(data);
  }

  void _addData(dynamic data) {
    final ws = _ws;
    if (ws != null) {
      ws.add(data);
      _logger.finer(() => '_addData add: $data');
    } else {
      _logger.finer(() => '_addData skip: $data');
    }
  }

  //

  void _startKeepaliveTimer() {
    final keepaliveInterval = _keepaliveInterval;
    if (keepaliveInterval != null) {
      _keepaliveTimer = Timer(keepaliveInterval, _onKeepalive);
    }
  }

  void _stopKeepaliveTimer() {
    final keepaliveTimer = _keepaliveTimer;
    if (keepaliveTimer != null && keepaliveTimer.isActive) {
      keepaliveTimer.cancel();
    }
  }

  void _restartKeepaliveTimer() {
    _stopKeepaliveTimer();
    _startKeepaliveTimer();
  }

  void _onKeepalive() async {
    try {
      await _execute(<String, dynamic>{
        'request': 'keepalive',
      }, defaultExecuteRequestTimeoutDuration);
    } on WebtritSignalingTimeoutException catch (error, stackTrace) {
      onError(WebtritSignalingKeepaliveTimeoutException(), stackTrace);
    } catch (error, stackTrace) {
      onError(error, stackTrace);
    }
  }

  //

  Event _toEvent(Map<String, dynamic> eventJson) {
    final eventType = eventJson['event'];
    switch (eventJson['event']) {
      case StateEvent.event:
        final keepaliveInterval = Duration(milliseconds: eventJson['keepalive_interval'] as int);
        _keepaliveInterval = keepaliveInterval;

        _restartKeepaliveTimer();

        return StateEvent.fromJson(eventJson);
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
      case AnsweredEvent.event:
        return AnsweredEvent.fromJson(eventJson);
      case AcceptingEvent.event:
        return AcceptingEvent.fromJson(eventJson);
      case AcceptedEvent.event:
        return AcceptedEvent.fromJson(eventJson);
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
