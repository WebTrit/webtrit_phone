part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {
  const RegistrationInitial();
}

class RegistrationInProgress extends RegistrationState {
  RegistrationInProgress();
}

class RegistrationFailure extends RegistrationState {
  final String reason;

  const RegistrationFailure({
    required this.reason,
  });

  @override
  List<Object> get props => [
        reason,
      ];

  @override
  String toString() => 'RegistrationFailure { reason: $reason }';
}
