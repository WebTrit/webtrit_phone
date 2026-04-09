import 'dart:ui' show RootIsolateToken;

import 'package:flutter/services.dart' show BackgroundIsolateBinaryMessenger, BinaryMessenger;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import '../messages.g.dart';
import 'signaling_sync_handler.dart';

final _logger = Logger('SignalingEntryPoint');

/// Step 1 -- Dart callback executed by [FlutterEngineHelper] when the
/// background engine first starts.
///
/// Initialises a binary messenger so that Pigeon platform channels work, then
/// registers the [PSignalingServiceFlutterApi] handler so Kotlin can send
/// [onSynchronize] calls into this isolate.
///
/// The raw handle for this function is stored in [StorageDelegate] and obtained
/// in the main isolate via [PluginUtilities.getCallbackHandle] before calling
/// [PSignalingServiceHostApi.initializeServiceCallback].
@pragma('vm:entry-point')
void signalingServiceCallbackDispatcher() {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;
  PrintAppender(formatter: const ColorFormatter()).attachToLogger(Logger.root);

  _logger.info('signalingServiceCallbackDispatcher: background isolate starting');
  final messenger = _ensureBinaryMessengerInitialized();
  PSignalingServiceFlutterApi.setUp(_SignalingFlutterApiHandler(), binaryMessenger: messenger);
  // Notify Kotlin that the Dart isolate has registered its handler and is ready
  // to receive onSynchronize calls. This resolves the race where Kotlin calls
  // synchronizeIsolate() before the Dart handler is registered
  // (executeDartCallback is async -- the Dart isolate starts after Kotlin has
  // already tried to call onSynchronize).
  PSignalingServiceHostApi(binaryMessenger: messenger).notifyIsolateReady();
  _logger.info('signalingServiceCallbackDispatcher: notifyIsolateReady sent, waiting for onSynchronize');
}

/// Initialises a [BinaryMessenger] for platform channels in this background
/// isolate without touching the full Flutter rendering stack.
///
/// Returns [BackgroundIsolateBinaryMessenger.instance] when
/// [RootIsolateToken.instance] is available (background engine root isolate),
/// avoiding RendererBinding / Impeller / Vulkan initialisation. Falls back to
/// [WidgetsFlutterBinding] and returns `null` (Pigeon uses the binding's
/// default messenger) when the token is unexpectedly absent.
BinaryMessenger? _ensureBinaryMessengerInitialized() {
  final token = RootIsolateToken.instance;
  if (token != null) {
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);
    _logger.info('_ensureBinaryMessengerInitialized: BackgroundIsolateBinaryMessenger initialised');
    return BackgroundIsolateBinaryMessenger.instance;
  } else {
    // Fallback: token is unexpectedly absent. Full binding initialization
    // includes Vulkan/Impeller and may be slow after device inactivity.
    _logger.warning(
      '_ensureBinaryMessengerInitialized: RootIsolateToken unavailable, falling back to WidgetsFlutterBinding',
    );
    WidgetsFlutterBinding.ensureInitialized();
    return null;
  }
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
