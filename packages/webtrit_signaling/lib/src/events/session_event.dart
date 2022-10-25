import 'abstract_events.dart';
import 'session/session_events.dart';

abstract class SessionEvent extends Event {
  const SessionEvent({
    this.transaction,
  }) : super();

  final String? transaction;

  @override
  List<Object?> get props => [
        transaction,
      ];

  factory SessionEvent.fromJson(Map<String, dynamic> json) {
    final sessionEvent = tryFromJson(json);
    if (sessionEvent == null) {
      final eventTypeValue = json[Event.typeKey];
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Unknown session event type');
    } else {
      return sessionEvent;
    }
  }

  static SessionEvent? tryFromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    return _sessionEventFromJsonDecoders[eventTypeValue]?.call(json) ?? LineEvent.tryFromJson(json);
  }

  static final Map<String, SessionEvent Function(Map<String, dynamic>)> _sessionEventFromJsonDecoders = {
    RegisteredEvent.typeValue: RegisteredEvent.fromJson,
    RegisteringEvent.typeValue: RegisteringEvent.fromJson,
    RegistrationFailedEvent.typeValue: RegistrationFailedEvent.fromJson,
    UnregisteredEvent.typeValue: UnregisteredEvent.fromJson,
    UnregisteringEvent.typeValue: UnregisteringEvent.fromJson,
  };
}
