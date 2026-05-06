import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

/// iOS implementation of [SignalingServicePlatform].
///
/// Delegates entirely to [WebtritSignalingServiceDirect] — on iOS there is no
/// Foreground Service, so the WebSocket always runs in the calling isolate.
class WebtritSignalingServiceIos extends WebtritSignalingServiceDirect {
  WebtritSignalingServiceIos._();

  @visibleForTesting
  WebtritSignalingServiceIos.forTesting() : this._();

  static WebtritSignalingServiceIos? _instance;

  static void registerWith() {
    _instance ??= WebtritSignalingServiceIos._();
    SignalingServicePlatform.instance = _instance!;
  }
}
