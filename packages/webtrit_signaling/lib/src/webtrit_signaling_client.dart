import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:logging/logging.dart';

import 'commands/commands.dart';
import 'events/events.dart';
import 'exceptions.dart';
import 'transaction.dart';

class WebtritSignalingClient extends Stream<Event> {
  static const subprotocol = 'webtrit-protocol';

  static int _createCounter = 0;

  WebtritSignalingClient(
    this._ws,
  ) : _logger = Logger('$WebtritSignalingClient-$_createCounter') {
    _createCounter++;

    _ws.listen(
      _wsOnData,
      onError: _wsOnError,
      onDone: _wsOnDone,
    );
  }

  final Logger _logger;

  final WebSocket _ws;
  final StreamController<Event> _controller = StreamController(sync: true);

  final _transactions = <String, Transaction>{};

  static Future<WebtritSignalingClient> connect(String url, String token) async {
    final signalingUrl = Uri.parse(url).replace(
      pathSegments: ['signaling', 'websocket'],
      queryParameters: {'token': token},
    ).toString();
    return WebtritSignalingClient(await WebSocket.connect(signalingUrl, protocols: [subprotocol]));
  }

  int? get closeCode => _ws.closeCode;

  String? get closeReason => _ws.closeReason;

  //

  Future<void> close([int? code, String? reason]) {
    return _ws.close(code, reason);
  }

  //

  void _wsOnData(dynamic data) {
    _logger.finer('_wsOnData: $data');
    final Map<String, dynamic> message = jsonDecode(data);
    _onMessageCallback(message);
  }

  void _wsOnError(dynamic error, StackTrace stackTrace) {
    _logger.warning('_wsOnError', error, stackTrace);
    _controller.addError(error, stackTrace);
  }

  void _wsOnDone() {
    _logger.fine('_wsOnDone');
    _controller.close();
  }

  // Stream<Event>

  @override
  StreamSubscription<Event> listen(
    void onData(Event event)?, {
    Function? onError,
    void onDone()?,
    bool? cancelOnError,
  }) {
    return _controller.stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  //

  Future<void> send(Command command) async {
    final requestMessage = _toMap(command);

    final responseMessage = await _executeTransaction(requestMessage);

    final response = responseMessage['response'];
    if (response == 'ack') {
      return;
    } else if (response == 'error') {
      final Map<String, dynamic> responseError = responseMessage['error'];
      throw WebtritSignalingErrorException(responseError['code'], responseError['reason']);
    } else {
      throw ArgumentError();
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
        _controller.addError(WebtritSignalingTransactionUnavailableException(transactionId), StackTrace.current);
      }
    } else if (message.containsKey('event')) {
      final eventMessage = message;

      try {
        final event = _toEvent(eventMessage);
        _controller.add(event);
      } catch (error, stackTrace) {
        _controller.addError(error, stackTrace);
      }
    } else {
      throw ArgumentError();
    }
  }

  Future<Map<String, dynamic>> _executeTransaction(Map<String, dynamic> requestMessage) async {
    final transaction = Transaction();

    _transactions[transaction.id] = transaction;
    requestMessage['transaction'] = transaction.id;

    _addMessage(requestMessage);

    final responseMessage = await transaction.future;
    responseMessage.remove('transaction');

    return responseMessage;
  }

  _addMessage(Map<String, dynamic> message) {
    final data = jsonEncode(message);
    _addData(data);
  }

  _addData(dynamic data) {
    _ws.add(data);

    _logger.finer(() => '>> sent\n$data');
  }

  //

  Map<String, dynamic> _toMap(Command command) {
    if (command is RegisterCommand) {
      return <String, dynamic>{
        'request': 'register',
        'display_name': command.displayName,
      };
    } else if (command is UnregisterCommand) {
      return <String, dynamic>{
        'request': 'unregister',
      };
    } else if (command is TrickleCommand) {
      return <String, dynamic>{
        'request': 'trickle',
        'candidate': command.candidate,
      };
    } else if (command is CallCommand) {
      return <String, dynamic>{
        'request': 'call',
        if (command.callId != null) 'call_id': command.callId,
        'number': command.number,
        'jsep': command.jsep,
      };
    } else if (command is AcceptCommand) {
      return <String, dynamic>{
        'request': 'accept',
        'jsep': command.jsep,
      };
    } else if (command is UpdateCommand) {
      return <String, dynamic>{
        'request': 'update',
        'jsep': command.jsep,
      };
    } else if (command is DeclineCommand) {
      return <String, dynamic>{
        'request': 'decline',
      };
    } else if (command is HangupCommand) {
      return <String, dynamic>{
        'request': 'hangup',
      };
    } else if (command is TransferCommand) {
      return <String, dynamic>{
        'request': 'transfer',
        'number': command.number,
        if (command.replace_call_id != null) 'replace_call_id': command.replace_call_id,
      };
    } else if (command is HoldCommand) {
      return <String, dynamic>{
        'request': 'hold',
        if (command.direction != null) 'direction': EnumToString.convertToString(command.direction)
      };
    } else if (command is UnholdCommand) {
      return <String, dynamic>{
        'request': 'unhold',
      };
    } else {
      throw ArgumentError();
    }
  }

  //

  Event _toEvent(Map<String, dynamic> eventMessage) {
    switch (eventMessage['event']) {
      case 'registering':
        return RegisteringEvent();
      case 'registered':
        return RegisteredEvent();
      case 'unregistering':
        return UnregisteringEvent();
      case 'unregistered':
        return UnregisteredEvent();
      case 'calling':
        return CallingEvent(
          callId: eventMessage['call_id'],
        );
      case 'ringing':
        return RingingEvent(
          callId: eventMessage['call_id'],
        );
      case 'proceeding':
        return ProceedingEvent(
          callId: eventMessage['call_id'],
          code: eventMessage['code'],
        );
      case 'progress':
        return ProgressEvent(
          callId: eventMessage['call_id'],
          callee: eventMessage['callee'],
          isFocus: eventMessage['is_focus'],
          jsep: eventMessage['jsep'],
        );
      case 'answered':
        return AnsweredEvent(
          callId: eventMessage['call_id'],
          callee: eventMessage['callee'],
          isFocus: eventMessage['is_focus'],
          jsep: eventMessage['jsep'],
        );
      case 'accepting':
        return AcceptingEvent(
          callId: eventMessage['call_id'],
        );
      case 'accepted':
        return AcceptedEvent(
          callId: eventMessage['call_id'],
        );
      case 'incoming_call':
        return IncomingCallEvent(
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
          callId: eventMessage['call_id'],
          callee: eventMessage['callee'],
          caller: eventMessage['caller'],
          callerDisplayName: eventMessage['caller_display_name'],
        );
      case 'hangingup':
        return HangingupEvent(
          callId: eventMessage['call_id'],
        );
      case 'hangup':
        return HangupEvent(
          callId: eventMessage['call_id'],
          code: eventMessage['code'],
          reason: eventMessage['reason'],
        );
      case 'declining':
        return DecliningEvent(
          callId: eventMessage['call_id'],
          code: eventMessage['code'],
          referId: eventMessage['refer_id'],
        );
      case 'updating':
        return UpdatingEvent(
          callId: eventMessage['call_id'],
        );
      case 'updated':
        return UpdatedEvent(
          callId: eventMessage['call_id'],
        );
      case 'transferring':
        return TransferringEvent(
          callId: eventMessage['call_id'],
        );
      case 'transfer':
        return TransferEvent(
          referId: eventMessage['refer_id'],
          referTo: eventMessage['refer_to'],
          referredBy: eventMessage['referred_by'],
          replaceCallId: eventMessage['replace_call_id'],
        );
      case 'holding':
        return HoldingEvent(
          callId: eventMessage['call_id'],
        );
      case 'resuming':
        return ResumingEvent(
          callId: eventMessage['call_id'],
        );
      case 'ice_webrtcup':
        return IceWebrtcUpEvent();
      case 'ice_media':
        return IceMediaEvent(
          type: EnumToString.fromString(IceMediaType.values, eventMessage['type'])!,
          receiving: eventMessage['receiving'],
        );
      case 'ice_slowlink':
        return IceSlowLinkEvent(
          media: EnumToString.fromString(IceMediaType.values, eventMessage['media'])!,
          uplink: eventMessage['uplink'],
          lost: eventMessage['lost'],
        );
      case 'ice_hangup':
        return IceHangupEvent(
          reason: eventMessage['reason'],
        );
      default:
        throw ArgumentError();
    }
  }
}
