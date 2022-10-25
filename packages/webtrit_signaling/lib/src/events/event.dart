import 'package:equatable/equatable.dart';

import 'abstract_events.dart';

abstract class Event extends Equatable {
  const Event();

  static const typeKey = 'event';

  factory Event.fromJson(Map<String, dynamic> json) {
    final event = tryFromJson(json);
    if (event == null) {
      final eventTypeValue = json[Event.typeKey];
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Unknown event type');
    } else {
      return event;
    }
  }

  static Event? tryFromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    return _eventFromJsonDecoders[eventTypeValue]?.call(json) ?? SessionEvent.tryFromJson(json);
  }

  static final Map<String, Event Function(Map<String, dynamic>)> _eventFromJsonDecoders = {};
}
