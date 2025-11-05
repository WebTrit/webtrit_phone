import 'abstract_events.dart';
import 'line/line_events.dart';

abstract class LineEvent extends SessionEvent {
  const LineEvent({
    super.transaction,
    required this.line,
  });

  final int? line;

  @override
  List<Object?> get props => [
        ...super.props,
        line,
      ];

  factory LineEvent.fromJson(Map<String, dynamic> json) {
    final lineRequest = tryFromJson(json);
    if (lineRequest == null) {
      final eventTypeValue = json[Event.typeKey];
      if (eventTypeValue == ErrorEvent.typeValue) {
        throw ArgumentError('Incorrect error event');
      } else {
        throw ArgumentError.value(
            eventTypeValue, Event.typeKey, 'Unknown line event type');
      }
    } else {
      return lineRequest;
    }
  }

  static LineEvent? tryFromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    return _lineEventFromJsonDecoders[eventTypeValue]?.call(json) ??
        CallEvent.tryFromJson(json) ??
        LineErrorEvent.tryFromJson(json);
  }

  static final Map<String, LineEvent Function(Map<String, dynamic>)>
      _lineEventFromJsonDecoders = {
    IceHangupEvent.typeValue: IceHangupEvent.fromJson,
    IceMediaEvent.typeValue: IceMediaEvent.fromJson,
    IceSlowLinkEvent.typeValue: IceSlowLinkEvent.fromJson,
    IceTrickleEvent.typeValue: IceTrickleEvent.fromJson,
    IceWebrtcUpEvent.typeValue: IceWebrtcUpEvent.fromJson,
    TransferEvent.typeValue: TransferEvent.fromJson,
  };
}
