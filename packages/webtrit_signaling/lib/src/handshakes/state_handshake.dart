import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import '../events/events.dart';
import '../requests/requests.dart';
import '../responses/responses.dart';
import 'handshake.dart';

final _logger = Logger('StateHandshake');

enum RegistrationStatus {
  registering,
  registered,
  // ignore: constant_identifier_names
  registration_failed,
  unregistering,
  unregistered,
}

class Registration extends Equatable {
  const Registration({required this.status, this.code, this.reason});

  final RegistrationStatus status;
  final int? code;
  final String? reason;

  @override
  List<Object?> get props => [status, code, reason];
}

class Line extends Equatable {
  Line({required this.callId, required this.callLogs});

  final String callId;
  final List<CallLog> callLogs;

  @override
  List<Object?> get props => [callId, callLogs];
}

abstract class CallLog extends Equatable {
  const CallLog({required this.timestamp});

  final int timestamp;

  @override
  List<Object?> get props => [timestamp];
}

class CallRequestLog extends CallLog {
  const CallRequestLog({required super.timestamp, required this.callRequest});

  final CallRequest callRequest;

  @override
  List<Object?> get props => [...super.props, callRequest];
}

class ResponseLog extends CallLog {
  const ResponseLog({required super.timestamp, required this.response});

  final Response response;

  @override
  List<Object?> get props => [...super.props, response];
}

class CallEventLog extends CallLog {
  const CallEventLog({required super.timestamp, required this.callEvent});

  final CallEvent callEvent;

  @override
  List<Object?> get props => [...super.props, callEvent];
}

class StateHandshake extends Handshake {
  const StateHandshake({
    required this.keepaliveInterval,
    required this.timestamp,
    required this.registration,
    required this.lines,
    required this.presenceInfos,
    required this.dialogInfos,
    required this.guestLine,
  }) : super();

  final Duration keepaliveInterval;
  final int timestamp;
  final Registration registration;
  final List<Line?> lines;
  final List<SignalingPresenceInfo> presenceInfos;
  final List<SignalingDialogInfo> dialogInfos;
  final Line? guestLine;

  @override
  List<Object?> get props => [keepaliveInterval, timestamp, registration, lines, presenceInfos, dialogInfos, guestLine];

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
    final lines = linesJson
        .asMap()
        .entries
        .map((e) {
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

          final callLogs = _parseCallLogs(lineJson['call_logs'] as List<dynamic>, line: lineIndex, callId: callId);

          return Line(callId: callId, callLogs: callLogs);
        })
        .toList(growable: false);

    final dialogInfosJson = json['dialog_infos'] as List<dynamic>? ?? [];
    final dialogInfos = dialogInfosJson.map((e) => SignalingDialogInfo.fromJson(e)).toList();

    final presenceInfosJson = json['presence_infos'] as List<dynamic>? ?? [];
    final presenceInfos = presenceInfosJson.map((e) => SignalingPresenceInfo.fromJson(e)).toList();

    final guestLineJson = json['guest_line'];
    Line? guestLine;
    if (guestLineJson != null) {
      final callId = guestLineJson['call_id'] as String?;
      if (callId != null) {
        final callLogs = _parseCallLogs(guestLineJson['call_logs'] as List<dynamic>, line: null, callId: callId);

        guestLine = Line(callId: callId, callLogs: callLogs);
      }
    }

    return StateHandshake(
      keepaliveInterval: keepaliveInterval,
      timestamp: timestamp,
      registration: registration,
      lines: lines,
      presenceInfos: presenceInfos,
      dialogInfos: dialogInfos,
      guestLine: guestLine,
    );
  }
}

/// Parses one line's `call_logs` array into [CallLog] entries, skipping (and
/// logging) any entry this client version cannot parse - most commonly an
/// event type the server added after this client shipped. A single
/// unparseable entry must not fail the whole handshake: [StateHandshake] is
/// replayed on every reconnect, so letting one bad entry throw here would
/// turn into a reconnect loop for as long as the call carrying it stays
/// alive, instead of just losing that one log entry.
List<CallLog> _parseCallLogs(List<dynamic> callLogsJson, {required int? line, required String callId}) {
  final callLogs = <CallLog>[];
  for (final callLogJson in callLogsJson) {
    try {
      final timestamp = callLogJson[0] as int;
      final requestOrResponseOrEventJson = callLogJson[1] as Map<String, dynamic>;
      requestOrResponseOrEventJson['line'] = line; // inject line to apply universal fromJson methods
      requestOrResponseOrEventJson['call_id'] = callId; // inject call_id to apply universal fromJson methods

      if (requestOrResponseOrEventJson.containsKey(Request.typeKey)) {
        callLogs.add(
          CallRequestLog(timestamp: timestamp, callRequest: CallRequest.fromJson(requestOrResponseOrEventJson)),
        );
      } else if (requestOrResponseOrEventJson.containsKey(Response.typeKey)) {
        callLogs.add(ResponseLog(timestamp: timestamp, response: Response.fromJson(requestOrResponseOrEventJson)));
      } else if (requestOrResponseOrEventJson.containsKey(Event.typeKey)) {
        callLogs.add(CallEventLog(timestamp: timestamp, callEvent: CallEvent.fromJson(requestOrResponseOrEventJson)));
      } else {
        throw ArgumentError.value(requestOrResponseOrEventJson, 'requestOrResponseOrEventJson', 'call_log incorrect');
      }
    } catch (error, stackTrace) {
      _logger.warning('_parseCallLogs: skipping unparseable call_log entry for call $callId', error, stackTrace);
    }
  }
  return callLogs;
}
