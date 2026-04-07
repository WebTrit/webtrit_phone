import '../abstract_events.dart';

sealed class GlobalEvent extends Event {
  const GlobalEvent();

  @override
  List<Object?> get props => [];

  factory GlobalEvent.fromJson(Map<String, dynamic> json) {
    final globalEvent = tryFromJson(json);
    if (globalEvent == null) {
      final eventTypeValue = json[Event.typeKey];
      if (eventTypeValue == ErrorEvent.typeValue) {
        throw ArgumentError('Incorrect error event');
      } else {
        throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Unknown global event type');
      }
    } else {
      return globalEvent;
    }
  }

  static GlobalEvent? tryFromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    return _globalEventFromJsonDecoders[eventTypeValue]?.call(json);
  }

  static final Map<String, GlobalEvent Function(Map<String, dynamic>)> _globalEventFromJsonDecoders = {
    NumberPresenceUpdate.typeValue: NumberPresenceUpdate.fromJson,
    NumberDialogsUpdate.typeValue: NumberDialogsUpdate.fromJson,
  };
}

class NumberPresenceUpdate extends GlobalEvent {
  const NumberPresenceUpdate({required this.number, required this.presenceInfo});

  static const typeValue = 'number_presence_update';
  final String number;
  final List<SignalingPresenceInfo> presenceInfo;

  @override
  List<Object?> get props => [number, presenceInfo];

  @override
  factory NumberPresenceUpdate.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return NumberPresenceUpdate(
      number: json['number'],
      presenceInfo: (json['presence_info'] as List<dynamic>)
          .map((item) => SignalingPresenceInfo.fromJson(item))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    Event.typeKey: typeValue,
    'number': number,
    'presence_info': presenceInfo.map((info) => info.toJson()).toList(),
  };
}

class NumberDialogsUpdate extends GlobalEvent {
  const NumberDialogsUpdate({required this.number, required this.dialogInfos});

  static const typeValue = 'number_dialogs_update';
  final String number;
  final List<SignalingDialogInfo> dialogInfos;

  @override
  List<Object?> get props => [number, dialogInfos];

  @override
  factory NumberDialogsUpdate.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return NumberDialogsUpdate(
      number: json['number'],
      dialogInfos: (json['dialog_infos'] as List<dynamic>).map((item) => SignalingDialogInfo.fromJson(item)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    Event.typeKey: typeValue,
    'number': number,
    'dialog_infos': dialogInfos.map((info) => info.toJson()).toList(),
  };
}
