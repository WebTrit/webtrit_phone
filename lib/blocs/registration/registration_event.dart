import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationStarted extends RegistrationEvent {
  const RegistrationStarted();
}

class RegistrationProcessed extends RegistrationEvent {
  final String username;

  const RegistrationProcessed({
    required this.username,
  });

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'RegistrationProcessed { username: $username }';
}
