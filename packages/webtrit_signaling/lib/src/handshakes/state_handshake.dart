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
    required super.timestamp,
    required this.callRequest,
  });

  final CallRequest callRequest;

  @override
  List<Object?> get props => [
        ...super.props,
        callRequest,
      ];
}

class ResponseLog extends CallLog {
  const ResponseLog({
    required super.timestamp,
    required this.response,
  });

  final Response response;

  @override
  List<Object?> get props => [
        ...super.props,
        response,
      ];
}

class CallEventLog extends CallLog {
  const CallEventLog({
    required super.timestamp,
    required this.callEvent,
  });

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
    required this.userActiveCalls,
    required this.contactsPresenceInfo,
    required this.guestLine,
  }) : super();

  final Duration keepaliveInterval;
  final int timestamp;
  final Registration registration;
  final List<Line?> lines;
  final List<UserActiveCall> userActiveCalls;
  final Map<String, List<SignalingPresenceInfo>> contactsPresenceInfo;
  final Line? guestLine;

  @override
  List<Object?> get props => [
        keepaliveInterval,
        timestamp,
        registration,
        lines,
        userActiveCalls,
        contactsPresenceInfo,
        guestLine,
      ];

  static const typeValue = 'state';

  factory StateHandshake.fromJson(Map<String, dynamic> json) {
    final handshakeTypeValue = json[Handshake.typeKey];
    if (handshakeTypeValue != typeValue) {
      throw ArgumentError.value(
          handshakeTypeValue, Handshake.typeKey, 'Not equal $typeValue');
    }

    final keepaliveInterval =
        Duration(milliseconds: json['keepalive_interval'] as int);

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

      // The callId is nullable and checked for null because it can be null in certain situations.
      // - When an outgoing call fails during setup or connection, the call_id may not be available, resulting in a null value.
      // - After reopening the app or encountering handshake errors, such as error code 490 with the reason "Error setting ICE locally",
      //   the call_id might be null in the call_logs.
      final callId = lineJson['call_id'] as String?;
      if (callId == null) {
        return null;
      }

      final callLogs =
          (lineJson['call_logs'] as List<dynamic>).map<CallLog>((callLogJson) {
        final timestamp = callLogJson[0] as int;
        final requestOrResponseOrEventJson = callLogJson[1];
        requestOrResponseOrEventJson['line'] =
            lineIndex; // inject line to apply universal fromJson methods
        requestOrResponseOrEventJson['call_id'] =
            callId; // inject call_id to apply universal fromJson methods
        if (requestOrResponseOrEventJson.containsKey(Request.typeKey)) {
          return CallRequestLog(
              timestamp: timestamp,
              callRequest: CallRequest.fromJson(requestOrResponseOrEventJson));
        } else if (requestOrResponseOrEventJson.containsKey(Response.typeKey)) {
          return ResponseLog(
              timestamp: timestamp,
              response: Response.fromJson(requestOrResponseOrEventJson));
        } else if (requestOrResponseOrEventJson.containsKey(Event.typeKey)) {
          return CallEventLog(
              timestamp: timestamp,
              callEvent: CallEvent.fromJson(requestOrResponseOrEventJson));
        } else {
          throw ArgumentError.value(requestOrResponseOrEventJson,
              'requestOrResponseOrEventJson', 'Active call\'s logs incorrect');
        }
      }).toList(growable: false);

      return Line(
        callId: callId,
        callLogs: callLogs,
      );
    }).toList(growable: false);

    final userActiveCallsJson =
        json['user_active_calls'] as List<dynamic>? ?? <dynamic>[];
    final userActiveCalls =
        userActiveCallsJson.map((e) => UserActiveCall.fromJson(e)).toList();

    final contactsPresenceInfoJson =
        json['presence_contacts_info'] as Map<String, dynamic>?;
    final contactsPresenceInfo = contactsPresenceInfoJson?.map((key, value) {
          final presenceInfoList = (value as List<dynamic>)
              .map((e) => SignalingPresenceInfo.fromJson(e))
              .toList();
          return MapEntry(key, presenceInfoList);
        }) ??
        <String, List<SignalingPresenceInfo>>{};

    final guestLineJson = json['guest_line'];
    Line? guestLine;
    if (guestLineJson != null) {
      final callId = guestLineJson['call_id'] as String?;
      if (callId != null) {
        final callLogs = (guestLineJson['call_logs'] as List<dynamic>)
            .map<CallLog>((callLogJson) {
          final timestamp = callLogJson[0] as int;
          final requestOrResponseOrEventJson = callLogJson[1];
          requestOrResponseOrEventJson['line'] =
              null; // inject line to apply universal fromJson methods
          requestOrResponseOrEventJson['call_id'] =
              callId; // inject call_id to apply universal fromJson methods
          if (requestOrResponseOrEventJson.containsKey(Request.typeKey)) {
            return CallRequestLog(
                timestamp: timestamp,
                callRequest:
                    CallRequest.fromJson(requestOrResponseOrEventJson));
          } else if (requestOrResponseOrEventJson
              .containsKey(Response.typeKey)) {
            return ResponseLog(
                timestamp: timestamp,
                response: Response.fromJson(requestOrResponseOrEventJson));
          } else if (requestOrResponseOrEventJson.containsKey(Event.typeKey)) {
            return CallEventLog(
                timestamp: timestamp,
                callEvent: CallEvent.fromJson(requestOrResponseOrEventJson));
          } else {
            throw ArgumentError.value(requestOrResponseOrEventJson,
                'requestOrResponseOrEventJson', 'Guest line\'s logs incorrect');
          }
        }).toList(growable: false);

        guestLine = Line(callId: callId, callLogs: callLogs);
      }
    }

    return StateHandshake(
      keepaliveInterval: keepaliveInterval,
      timestamp: timestamp,
      registration: registration,
      lines: lines,
      userActiveCalls: userActiveCalls,
      contactsPresenceInfo: contactsPresenceInfo,
      guestLine: guestLine,
    );
  }
}
