import 'event.dart';

class IceHangupEvent extends Event {
  IceHangupEvent({
    this.reason,
  }) : super();

  final String? reason;

  @override
  List<Object?> get props => [
        reason,
      ];
}
