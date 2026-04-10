import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceAutoRotate {
  static const MethodChannel _methodChannel = MethodChannel('device_auto_rotate');
  static const EventChannel _eventChannel = EventChannel('device_auto_rotate_stream');

  static Future<bool> get isEnabled async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return true;
    }

    try {
      final bool? result = await _methodChannel.invokeMethod<bool>('isAutoRotateEnabled');
      return result ?? true;
    } catch (_) {
      return true;
    }
  }

  static Stream<bool> get stream {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return Stream.value(true).asBroadcastStream();
    }

    return _eventChannel
        .receiveBroadcastStream()
        .map((event) => event as bool)
        // Return `true` (allow rotation) on error as a safe default.
        // If the platform channel fails, allowing rotation lets the OS manage orientation
        // rather than risking an unintended lock into portrait mode.
        .handleError((_) => true);
  }
}
