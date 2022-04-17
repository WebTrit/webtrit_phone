import 'line_event.dart';

class IceWebrtcUpEvent extends LineEvent {
  const IceWebrtcUpEvent({
    required int line,
  }) : super(line: line);
}
