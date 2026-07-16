import 'package:flutter_web_plugins/flutter_web_plugins.dart' show Registrar;

import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

/// Web implementation of [SignalingServicePlatform].
///
/// Delegates entirely to [WebtritSignalingServiceDirect] - on web there is no
/// foreground/background service, so the WebSocket always runs in the main
/// isolate (the same model iOS uses).
class WebtritSignalingServiceWeb extends WebtritSignalingServiceDirect {
  WebtritSignalingServiceWeb._();

  static WebtritSignalingServiceWeb? _instance;

  static void registerWith(Registrar registrar) {
    // Reuse the existing instance on a repeated registration so the registered
    // module factory and the active events controller are not dropped.
    _instance ??= WebtritSignalingServiceWeb._();
    SignalingServicePlatform.instance = _instance!;
  }
}
