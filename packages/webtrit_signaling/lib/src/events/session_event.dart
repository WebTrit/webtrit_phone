import 'event.dart';

abstract class SessionEvent extends Event {
  const SessionEvent({
    required this.transaction,
  }) : super();

  final String transaction;

  @override
  List<Object?> get props => [
        transaction,
      ];
}
