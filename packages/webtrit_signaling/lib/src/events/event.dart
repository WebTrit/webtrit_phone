import 'package:equatable/equatable.dart';

import 'abstract_events.dart';

abstract class Event extends Equatable {
  const Event();

  static const typeKey = 'event';

  factory Event.fromJson(Map<String, dynamic> json) {
    final event = tryFromJson(json);
    if (event == null) {
      final eventTypeValue = json[Event.typeKey];
      if (eventTypeValue == ErrorEvent.typeValue) {
        throw ArgumentError('Incorrect error event');
      } else {
        throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Unknown event type');
      }
    } else {
      return event;
    }
  }

  static Event? tryFromJson(Map<String, dynamic> json) {
    return SessionEvent.tryFromJson(json);
  }
}
