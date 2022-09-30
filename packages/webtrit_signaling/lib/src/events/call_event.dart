import 'events.dart';

abstract class CallEvent extends LineEvent {
  const CallEvent({
    String? transaction,
    required int line,
    required this.callId,
  }) : super(transaction: transaction, line: line);

  final String callId;

  @override
  List<Object?> get props => [
        ...super.props,
        callId,
      ];

  factory CallEvent.fromJson(Map<String, dynamic> json) {
    final callEvent = tryFromJson(json);
    if (callEvent == null) {
      final eventTypeValue = json[Event.typeKey];
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Unknown call event type');
    } else {
      return callEvent;
    }
  }

  static CallEvent? tryFromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    return _callEventFromJsonDecoders[eventTypeValue]?.call(json);
  }

  static final Map<String, CallEvent Function(Map<String, dynamic>)> _callEventFromJsonDecoders = {
    AcceptedEvent.typeValue: AcceptedEvent.fromJson,
    AcceptingEvent.typeValue: AcceptingEvent.fromJson,
    CallingEvent.typeValue: CallingEvent.fromJson,
    DecliningEvent.typeValue: DecliningEvent.fromJson,
    ErrorCallEvent.typeValue: ErrorCallEvent.fromJson,
    HangingupEvent.typeValue: HangingupEvent.fromJson,
    HangupEvent.typeValue: HangupEvent.fromJson,
    HoldingEvent.typeValue: HoldingEvent.fromJson,
    IncomingCallEvent.typeValue: IncomingCallEvent.fromJson,
    MissedCallEvent.typeValue: MissedCallEvent.fromJson,
    ProceedingEvent.typeValue: ProceedingEvent.fromJson,
    ProgressEvent.typeValue: ProgressEvent.fromJson,
    ResumingEvent.typeValue: ResumingEvent.fromJson,
    RingingEvent.typeValue: RingingEvent.fromJson,
    TransferringEvent.typeValue: TransferringEvent.fromJson,
    UpdatedEvent.typeValue: UpdatedEvent.fromJson,
    UpdatingCallEvent.typeValue: UpdatingCallEvent.fromJson,
    UpdatingEvent.typeValue: UpdatingEvent.fromJson,
  };
}
