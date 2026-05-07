import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/models/models.dart';

import 'isolate_manager.dart';

export 'package:webtrit_signaling_service/webtrit_signaling_service.dart'
    show
        SignalingModule,
        SignalingModuleEvent,
        SignalingModuleFactory,
        SignalingConnecting,
        SignalingConnected,
        SignalingConnectionFailed,
        SignalingDisconnecting,
        SignalingDisconnected,
        SignalingHandshakeReceived,
        SignalingProtocolEvent;

// When false, push fallback on persistent-session devices is suppressed entirely
// and only logged. Flip to false to isolate FGS recovery behavior during testing.
const _kPersistentPushFallbackEnabled = true;

final _logger = Logger('BackgroundCallIsolate');

// Lazily-initialised isolate-level manager.
PushNotificationIsolateManager? _manager;

/// Returns the isolate-level manager, reusing an existing instance if already
/// initialised. Accepts an already-constructed [PushIsolateContext] so the
/// caller controls when heavy resources (DB, certificates) are opened.
///
/// [PushIsolateContext] is kept separate from [PushNotificationIsolateManager]
/// because the manager depends on feature-layer imports that must not be pulled
/// into [lib/common]. Both are torn down together by [_disposeContext].
Future<PushNotificationIsolateManager> _getOrInit(PushIsolateContext context) async {
  if (_manager != null) return _manager!;

  // The push isolate is a separate Dart VM - it never receives the setModuleFactory()
  // call made in bootstrap.dart (Activity isolate). Register the factory here so
  // _startDirect() can create a SignalingModule when connect() is called from run().
  await WebtritSignalingService.setModuleFactory(createSignalingModule);
  WebtritSignalingService.setHandoffCallback(() => _manager?.notifyActivityTookOver());
  _logger.info('_getOrInit: module factory and handoff callback registered');

  _manager = PushNotificationIsolateManager(
    callLogsRepository: context.callLogsRepository,
    localPushRepository: context.localPushRepository,
    callkeep: BackgroundPushNotificationService(),
    storage: context.secureStorage,
    certificates: context.appCertificates.trustedCertificates,
    logger: Logger('PushNotificationIsolateManager'),
  );
  // init() constructs WebtritSignalingService and wires up the event subscription.
  // The WebSocket connection starts in connect(), which is called from run().
  _logger.info('_getOrInit: initialising signaling module...');
  _manager!.init();
  _logger.info('_getOrInit: init complete');

  return _manager!;
}

/// Closes the manager and releases all isolate-level resources.
///
/// Must be called when [CallkeepPushNotificationSyncStatus.releaseResources]
/// is received so the isolate does not hold open database connections or
/// active signaling sessions after the OS reclaims the background process.
Future<void> _disposeContext(PushIsolateContext context) async {
  await _manager?.close();
  await context.dispose();
  _manager = null;
}

/// Entry point for the CallKeep push-notification background isolate.
///
/// Runs the full incoming-call lifecycle (signaling, missed-call notification,
/// call log, native release), then disposes all resources.
/// Registered via [AndroidCallkeepServices.backgroundPushNotificationBootstrapService.initializeCallback].
///
/// ## Persistent-session devices
///
/// When [IncomingCallType.socket] is selected the FGS owns the persistent WebSocket.
/// A push arriving on such a device means the FGS was frozen or killed by the OEM --
/// the push is a fallback wake-up, not a signal to open a competing WebSocket.
/// Opening a direct WS here would race with the FGS reconnect and trigger a 4441
/// eviction loop. Instead, [restoreService] is called to restart the FGS if it was
/// killed (no-op when it is merely frozen), and the push isolate exits immediately.
///
/// ## pushBound devices - lifecycle and handoff
///
/// The push isolate opens its own WebSocket directly (no FGS). It runs until
/// one of three outcomes:
/// - **Missed call**: [HangupEvent] received before the user answers ->
///   `releaseCall()` terminates the [PhoneConnection] and stops [IncomingCallService].
/// - **Answered via push UI**: `performAnswerCall` fires ->
///   `handoffCall()` stops [IncomingCallService] without terminating the connection,
///   leaving the Activity to adopt the live call.
/// - **Activity took over**: the Activity opens its own WebSocket, the server sends
///   4441 (`controllerForceAttachClose`) to the push isolate, or the plugin detects
///   the Activity via [IsolateNameServer] and calls the handoff callback - whichever
///   arrives first completes the push lifecycle early via `notifyActivityTookOver()`.
@pragma('vm:entry-point')
Future<void> onPushNotificationSyncCallback(CallkeepIncomingCallMetadata? metadata) async {
  PushIsolateContext? context;
  try {
    context = await PushIsolateContext.init();
  } catch (e) {
    _logger.severe('onPushNotificationSyncCallback: context init failed, aborting: $e');
    return;
  }

  final incomingCallType = context.incomingCallTypeRepository.getIncomingCallType();

  if (incomingCallType == IncomingCallType.socket) {
    await context.dispose();
    if (!_kPersistentPushFallbackEnabled) {
      _logger.warning(
        'onPushNotificationSyncCallback: push fallback received on persistent-session device '
        '(callId=${metadata?.callId}) - fallback disabled by flag, skipping FGS recovery',
      );
      return;
    }
    _logger.info(
      'onPushNotificationSyncCallback: push fallback received on persistent-session device '
      '(callId=${metadata?.callId}) - FGS was likely frozen or killed by OEM; '
      'skipping direct WS, attempting FGS recovery via restoreService()',
    );
    try {
      await WebtritSignalingService.restoreService();
    } catch (e, st) {
      _logger.warning('onPushNotificationSyncCallback: restoreService() failed', e, st);
    }
    return;
  }

  // pushBound: run the direct-WS call lifecycle with the already-initialised context.
  // No timeout is applied here — the push isolate owns a direct WebSocket and its
  // lifecycle is driven by natural terminal events (HangupEvent, 4441 eviction, or
  // user answering on this device). The legacy 20-second timeout was an Android FGS
  // background-budget constraint that no longer applies in the pushBound architecture.
  try {
    final manager = await _getOrInit(context);
    await manager.run(metadata);
  } catch (e) {
    _logger.severe('onPushNotificationSyncCallback: error=$e');
  } finally {
    await _disposeContext(context);
  }
}

/// Called by the [WebtritSignalingService] plugin when an incoming call
/// arrives via the persistent foreground-service WebSocket connection.
///
/// Runs inside the foreground-service background isolate. Must be a top-level
/// function annotated with [@pragma('vm:entry-point')] so that [PluginUtilities]
/// can serialise its handle.
///
/// Reports the call to the Android telecom framework via [CallkeepHandle] so
/// the system call UI is shown and the device rings. If reporting fails or
/// times out, the error is logged and the call is silently dropped on the
/// UI layer (the signaling session itself stays active).
@pragma('vm:entry-point')
Future<void> onSignalingBackgroundIncomingCall(IncomingCallEvent event) async {
  _logger.info('onSignalingBackgroundIncomingCall: callId=${event.callId} caller=${event.caller}');

  final error = await AndroidCallkeepServices.backgroundPushNotificationBootstrapService
      .reportNewIncomingCall(
        event.callId,
        CallkeepHandle.number(event.caller),
        displayName: event.callerDisplayName?.isEmpty == true ? null : event.callerDisplayName,
      )
      .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          _logger.severe('onSignalingBackgroundIncomingCall: reportNewIncomingCall timed out callId=${event.callId}');
          return null;
        },
      );

  if (error != null) {
    _logger.warning('onSignalingBackgroundIncomingCall: reportNewIncomingCall error=$error callId=${event.callId}');
  }
}
