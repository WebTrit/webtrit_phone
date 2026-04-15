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
    // Re-create manager when credentials or factory handle change (e.g. after re-login).
    final existing = _manager;
    if (existing != null) {
      final configChanged =
          existing.coreUrl != status.coreUrl ||
          existing.tenantId != status.tenantId ||
          existing.token != status.token ||
          existing.trustedCertificatesJson != status.trustedCertificatesJson ||
          existing.incomingCallHandlerHandle != status.incomingCallHandlerHandle ||
          existing.moduleFactoryHandle != status.moduleFactoryHandle ||
          existing.isPushBound != (status.mode == PSignalingServiceMode.pushBound);
      if (configChanged) {
        _logger.info('onSignalingServiceSync config changed, recreating manager');
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
