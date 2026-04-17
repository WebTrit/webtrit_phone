import 'package:logging/logging.dart';

import '../messages.g.dart';
import 'signaling_foreground_isolate_manager.dart';

final _logger = Logger('SignalingSyncHandler');

SignalingForegroundIsolateManager? _manager;

/// Serialises concurrent [onSignalingServiceSync] calls so that a rapid
/// stop+start sequence cannot interleave stop and start operations.
Future<void> pendingSync = Future.value();

/// Called by the [PSignalingServiceFlutterApi] handler whenever Kotlin sends a
/// status update (service enabled/disabled, config changed).
///
/// Re-creates [SignalingForegroundIsolateManager] when connection params change
/// so that a token refresh or re-login always starts a fresh connection.
///
/// Must be annotated with [@pragma('vm:entry-point')] to survive tree-shaking
/// because its handle is resolved at runtime via [PluginUtilities].
@pragma('vm:entry-point')
Future<void> onSignalingServiceSync(PSignalingServiceStatus status) async {
  _logger.info(
    'onSignalingServiceSync enabled=${status.enabled} tenantId=${status.tenantId} '
    'hasIncomingCallHandler=${status.incomingCallHandlerHandle != 0} '
    'hasModuleFactory=${status.moduleFactoryHandle != 0}',
  );
  if (status.enabled) {
    final existing = _manager;
    if (existing != null) {
      // Handles (incomingCallHandlerHandle, moduleFactoryHandle) are runtime
      // metadata — they change when the Activity re-registers them after opening
      // from a push notification but do not affect the live WebSocket session.
      final handlesChanged =
          existing.incomingCallHandlerHandle != status.incomingCallHandlerHandle ||
          existing.moduleFactoryHandle != status.moduleFactoryHandle;

      // Connection params require a new WebSocket session (re-login, token
      // refresh, server change, or mode switch).
      final connectionConfigChanged =
          existing.coreUrl != status.coreUrl ||
          existing.tenantId != status.tenantId ||
          existing.token != status.token ||
          existing.trustedCertificatesJson != status.trustedCertificatesJson ||
          existing.isPushBound != (status.mode == PSignalingServiceMode.pushBound);

      // Invariant: connection params change only on logout/login, which cannot
      // happen while a call is active. WebSocket is never recreated mid-call.
      if (existing.hasActiveCalls) {
        if (handlesChanged) {
          _logger.info('onSignalingServiceSync handles changed during active call — updating in-place');
          existing.updateHandles(
            incomingCallHandlerHandle: status.incomingCallHandlerHandle,
            moduleFactoryHandle: status.moduleFactoryHandle,
          );
        }
        if (connectionConfigChanged) {
          _logConnectionConfigDelta(existing, status);
          _logger.warning('onSignalingServiceSync connection config changed during active call — skipping recreate');
        }
      } else if (handlesChanged && !connectionConfigChanged) {
        _logger.info('onSignalingServiceSync handles changed — updating in-place, no WebSocket restart');
        existing.updateHandles(
          incomingCallHandlerHandle: status.incomingCallHandlerHandle,
          moduleFactoryHandle: status.moduleFactoryHandle,
        );
      } else if (connectionConfigChanged) {
        _logConnectionConfigDelta(existing, status);
        _logger.info('onSignalingServiceSync connection config changed, recreating manager');
        await existing.handleStatus(enabled: false);
        _manager = null;
      }
    }
    if (_manager == null) {
      _logger.info('onSignalingServiceSync creating new SignalingForegroundIsolateManager');
    }
    _manager ??= SignalingForegroundIsolateManager(
      coreUrl: status.coreUrl,
      tenantId: status.tenantId,
      token: status.token,
      trustedCertificatesJson: status.trustedCertificatesJson,
      incomingCallHandlerHandle: status.incomingCallHandlerHandle,
      moduleFactoryHandle: status.moduleFactoryHandle,
      isPushBound: status.mode == PSignalingServiceMode.pushBound,
    );
  }
  await _manager?.handleStatus(enabled: status.enabled);
}

void _logConnectionConfigDelta(SignalingForegroundIsolateManager existing, PSignalingServiceStatus next) {
  if (existing.coreUrl != next.coreUrl) {
    _logger.info('onSignalingServiceSync delta: coreUrl changed');
  }
  if (existing.tenantId != next.tenantId) {
    _logger.info('onSignalingServiceSync delta: tenantId "${existing.tenantId}" -> "${next.tenantId}"');
  }
  if (existing.token != next.token) {
    _logger.info('onSignalingServiceSync delta: token changed');
  }
  if (existing.trustedCertificatesJson != next.trustedCertificatesJson) {
    _logger.info('onSignalingServiceSync delta: trustedCertificatesJson changed');
  }
  if (existing.isPushBound != (next.mode == PSignalingServiceMode.pushBound)) {
    _logger.info(
      'onSignalingServiceSync delta: isPushBound ${existing.isPushBound} -> ${next.mode == PSignalingServiceMode.pushBound}',
    );
  }
}
