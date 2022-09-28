import 'package:equatable/equatable.dart';

import '../events/events.dart';
import '../requests/requests.dart';
import '../responses/responses.dart';
import 'handshake.dart';

enum RegistrationStatus {
  registering,
  registered,
  // ignore: constant_identifier_names
  registration_failed,
  unregistering,
  unregistered,
}

class Registration extends Equatable {
  const Registration({
    required this.status,
    this.code,
    this.reason,
  });

  final RegistrationStatus status;
  final int? code;
  final String? reason;

  @override
  List<Object?> get props => [
        status,
        code,
        reason,
      ];
}

class Line extends Equatable {
  Line({
    required this.callId,
    required this.callLogs,
  });

  final String callId;
  final List<CallLog> callLogs;

  @override
  List<Object?> get props => [
        callId,
        callLogs,
      ];
}

abstract class CallLog extends Equatable {
  const CallLog({
    required this.timestamp,
  });

  final int timestamp;

  @override
  List<Object?> get props => [
        timestamp,
      ];
}

class CallRequestLog extends CallLog {
  const CallRequestLog({
    required int timestamp,
    required this.callRequest,
  }) : super(timestamp: timestamp);

  final CallRequest callRequest;

  @override
  List<Object?> get props => [
        ...super.props,
        callRequest,
      ];
}

class ResponseLog extends CallLog {
  const ResponseLog({
    required int timestamp,
    required this.response,
  }) : super(timestamp: timestamp);

  final Response response;

  @override
  List<Object?> get props => [
        ...super.props,
        response,
      ];
}

class CallEventLog extends CallLog {
  const CallEventLog({
    required int timestamp,
    required this.callEvent,
  }) : super(timestamp: timestamp);

  final CallEvent callEvent;

  @override
  List<Object?> get props => [
        ...super.props,
        callEvent,
      ];
}

class StateHandshake extends Handshake {
  const StateHandshake({
    required this.keepaliveInterval,
    required this.timestamp,
    required this.registration,
    required this.lines,
  }) : super();

  final Duration keepaliveInterval;
  final int timestamp;
  final Registration registration;
  final List<Line?> lines;

  @override
  List<Object?> get props => [
        keepaliveInterval,
        timestamp,
        registration,
        lines,
      ];

  static const type = 'state';

  factory StateHandshake.fromJson(Map<String, dynamic> json) {
    final handshakeValue = json['handshake'];
    if (handshakeValue != type) {
      throw ArgumentError.value(handshakeValue, "handshake", "Not equal $type");
    }

    final keepaliveInterval = Duration(milliseconds: json['keepalive_interval'] as int);

    final timestamp = json['timestamp'] as int;

    final registrationMessage = json['registration'];
    final registration = Registration(
      status: RegistrationStatus.values.byName(registrationMessage['status']),
      code: registrationMessage['code'],
      reason: registrationMessage['reason'],
    );
    final linesJson = json['lines'] as List<dynamic>;
    final lines = linesJson.asMap().entries.map((e) {
      final lineIndex = e.key;
      final lineJson = e.value;
      if (lineJson == null) {
        return null;
      }

      final callId = lineJson['call_id'] as String;
      final callLogs = (lineJson['call_logs'] as List<dynamic>).map<CallLog>((callLogJson) {
        final timestamp = callLogJson[0] as int;
        final requestOrResponseOrEventJson = callLogJson[1];
        requestOrResponseOrEventJson['line'] = lineIndex; // inject line to apply universal fromJson methods
        requestOrResponseOrEventJson['call_id'] = callId; // inject call_id to apply universal fromJson methods
        if (requestOrResponseOrEventJson.containsKey('request')) {
          return CallRequestLog(timestamp: timestamp, callRequest: _toRequest(requestOrResponseOrEventJson));
        } else if (requestOrResponseOrEventJson.containsKey(Response.typeKey)) {
          return ResponseLog(timestamp: timestamp, response: Response.fromJson(requestOrResponseOrEventJson));
        } else if (requestOrResponseOrEventJson.containsKey('event')) {
          return CallEventLog(timestamp: timestamp, callEvent: _toEvent(requestOrResponseOrEventJson));
        } else {
          throw ArgumentError.value(
              requestOrResponseOrEventJson, "requestOrResponseOrEventJson", "Active call's logs incorrect");
        }
      }).toList(growable: false);

      return Line(
        callId: callId,
        callLogs: callLogs,
      );
    }).toList(growable: false);

    return StateHandshake(
      keepaliveInterval: keepaliveInterval,
      timestamp: timestamp,
      registration: registration,
      lines: lines,
    );
  }

  static CallRequest _toRequest(Map<String, dynamic> requestJson) {
    final requestType = requestJson['request'];
    switch (requestType) {
      case AcceptRequest.request:
        return AcceptRequest.fromJson(requestJson);
      case DeclineRequest.request:
        return DeclineRequest.fromJson(requestJson);
      case HangupRequest.request:
        return HangupRequest.fromJson(requestJson);
      case HoldRequest.request:
        return HangupRequest.fromJson(requestJson);
      case OutgoingCallRequest.request:
        return OutgoingCallRequest.fromJson(requestJson);
      case UnholdRequest.request:
        return UnholdRequest.fromJson(requestJson);
      case UpdateRequest.request:
        return UpdateRequest.fromJson(requestJson);
      default:
        throw ArgumentError.value(requestType, "requestType", "Unknown request type");
    }
  }

  static CallEvent _toEvent(Map<String, dynamic> eventJson) {
    final eventType = eventJson['event'];
    switch (eventType) {
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
      case HoldingEvent.event:
        return HoldingEvent.fromJson(eventJson);
      case ResumingEvent.event:
        return ResumingEvent.fromJson(eventJson);
      case ErrorCallEvent.event:
        return ErrorCallEvent.fromJson(eventJson);
      default:
        throw ArgumentError.value(eventType, "eventType", "Unknown event type");
    }
  }
}
