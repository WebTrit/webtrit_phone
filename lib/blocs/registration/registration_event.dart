import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationStarted extends RegistrationEvent {
  final String username;

  const RegistrationStarted({
    @required this.username,
  });

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'RegistrationStarted { username: $username }';
}
