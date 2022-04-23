import 'event.dart';

abstract class CallEvent extends Event {
  const CallEvent({
    required this.callId,
  }) : super();

  final String callId;

  @override
  List<Object?> get props => [
        callId,
      ];
}
