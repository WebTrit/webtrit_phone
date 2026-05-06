import 'dart:async';
import 'dart:isolate';
import 'dart:ui' show IsolateNameServer;

import 'package:flutter/foundation.dart' show VoidCallback, protected;
import 'package:logging/logging.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import '../constants.dart';

final _logger = Logger('WebtritSignalingServiceAndroidDirect');

/// Android pushBound implementation of [WebtritSignalingServiceDirect].
///
/// Extends the shared direct-WebSocket base with the Android push-isolate
/// handoff mechanism: the push isolate registers a [ReceivePort] under
/// [kPushHandoffPortName] so the Activity isolate can signal it via
/// [IsolateNameServer] when its own WebSocket connects, allowing the push
/// isolate to complete its lifecycle early without waiting for a timeout.
class WebtritSignalingServiceAndroidDirect extends WebtritSignalingServiceDirect {
  VoidCallback? _handoffCallback;
  ReceivePort? _handoffPort;

  @override
  void setHandoffCallback(VoidCallback callback) {
    _handoffCallback = callback;
  }

  /// Registers the [IsolateNameServer] handoff port when running in the push
  /// isolate ([_handoffCallback] is set). No-op in the Activity isolate.
  @protected
  @override
  Future<void> onBeforeStart(SignalingServiceConfig config) async {
    _cleanupHandoffPort();
    if (_handoffCallback != null) {
      _handoffPort = ReceivePort('push_handoff');
      IsolateNameServer.registerPortWithName(_handoffPort!.sendPort, kPushHandoffPortName);
      _handoffPort!.listen((_) {
        _logger.info('onBeforeStart: handoff signal received from non-push isolate');
        _handoffCallback?.call();
      });
      _logger.info('onBeforeStart: push isolate — handoff port registered');
    }
  }

  /// Sends the handoff signal to the push isolate when this (Activity) isolate
  /// connects. No-op when running in the push isolate itself.
  @protected
  @override
  void onConnected() {
    if (_handoffCallback == null) {
      final port = IsolateNameServer.lookupPortByName(kPushHandoffPortName);
      if (port != null) {
        _logger.info('onConnected: non-push isolate connected — sending handoff signal');
        port.send(null);
      }
    }
  }

  @override
  Future<void> stopService() async {
    _cleanupHandoffPort();
    await super.stopService();
  }

  @override
  Future<void> dispose() async {
    _cleanupHandoffPort();
    await super.dispose();
  }

  void _cleanupHandoffPort() {
    if (_handoffPort != null) {
      IsolateNameServer.removePortNameMapping(kPushHandoffPortName);
      _handoffPort!.close();
      _handoffPort = null;
    }
  }
}
