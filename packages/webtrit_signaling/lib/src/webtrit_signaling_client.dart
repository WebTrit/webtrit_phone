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
    final requestMessage = _toMap(request);
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

  Map<String, dynamic> _toMap(Request request) {
    if (request is TrickleRequest) {
      return <String, dynamic>{
        'request': 'trickle',
        'line': request.line,
        'candidate': request.candidate,
      };
    } else if (request is CallRequest) {
      return <String, dynamic>{
        'request': 'call',
        'line': request.line,
        if (request.callId != null) 'call_id': request.callId,
        'number': request.number,
        'jsep': request.jsep,
      };
    } else if (request is AcceptRequest) {
      return <String, dynamic>{
        'request': 'accept',
        'line': request.line,
        'jsep': request.jsep,
      };
    } else if (request is UpdateRequest) {
      return <String, dynamic>{
        'request': 'update',
        'line': request.line,
        'jsep': request.jsep,
      };
    } else if (request is DeclineRequest) {
      return <String, dynamic>{
        'request': 'decline',
        'line': request.line,
      };
    } else if (request is HangupRequest) {
      return <String, dynamic>{
        'request': 'hangup',
        'line': request.line,
      };
    } else if (request is TransferRequest) {
      return <String, dynamic>{
        'request': 'transfer',
        'line': request.line,
        'number': request.number,
        if (request.replaceCallId != null) 'replace_call_id': request.replaceCallId,
      };
    } else if (request is HoldRequest) {
      final direction = request.direction;
      return <String, dynamic>{
        'request': 'hold',
        'line': request.line,
        if (direction != null) 'direction': direction.name,
      };
    } else if (request is UnholdRequest) {
      return <String, dynamic>{
        'request': 'unhold',
        'line': request.line,
      };
    } else {
      throw ArgumentError();
    }
  }

  //

  Event _toEvent(Map<String, dynamic> eventMessage) {
    switch (eventMessage['event']) {
      case 'state':
        final keepaliveInterval = Duration(milliseconds: eventMessage['keepalive_interval'] as int);
        _keepaliveInterval = keepaliveInterval;

        _restartKeepaliveTimer();

        final registrationStateMessage = eventMessage['registration_state'];
        final registrationState = RegistrationState(
          status: RegistrationStatus.values.byName(registrationStateMessage['status']),
          code: registrationStateMessage['code'],
          reason: registrationStateMessage['reason'],
        );
        final lineStatesMessage = eventMessage['line_states'] as List<dynamic>;
        final lineStates = lineStatesMessage
            .map((lineStateMessage) => LineState(
                  status: CallStatus.values.byName(lineStateMessage['status']),
                ))
            .toList();
        return StateEvent(
          registrationState: registrationState,
          lineStates: lineStates,
        );
      case 'registering':
        return RegisteringEvent();
      case 'registered':
        return RegisteredEvent();
      case 'registration_failed':
        return RegistrationFailedEvent(
          code: eventMessage['code'],
          reason: eventMessage['reason'],
        );
      case 'unregistering':
        return UnregisteringEvent();
      case 'unregistered':
        return UnregisteredEvent();
      case 'calling':
        return CallingEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
        );
      case 'ringing':
        return RingingEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
        );
      case 'proceeding':
        return ProceedingEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
          code: eventMessage['code'],
        );
      case 'progress':
        return ProgressEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
          callee: eventMessage['callee'],
          isFocus: eventMessage['is_focus'],
          jsep: eventMessage['jsep'],
        );
      case 'answered':
        return AnsweredEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
          callee: eventMessage['callee'],
          isFocus: eventMessage['is_focus'],
          jsep: eventMessage['jsep'],
        );
      case 'accepting':
        return AcceptingEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
        );
      case 'accepted':
        return AcceptedEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
        );
      case 'incoming_call':
        return IncomingCallEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'] as String,
          callee: eventMessage['callee'],
          caller: eventMessage['caller'],
          callerDisplayName: eventMessage['caller_display_name'],
          replaceCallId: eventMessage['replace_call_id'],
          isFocus: eventMessage['is_focus'],
          jsep: eventMessage['jsep'],
        );
      case 'updating_call':
        return UpdatingCallEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
          callee: eventMessage['callee'],
          caller: eventMessage['caller'],
          callerDisplayName: eventMessage['caller_display_name'],
          replaceCallId: eventMessage['replace_call_id'],
          isFocus: eventMessage['is_focus'],
          jsep: eventMessage['jsep'],
        );
      case 'missed_call':
        return MissedCallEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
          callee: eventMessage['callee'],
          caller: eventMessage['caller'],
          callerDisplayName: eventMessage['caller_display_name'],
        );
      case 'hangingup':
        return HangingupEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
        );
      case 'hangup':
        return HangupEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
          code: eventMessage['code'],
          reason: eventMessage['reason'],
        );
      case 'declining':
        return DecliningEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
          code: eventMessage['code'],
          referId: eventMessage['refer_id'],
        );
      case 'updating':
        return UpdatingEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
        );
      case 'updated':
        return UpdatedEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
        );
      case 'transferring':
        return TransferringEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
        );
      case 'transfer':
        return TransferEvent(
          line: eventMessage['line'],
          referId: eventMessage['refer_id'],
          referTo: eventMessage['refer_to'],
          referredBy: eventMessage['referred_by'],
          replaceCallId: eventMessage['replace_call_id'],
        );
      case 'holding':
        return HoldingEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
        );
      case 'resuming':
        return ResumingEvent(
          line: eventMessage['line'],
          callId: eventMessage['call_id'],
        );
      case 'ice_webrtcup':
        return IceWebrtcUpEvent(
          line: eventMessage['line'],
        );
      case 'ice_media':
        return IceMediaEvent(
          line: eventMessage['line'],
          type: IceMediaType.values.byName(eventMessage['type']),
          receiving: eventMessage['receiving'],
        );
      case 'ice_slowlink':
        return IceSlowLinkEvent(
          line: eventMessage['line'],
          media: IceMediaType.values.byName(eventMessage['media']),
          uplink: eventMessage['uplink'],
          lost: eventMessage['lost'],
        );
      case 'ice_hangup':
        return IceHangupEvent(
          line: eventMessage['line'],
          reason: eventMessage['reason'],
        );
      case 'error':
        final line = eventMessage['line'];
        final callId = eventMessage['call_id'];
        if (callId != null) {
          return CallErrorEvent(
            line: line,
            callId: callId,
            code: eventMessage['code'],
            description: eventMessage['description'],
          );
        } else {
          return ErrorLineEvent(
            line: line,
            code: eventMessage['code'],
            description: eventMessage['description'],
          );
        }
      default:
        throw ArgumentError();
    }
  }
}
