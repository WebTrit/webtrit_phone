import 'package:equatable/equatable.dart';

import '../requests/requests.dart';
import 'events.dart';

enum RegistrationStatus {
  registering,
  registered,
  registration_failed,
  unregistering,
  unregistered,
}

class RegistrationState extends Equatable {
  const RegistrationState({required this.status, this.code, this.reason});

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

class StateEvent extends Event {
  const StateEvent({
    required this.timestamp,
    required this.registrationState,
    required this.maxActiveCallCount,
    required this.calls,
  }) : super();

  final int timestamp;
  final RegistrationState registrationState;
  final int maxActiveCallCount;
  final Map<String, List<CallLog>> calls;

  @override
  List<Object?> get props => [
        timestamp,
        registrationState,
        maxActiveCallCount,
        calls,
      ];

  static const event = 'state';

  factory StateEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    final registrationStateMessage = json['registration_state'];
    final registrationState = RegistrationState(
      status: RegistrationStatus.values.byName(registrationStateMessage['status']),
      code: registrationStateMessage['code'],
      reason: registrationStateMessage['reason'],
    );
    final maxActiveCallCount = json['max_active_call_count'];
    final callsJson = json['calls'] as Map<String, dynamic>;
    final calls = callsJson.map((callId, callLogsJson) {
      final callLogs = (callLogsJson as List<dynamic>).map<CallLog>((callLogJson) {
        final timestamp = callLogJson[0] as int;
        final requestOrEventJson = callLogJson[1];
        requestOrEventJson['call_id'] = callId; // inject call_id to apply universal fromJson methods
        if (requestOrEventJson.containsKey('request')) {
          return CallRequestLog(timestamp: timestamp, callRequest: _toRequest(requestOrEventJson));
        } else if (requestOrEventJson.containsKey('event')) {
          return CallEventLog(timestamp: timestamp, callEvent: _toEvent(requestOrEventJson));
        } else {
          throw ArgumentError.value(callsJson, "callsJson", "Active calls' logs incorrect");
        }
      }).toList();

      return MapEntry(callId, callLogs);
    });

    return StateEvent(
      timestamp: json['timestamp'],
      registrationState: registrationState,
      maxActiveCallCount: maxActiveCallCount,
      calls: calls,
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
      default:
        throw ArgumentError.value(eventType, "eventType", "Unknown event type");
    }
  }
}
