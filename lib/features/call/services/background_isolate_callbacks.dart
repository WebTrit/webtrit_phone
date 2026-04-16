import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

import 'package:webtrit_phone/common/common.dart';

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

const _kPushNotificationSyncTimeout = Duration(seconds: 20);

final _logger = Logger('BackgroundCallIsolate');

// Lazily-initialised isolate-level context.
PushIsolateContext? _context;
PushNotificationIsolateManager? _manager;

/// Returns the isolate-level manager, initialising context and manager on the
/// first call and reusing the same instances on every subsequent call.
///
/// [PushIsolateContext] is kept separate from [PushNotificationIsolateManager]
/// because the manager depends on feature-layer imports that must not be pulled
/// into [lib/common]. Both are torn down together by [_disposeContext].
Future<PushNotificationIsolateManager> _getOrInit() async {
  if (_manager != null) return _manager!;

  _context = await PushIsolateContext.init();
  _manager = PushNotificationIsolateManager(
    callLogsRepository: _context!.callLogsRepository,
    localPushRepository: _context!.localPushRepository,
    callkeep: BackgroundPushNotificationService(),
    storage: _context!.secureStorage,
    certificates: _context!.appCertificates.trustedCertificates,
    logger: Logger('PushNotificationIsolateManager'),
  );
  // init() constructs WebtritSignalingService and wires up the event subscription.
  // Hub discovery and FGS start happen in connect(), which is called from run().
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
Future<void> _disposeContext() async {
  await _manager?.close();
  await _context?.dispose();
  _context = null;
  _manager = null;
}

/// Entry point for the CallKeep push-notification background isolate.
///
/// Runs the full incoming-call lifecycle (signaling, missed-call notification,
/// call log, native release) with a [_kPushNotificationSyncTimeout] timeout,
/// then disposes all resources.
/// Registered via [AndroidCallkeepServices.backgroundPushNotificationBootstrapService.initializeCallback].
///
/// ## Lifecycle and handoff
///
/// The push isolate runs until one of three outcomes:
/// - **Missed call**: [HangupEvent] received before the user answers →
///   `releaseCall()` terminates the [PhoneConnection] and stops [IncomingCallService].
/// - **Answered via push UI**: `performAnswerCall` fires before the timeout →
///   `handoffCall()` stops [IncomingCallService] without terminating the connection,
///   leaving the Activity to adopt the live call.
/// - **Activity took over via full-screen intent**: the Activity subscribes to the
///   [SignalingHub] and shows the incoming-call UI before the push isolate finishes.
///   When the timeout fires the call is still active server-side (no [HangupEvent]
///   received), so `handoffCall()` is used here too — the push isolate only
///   unsubscribes from the hub and stops [IncomingCallService]; the [PhoneConnection]
///   stays alive and the Activity continues handling the call normally.
///
/// ## SignalingForegroundService lifetime after this callback
///
/// When the push isolate unsubscribes and no other subscriber (Activity) is
/// connected, [SignalingForegroundIsolateManager] starts a grace timer
/// (`pushBoundNoSubscriberGrace`, default 10 s). During this window:
/// - If the Activity subscribes within the grace period (normal answer flow),
///   the timer is cancelled and the service keeps running.
/// - If no subscriber arrives (call was declined before the Activity launched),
///   the service stops itself after the grace period expires.
///
/// This means the [SignalingForegroundService] may stay alive for up to
/// [_kPushNotificationSyncTimeout] + `pushBoundNoSubscriberGrace` after a push
/// arrives before self-terminating in the worst case (timeout + no Activity).
@pragma('vm:entry-point')
Future<void> onPushNotificationSyncCallback(CallkeepIncomingCallMetadata? metadata) async {
  try {
    // Initialise context and manager lazily on first push notification.
    final manager = await _getOrInit();
    // Run the full incoming-call lifecycle; guard with a timeout in case it stalls.
    final incomingCallProcessing = manager.run(metadata);
    await incomingCallProcessing.timeout(
      _kPushNotificationSyncTimeout,
      onTimeout: () => _logger.warning('onPushNotificationSyncCallback: timed out callId=${metadata?.callId}'),
    );
  } catch (e) {
    _logger.severe('onPushNotificationSyncCallback: error=$e');
  } finally {
    await _disposeContext();
    try {
      await WebtritSignalingService.restoreService();
    } catch (e, st) {
      _logger.warning('restoreService() after push failed', e, st);
    }
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
      .reportNewIncomingCall(event.callId, CallkeepHandle.number(event.caller), displayName: event.callerDisplayName)
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
