import 'dart:async';

import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:logging/logging.dart';

import '../messages.g.dart';
import 'signaling_foreground_isolate_manager.dart';

final _logger = Logger('SignalingEntryPoint');

SignalingForegroundIsolateManager? _manager;

// Serialises concurrent onSynchronize calls so that a rapid stop+start
// sequence cannot interleave _stop() and _start().
Future<void> _pendingSync = Future.value();

// ---------------------------------------------------------------------------
// Background isolate entry points
// ---------------------------------------------------------------------------

/// Step 1 -- Dart callback executed by [FlutterEngineHelper] when the
/// background engine first starts.
///
/// Responsibility: initialise Flutter bindings and register the
/// [PSignalingServiceFlutterApi] handler so Kotlin can send [onSynchronize]
/// calls into this isolate.
///
/// [callbackDispatcherHandle] stored in [StorageDelegate] is the raw handle
/// for THIS function (obtained via [PluginUtilities.getCallbackHandle] in the
/// main isolate before calling [PSignalingServiceHostApi.initializeServiceCallback]).
@pragma('vm:entry-point')
void signalingServiceCallbackDispatcher() {
  _logger.info('signalingServiceCallbackDispatcher: background isolate starting');
  WidgetsFlutterBinding.ensureInitialized();
  PSignalingServiceFlutterApi.setUp(_SignalingFlutterApiHandler());
  // Notify Kotlin that the Dart isolate has registered its PSignalingServiceFlutterApi
  // handler and is now ready to receive onSynchronize calls.
  // This resolves the race where Kotlin calls synchronizeIsolate() before the Dart
  // handler is registered (executeDartCallback is async -- the Dart isolate starts
  // after Kotlin has already tried to call onSynchronize).
  PSignalingServiceHostApi().notifyIsolateReady();
  _logger.info('signalingServiceCallbackDispatcher: notifyIsolateReady sent, waiting for onSynchronize');
}

/// Step 2 -- called by [_SignalingFlutterApiHandler.onSynchronize] (Kotlin ->
/// Dart via Pigeon) whenever the service status changes.
///
/// Re-creates the manager when connection params change so that a token
/// refresh or re-login always starts a fresh connection.
@pragma('vm:entry-point')
Future<void> onSignalingServiceSync(PSignalingServiceStatus status) async {
  _logger.info(
    'onSignalingServiceSync enabled=${status.enabled} tenantId=${status.tenantId} hasIncomingCallHandler=${status.incomingCallHandlerHandle != 0}',
  );
  if (status.enabled) {
    // Re-create manager when credentials change (e.g. after re-login).
    final existing = _manager;
    if (existing != null) {
      final configChanged =
          existing.coreUrl != status.coreUrl ||
          existing.tenantId != status.tenantId ||
          existing.token != status.token ||
          existing.incomingCallHandlerHandle != status.incomingCallHandlerHandle;
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
      incomingCallHandlerHandle: status.incomingCallHandlerHandle,
    );
  }
  await _manager?.handleStatus(enabled: status.enabled);
}

// ---------------------------------------------------------------------------
// PSignalingServiceFlutterApi handler (Kotlin -> Dart bridge)
// ---------------------------------------------------------------------------

class _SignalingFlutterApiHandler extends PSignalingServiceFlutterApi {
  @override
  void onSynchronize(PSignalingServiceStatus status) {
    _logger.fine('onSynchronize received from Kotlin, queuing sync');
    // Chain each call so rapid stop+start sequences are serialised and never
    // interleave _stop() with _start().
    _pendingSync = _pendingSync.then((_) => onSignalingServiceSync(status));
  }
}
