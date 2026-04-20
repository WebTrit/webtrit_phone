import 'dart:convert';

import 'package:webtrit_phone/models/models.dart';

class QueuedTerminationRequestJsonMapper {
  static String toJson(Map<String, QueuedTerminationRequest> data) => jsonEncode(toMap(data));

  static Map<String, QueuedTerminationRequest> fromJson(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is! Map) return {};
      return fromMap(decoded);
    } catch (_) {
      return {};
    }
  }

  static Map<String, dynamic> toMap(Map<String, QueuedTerminationRequest> data) {
    return data.map((key, value) => MapEntry(key, requestToMap(value)));
  }

  static Map<String, QueuedTerminationRequest> fromMap(Map<dynamic, dynamic> map) {
    final restored = <String, QueuedTerminationRequest>{};
    for (final entry in map.entries) {
      final key = entry.key;
      final value = entry.value;
      if (key is! String || value is! Map) continue;
      final request = requestFromMap(value);
      if (request == null) continue;
      restored[key] = request;
    }
    return restored;
  }

  static Map<String, dynamic> requestToMap(QueuedTerminationRequest data) {
    return {'type': data.type.name, 'callId': data.callId, 'line': data.line};
  }

  static QueuedTerminationRequest? requestFromMap(Map<dynamic, dynamic> map) {
    final callId = map['callId'];
    final typeName = map['type'];
    if (callId is! String || typeName is! String) return null;

    final lineValue = map['line'];
    final int? line = switch (lineValue) {
      int value => value,
      double value => value.toInt(),
      _ => null,
    };

    try {
      final type = QueuedTerminationRequestType.values.byName(typeName);
      return QueuedTerminationRequest(type: type, callId: callId, line: line);
    } catch (_) {
      return null;
    }
  }
}

mixin QueuedTerminationRequestJsonMapperMixin {
  String queuedTerminationRequestsToJson(Map<String, QueuedTerminationRequest> data) {
    return QueuedTerminationRequestJsonMapper.toJson(data);
  }

  Map<String, QueuedTerminationRequest> queuedTerminationRequestsFromJson(String json) {
    return QueuedTerminationRequestJsonMapper.fromJson(json);
  }

  Map<String, dynamic> queuedTerminationRequestsToMap(Map<String, QueuedTerminationRequest> data) {
    return QueuedTerminationRequestJsonMapper.toMap(data);
  }

  Map<String, QueuedTerminationRequest> queuedTerminationRequestsFromMap(Map<dynamic, dynamic> map) {
    return QueuedTerminationRequestJsonMapper.fromMap(map);
  }

  Map<String, dynamic> queuedTerminationRequestToMap(QueuedTerminationRequest data) {
    return QueuedTerminationRequestJsonMapper.requestToMap(data);
  }

  QueuedTerminationRequest? queuedTerminationRequestFromMap(Map<dynamic, dynamic> map) {
    return QueuedTerminationRequestJsonMapper.requestFromMap(map);
  }
}
