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
    required this.registrationState,
    required this.lineStates,
  }) : super();

  final RegistrationState registrationState;
  final List<LineState> lineStates;

  @override
  List<Object?> get props => [
        registrationState,
        lineStates,
      ];
}
