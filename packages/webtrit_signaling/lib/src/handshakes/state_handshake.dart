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

  static const typeValue = 'state';

  factory StateHandshake.fromJson(Map<String, dynamic> json) {
    final handshakeTypeValue = json[Handshake.typeKey];
    if (handshakeTypeValue != typeValue) {
      throw ArgumentError.value(handshakeTypeValue, Handshake.typeKey, 'Not equal $typeValue');
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
        if (requestOrResponseOrEventJson.containsKey(Request.typeKey)) {
          return CallRequestLog(timestamp: timestamp, callRequest: CallRequest.fromJson(requestOrResponseOrEventJson));
        } else if (requestOrResponseOrEventJson.containsKey(Response.typeKey)) {
          return ResponseLog(timestamp: timestamp, response: Response.fromJson(requestOrResponseOrEventJson));
        } else if (requestOrResponseOrEventJson.containsKey(Event.typeKey)) {
          return CallEventLog(timestamp: timestamp, callEvent: CallEvent.fromJson(requestOrResponseOrEventJson));
        } else {
          throw ArgumentError.value(
              requestOrResponseOrEventJson, 'requestOrResponseOrEventJson', 'Active call\'s logs incorrect');
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
}
