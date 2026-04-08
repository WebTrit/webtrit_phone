import 'dart:developer' as developer;

import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:logging/logging.dart';

import '../messages.g.dart';
import 'signaling_sync_handler.dart';

final _logger = Logger('SignalingEntryPoint');

/// Step 1 -- Dart callback executed by [FlutterEngineHelper] when the
/// background engine first starts.
///
/// Initialises Flutter bindings and registers the [PSignalingServiceFlutterApi]
/// handler so Kotlin can send [onSignalingServiceSync] calls into this isolate.
///
/// The raw handle for this function is stored in [StorageDelegate] and obtained
/// in the main isolate via [PluginUtilities.getCallbackHandle] before calling
/// [PSignalingServiceHostApi.initializeServiceCallback].
@pragma('vm:entry-point')
void signalingServiceCallbackDispatcher() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    developer.log(
      record.message,
      name: record.loggerName,
      level: record.level.value,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });

  _logger.info('signalingServiceCallbackDispatcher: background isolate starting');
  WidgetsFlutterBinding.ensureInitialized();
  PSignalingServiceFlutterApi.setUp(_SignalingFlutterApiHandler());
  // Notify Kotlin that the Dart isolate has registered its handler and is ready
  // to receive onSynchronize calls. This resolves the race where Kotlin calls
  // synchronizeIsolate() before the Dart handler is registered
  // (executeDartCallback is async -- the Dart isolate starts after Kotlin has
  // already tried to call onSynchronize).
  PSignalingServiceHostApi().notifyIsolateReady();
  _logger.info('signalingServiceCallbackDispatcher: notifyIsolateReady sent, waiting for onSynchronize');
}

/// Kotlin -> Dart Pigeon bridge for the signaling foreground service.
///
/// Receives [onSynchronize] calls from Kotlin and serialises them through
/// [pendingSync] so that rapid stop+start sequences never interleave.
class _SignalingFlutterApiHandler extends PSignalingServiceFlutterApi {
  @override
  void onSynchronize(PSignalingServiceStatus status) {
    _logger.fine('onSynchronize received from Kotlin, queuing sync');
    pendingSync = pendingSync.then((_) => onSignalingServiceSync(status)).catchError((Object e, StackTrace s) {
      _logger.severe('onSignalingServiceSync failed - sync chain kept alive', e, s);
    });
  }
}
