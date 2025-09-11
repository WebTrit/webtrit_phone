import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:logging/logging.dart';

import '../web_view_container.dart';

final _jsLogger = Logger('JSChannel');

typedef JsonEventHandler = void Function(JsonJsEvent e);

class JsonJsEvent {
  JsonJsEvent({
    required this.event,
    required this.data,
    this.callback,
    this.raw,
  });

  final String event;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? callback;
  final Map<String, dynamic>? raw;

  static JsonJsEvent? fromMessage(JavaScriptMessage msg) {
    try {
      final decoded = jsonDecode(msg.message);
      if (decoded is! Map<String, dynamic>) {
        _jsLogger.warning('Decoded JSON is not an object');
        return null;
      }
      final event = decoded['event'];
      if (event is! String || event.isEmpty) {
        _jsLogger.warning('Missing or invalid "event"');
        return null;
      }
      Map<String, dynamic>? asMapOrNull(dynamic v) => v is Map<String, dynamic> ? v : null;

      return JsonJsEvent(
        event: event,
        data: asMapOrNull(decoded['data']),
        callback: asMapOrNull(decoded['callback']),
        raw: decoded,
      );
    } catch (e, st) {
      _jsLogger.severe('JSON decode error', e, st);
      return null;
    }
  }
}
