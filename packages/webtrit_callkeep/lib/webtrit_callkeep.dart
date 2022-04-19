
import 'dart:async';

import 'package:flutter/services.dart';

class WebtritCallkeep {
  static const MethodChannel _channel = MethodChannel('webtrit_callkeep');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
