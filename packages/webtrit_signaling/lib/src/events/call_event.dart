import 'event.dart';

abstract class CallEvent extends Event {
  CallEvent({
    required this.callId,
  }) : super();

  final String callId;

  @override
  List<Object?> get props => [
        callId,
      ];
}
