import 'package:equatable/equatable.dart';

import 'event.dart';

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

enum CallStatus {
  idle,
  incomingcall,
  accepting,
  accepted,
  updatingcall,
}

class LineState extends Equatable {
  const LineState({
    required this.status,
  });

  final CallStatus status;

  @override
  List<Object?> get props => [
        status,
      ];
}

class StateEvent extends Event {
  const StateEvent({
    required this.timestamp,
    required this.registrationState,
    required this.lineStates,
  }) : super();

  final int timestamp;
  final RegistrationState registrationState;
  final List<LineState> lineStates;

  @override
  List<Object?> get props => [
        timestamp,
        registrationState,
        lineStates,
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
    final lineStatesMessage = json['line_states'] as List<dynamic>;
    final lineStates = lineStatesMessage
        .map((lineStateMessage) => LineState(
              status: CallStatus.values.byName(lineStateMessage['status']),
            ))
        .toList();
    return StateEvent(
      timestamp: json['timestamp'],
      registrationState: registrationState,
      lineStates: lineStates,
    );
  }
}
