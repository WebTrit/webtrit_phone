import 'event.dart';

class RegistrationFailedEvent extends Event {
  const RegistrationFailedEvent({
    required this.code,
    required this.reason,
  }) : super();

  final int code;
  final String reason;

  @override
  List<Object?> get props => [
        code,
        reason,
      ];
}
