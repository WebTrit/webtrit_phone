import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

import 'events/events.dart';
import 'exceptions.dart';
import 'requests/requests.dart';
import 'transaction.dart';

class WebtritSignalingClient {
  static const subprotocol = 'webtrit-protocol';

  static int _createCounter = 0;

  WebtritSignalingClient(
    this.url,
    this.token, {
    required this.onEvent,
    required this.onError,
    required this.onDisconnect,
  }) : _logger = Logger('$WebtritSignalingClient-$_createCounter') {
    _createCounter++;
  }

  final Logger _logger;

  final String url;
  final String token;

  final void Function(Event event) onEvent;
  final void Function(Object error, StackTrace? stackTrace) onError;
  final void Function(int? code, String? reason) onDisconnect;

  WebSocket? _ws;
  Duration? _keepaliveInterval;

  Timer? _keepaliveTimer;

  final _transactions = <String, Transaction>{};

  String _signalingUrl(bool force) => Uri.parse(url).replace(
        pathSegments: ['signaling', 'websocket'],
        queryParameters: {
          'token': token,
          'force': force.toString(),
        },
      ).toString();

  Future<void> connect(bool force) async {
    if (_ws != null) {
      throw WebtritSignalingAlreadyConnectException();
    } else {
      final ws = await WebSocket.connect(_signalingUrl(force), protocols: [subprotocol]);
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
    final Map<String, dynamic> message = jsonDecode(data);
    _onMessageCallback(message);
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

  Future<void> execute(Request request) async {
    final requestMessage = request.toJson();
    await _execute(requestMessage);
  }

  Future<void> _execute(Map<String, dynamic> requestMessage) async {
    _restartKeepaliveTimer();

    final responseMessage = await _executeMessage(requestMessage);
    final type = responseMessage['response'];
    if (type == 'ack') {
      return;
    } else if (type == 'error') {
      final Map<String, dynamic> responseError = responseMessage['error'];
      throw WebtritSignalingErrorException(responseError['code'], responseError['reason']);
    } else {
      throw WebtritSignalingResponseException(responseMessage);
    }
  }

  //

  void _onMessageCallback(Map<String, dynamic> message) {
    if (message.containsKey('transaction')) {
      final responseMessage = message;

      final String transactionId = responseMessage['transaction'];
      final transaction = _transactions.remove(transactionId);

      if (transaction != null) {
        transaction.handleResponse(responseMessage);
      } else {
        onError(WebtritSignalingTransactionUnavailableException(transactionId), StackTrace.current);
      }
    } else if (message.containsKey('event')) {
      final eventMessage = message;

      try {
        final event = _toEvent(eventMessage);
        onEvent(event);
      } catch (error, stackTrace) {
        onError(error, stackTrace);
      }
    } else {
      onError(WebtritSignalingUnknownMessageException(message), StackTrace.current);
    }
  }

  Future<Map<String, dynamic>> _executeMessage(Map<String, dynamic> requestMessage) async {
    final transaction = Transaction();

    _transactions[transaction.id] = transaction;
    requestMessage['transaction'] = transaction.id;

    _addMessage(requestMessage);

    final responseMessage = await transaction.future;
    responseMessage.remove('transaction');

    return responseMessage;
  }

  void _addMessage(Map<String, dynamic> message) {
    final data = jsonEncode(message);
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
      _keepaliveTimer = Timer(keepaliveInterval, _keepaliveCallback);
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

  void _keepaliveCallback() async {
    try {
      await _execute(<String, dynamic>{
        'request': 'keepalive',
      });
    } on WebtritSignalingTimeoutException catch (error, stackTrace) {
      onError(WebtritSignalingKeepaliveTimeoutException(), stackTrace);
    } catch (error, stackTrace) {
      onError(error, stackTrace);
    }
  }

  //

  Event _toEvent(Map<String, dynamic> eventMessage) {
    switch (eventMessage['event']) {
      case StateEvent.event:
        final keepaliveInterval = Duration(milliseconds: eventMessage['keepalive_interval'] as int);
        _keepaliveInterval = keepaliveInterval;

        _restartKeepaliveTimer();

        return StateEvent.fromJson(eventMessage);
      case RegisteringEvent.event:
        return RegisteringEvent.fromJson(eventMessage);
      case RegisteredEvent.event:
        return RegisteredEvent.fromJson(eventMessage);
      case RegistrationFailedEvent.event:
        return RegistrationFailedEvent.fromJson(eventMessage);
      case UnregisteringEvent.event:
        return UnregisteringEvent.fromJson(eventMessage);
      case UnregisteredEvent.event:
        return UnregisteredEvent.fromJson(eventMessage);
      case CallingEvent.event:
        return CallingEvent.fromJson(eventMessage);
      case RingingEvent.event:
        return RingingEvent.fromJson(eventMessage);
      case ProceedingEvent.event:
        return ProceedingEvent.fromJson(eventMessage);
      case ProgressEvent.event:
        return ProgressEvent.fromJson(eventMessage);
      case AnsweredEvent.event:
        return AnsweredEvent.fromJson(eventMessage);
      case AcceptingEvent.event:
        return AcceptingEvent.fromJson(eventMessage);
      case AcceptedEvent.event:
        return AcceptedEvent.fromJson(eventMessage);
      case IncomingCallEvent.event:
        return IncomingCallEvent.fromJson(eventMessage);
      case UpdatingCallEvent.event:
        return UpdatingCallEvent.fromJson(eventMessage);
      case MissedCallEvent.event:
        return MissedCallEvent.fromJson(eventMessage);
      case HangingupEvent.event:
        return HangingupEvent.fromJson(eventMessage);
      case HangupEvent.event:
        return HangupEvent.fromJson(eventMessage);
      case DecliningEvent.event:
        return DecliningEvent.fromJson(eventMessage);
      case UpdatingEvent.event:
        return UpdatingEvent.fromJson(eventMessage);
      case UpdatedEvent.event:
        return UpdatedEvent.fromJson(eventMessage);
      case TransferringEvent.event:
        return TransferringEvent.fromJson(eventMessage);
      case TransferEvent.event:
        return TransferEvent.fromJson(eventMessage);
      case HoldingEvent.event:
        return HoldingEvent.fromJson(eventMessage);
      case ResumingEvent.event:
        return ResumingEvent.fromJson(eventMessage);
      case IceWebrtcUpEvent.event:
        return IceWebrtcUpEvent.fromJson(eventMessage);
      case IceMediaEvent.event:
        return IceMediaEvent.fromJson(eventMessage);
      case IceSlowLinkEvent.event:
        return IceSlowLinkEvent.fromJson(eventMessage);
      case IceHangupEvent.event:
        return IceHangupEvent.fromJson(eventMessage);
      case CallErrorEvent.event:
        return CallErrorEvent.fromJson(eventMessage);
      case ErrorEvent.event:
        return ErrorEvent.fromJson(eventMessage);
      default:
        throw ArgumentError.value(eventMessage, "eventMessage", "Unknown event message");
    }
  }
}
