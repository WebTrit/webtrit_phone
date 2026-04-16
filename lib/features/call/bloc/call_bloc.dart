import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart' hide Notification;

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:clock/clock.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:async/async.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_phone/mappers/signaling/signaling.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../utils/utils.dart';

export 'package:webtrit_callkeep/webtrit_callkeep.dart' show CallkeepHandle, CallkeepHandleType;

part 'call_bloc.freezed.dart';

part 'call_event.dart';

part 'call_state.dart';

const int _kUndefinedLine = -1;

final _logger = Logger('CallBloc');

/// A callback function type for handling diagnostic reports for call request errors.
/// It takes the [callId] of the failed call and the specific [CallkeepCallRequestError]
/// as parameters, allowing for detailed error logging or reporting.
typedef OnDiagnosticReportRequested = void Function(String callId, CallkeepCallRequestError error);

/// Callback triggered when the signaling session is determined to be invalid
/// (e.g., session revoked remotely, expired, or deleted), requiring a forced
/// application-level logout to resolve the state.
typedef SignalingSessionInvalidatedCallback = void Function();

const _getUserMediaPushKitTimeout = Duration(seconds: 8);

class CallBloc extends Bloc<CallEvent, CallState> with WidgetsBindingObserver implements CallkeepDelegate {
  final CallLogsRepository callLogsRepository;
  final UserRepository userRepository;
  final LinesStateRepository linesStateRepository;
  final PresenceInfoRepository presenceInfoRepository;
  final DialogInfoRepository dialogInfoRepository;
  final PresenceSettingsRepository presenceSettingsRepository;
  final Function(Notification) submitNotification;

  /// Callback invoked when the signaling client reports a critical session error
  /// (e.g. [SignalingDisconnectCode.sessionMissedError]), indicating the
  /// current session is no longer valid on the server.
  final SignalingSessionInvalidatedCallback onSessionInvalidated;

  final Callkeep callkeep;
  final CallkeepConnections callkeepConnections;

  final SDPMunger? sdpMunger;
  final SdpSanitizer? sdpSanitizer;
  final WebrtcOptionsBuilder? webRtcOptionsBuilder;
  final IceFilter? iceFilter;
  final UserMediaBuilder userMediaBuilder;
  final PeerConnectionPolicyApplier? peerConnectionPolicyApplier;
  final ContactNameResolver contactNameResolver;
  final CallErrorReporter callErrorReporter;
  final bool sendPresenceSettings;
  final VoidCallback? onCallEnded;
  final OnDiagnosticReportRequested onDiagnosticReportRequested;

  StreamSubscription<List<ConnectivityResult>>? _connectivityChangedSubscription;
  StreamSubscription<void>? _foregroundCallPushSubscription;

  late final SignalingModule _signalingModule;
  late final StreamSubscription<SignalingModuleEvent> _signalingSubscription;
  late final SignalingReconnectController _reconnectController;
  Timer? _presenceInfoSyncTimer;

  late final PeerConnectionManager _peerConnectionManager;
  final Map<String, RenegotiationHandler> _renegotiationHandlers = {};
  late final HandshakeProcessor _handshakeProcessor;

  final _callkeepSound = WebtritCallkeepSound();

  CallBloc({
    required this.callLogsRepository,
    required this.linesStateRepository,
    required this.presenceInfoRepository,
    required this.dialogInfoRepository,
    required this.presenceSettingsRepository,
    required this.onSessionInvalidated,
    required this.userRepository,
    required this.submitNotification,
    required this.callkeep,
    required this.callkeepConnections,
    required this.userMediaBuilder,
    required this.contactNameResolver,
    required this.callErrorReporter,
    required this.sendPresenceSettings,
    required this.onDiagnosticReportRequested,
    this.sdpMunger,
    this.sdpSanitizer,
    this.webRtcOptionsBuilder,
    this.iceFilter,
    this.peerConnectionPolicyApplier,
    required SignalingModule signalingModule,
    required PeerConnectionManager peerConnectionManager,
    this.onCallEnded,
    Stream<void>? foregroundCallPushSignal,
  }) : super(const CallState()) {
    _signalingModule = signalingModule;
    _peerConnectionManager = peerConnectionManager;
    _handshakeProcessor = HandshakeProcessor(callkeepConnections: callkeepConnections);

    _reconnectController = SignalingReconnectController(
      signalingModule: signalingModule,
      onConnectionFailed: _handleConnectionFailed,
      onConnectionPresenceChanged: (isAvailable) =>
          _logger.info('signaling presence changed: isAvailable=$isAvailable'),
    );

    _foregroundCallPushSubscription = foregroundCallPushSignal?.listen(
      (_) => _reconnectController.notifyForceReconnect(),
    );

    // Translates SignalingModule events into BLoC state-transition events.
    // Reconnect scheduling and notification decisions are fully handled by
    // [_reconnectController] — this listener only drives [CallState] changes.
    _signalingSubscription = _signalingModule.events.listen((event) {
      switch (event) {
        case SignalingConnecting():
          add(const _SignalingClientEvent.connecting());
        case SignalingConnected():
          add(const _SignalingClientEvent.connected());
        case SignalingConnectionFailed(:final error):
          add(_SignalingClientEvent.failed(error));
        case SignalingDisconnecting():
          add(const _SignalingClientEvent.disconnecting());
        case SignalingDisconnected(:final code, :final reason):
          add(_SignalingClientEvent.disconnected(code, reason));
        case SignalingHandshakeReceived(:final handshake):
          _handleHandshakeReceived(handshake);
        case SignalingProtocolEvent(:final event):
          _handleSignalingEvent(event);
      }
    });

    on<CallStarted>(_onCallStarted, transformer: sequential());
    on<_AppLifecycleStateChanged>(_onAppLifecycleStateChanged, transformer: sequential());
    on<_ConnectivityResultChanged>(_onConnectivityResultChanged, transformer: sequential());
    on<_NavigatorMediaDevicesChange>(_onNavigatorMediaDevicesChange, transformer: debounce());
    on<_RegistrationChange>(_onRegistrationChange, transformer: droppable());
    on<_ResetStateEvent>(_onResetStateEvent, transformer: droppable());
    on<_SignalingClientEvent>(_onSignalingClientEvent, transformer: restartable());
    on<_HandshakeSignalingEventState>(_onHandshakeSignalingEventState, transformer: sequential());
    on<_CallSignalingEvent>(_onCallSignalingEvent, transformer: sequential());
    on<_CallPushEventIncoming>(_onCallPushEventIncoming, transformer: sequential());
    on<_RestoreAcceptedCall>(_onRestoreAcceptedCall, transformer: sequential());
    on<CallControlEvent>(
      _onCallControlEvent,
      transformer: (events, mapper) => StreamGroup.merge([
        droppable<CallControlEvent>().call(events.where((e) => e is _CallControlEventStarted), mapper),
        sequential<CallControlEvent>().call(events.where((e) => e is! _CallControlEventStarted), mapper),
      ]),
    );
    on<_CallPerformEvent>(_onCallPerformEvent, transformer: sequential());
    on<_PeerConnectionEvent>(_onPeerConnectionEvent, transformer: sequential());
    on<CallScreenEvent>(_onCallScreenEvent, transformer: sequential());
    on<CallConfigEvent>(_onConfigEvent, transformer: sequential());
    on<_GlobalEvent>(_onGlobalEvent, transformer: sequential());

    navigator.mediaDevices.ondevicechange = (event) {
      add(const _NavigatorMediaDevicesChange());
    };

    WidgetsBinding.instance.addObserver(this);

    callkeep.setDelegate(this);

    if (sendPresenceSettings) {
      _presenceInfoSyncTimer = Timer.periodic(const Duration(seconds: 5), (_) => syncPresenceSettings());
    }
  }

  @override
  Future<void> close() async {
    callkeep.setDelegate(null);

    WidgetsBinding.instance.removeObserver(this);

    navigator.mediaDevices.ondevicechange = null;

    await _connectivityChangedSubscription?.cancel();
    await _foregroundCallPushSubscription?.cancel();

    _reconnectController.dispose();

    _presenceInfoSyncTimer?.cancel();

    await _signalingSubscription.cancel();

    await _stopRingbackSound();

    for (final activeCall in state.activeCalls) {
      await _releaseLocalStream(activeCall.localStream);
    }

    await _peerConnectionManager.dispose();

    _clearRenegotiationHandlers();

    await super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    _logger.warning('onError', error, stackTrace);
    // TODO: analise error and finalize necessary active call
  }

  @override
  void onChange(Change<CallState> change) {
    super.onChange(change);

    // TODO: add detailed explanation of the following code and why it is necessary to initialize signaling client in background
    if (change.currentState.isActive != change.nextState.isActive) {
      final appLifecycleState = change.nextState.currentAppLifecycleState;
      final appInactive =
          appLifecycleState == AppLifecycleState.paused ||
          appLifecycleState == AppLifecycleState.detached ||
          appLifecycleState == AppLifecycleState.inactive;
      final hasActiveCalls = change.nextState.isActive;
      final connected = _signalingModule.isConnected;

      if (appInactive) {
        _reconnectController.notifyHasActiveCalls(hasActiveCalls: hasActiveCalls);
        if (hasActiveCalls && !connected) {
          _reconnectController.notifyForceReconnect();
        }
        if (!hasActiveCalls && connected) {
          _reconnectController.notifyAppPaused(hasActiveCalls: false);
        }
      }
    }

    final currentActiveCallUuids = Set.from(change.currentState.activeCalls.map((e) => e.callId));
    _logger.fine('onChange currentActiveCallUuids: $currentActiveCallUuids');
    final nextActiveCallUuids = Set.from(change.nextState.activeCalls.map((e) => e.callId));
    _logger.fine('onChange nextActiveCallUuids: $nextActiveCallUuids');

    for (final removeUuid in currentActiveCallUuids.difference(nextActiveCallUuids)) {
      _clearRenegotiationHandler(removeUuid);
      // Disposal is intentionally not awaited to avoid blocking the Bloc processing loop.
      // The PeerConnectionManager implements an internal "disposal barrier" (via _pendingDisposals)
      // which guarantees that any subsequent createPeerConnection() for this CallId will
      // automatically wait for this disposal to finish before proceeding.
      _peerConnectionManager.disposePeerConnection(removeUuid).catchError((error, stackTrace) {
        _logger.warning('Error disposing peer connection for $removeUuid', error, stackTrace);
      });
    }

    for (final addUuid in nextActiveCallUuids.difference(currentActiveCallUuids)) {
      _peerConnectionManager.add(addUuid);
    }

    final currentProcessingStatuses = Set.from(
      change.currentState.activeCalls.map((e) => '${e.line}:${e.processingStatus.name}'),
    ).join(', ');
    final nextProcessingStatuses = Set.from(
      change.nextState.activeCalls.map((e) => '${e.line}:${e.processingStatus.name}'),
    ).join(', ');
    if (currentProcessingStatuses != nextProcessingStatuses) {
      _logger.info(() => 'status transitions: $currentProcessingStatuses -> $nextProcessingStatuses');
    }

    /// RegistrationStatus can be null if the signaling state
    /// was not yet fully initialized. In this case, RegistrationStatus was made nullable to indicate that signaling has not been initialized yet.
    ///
    /// This scenario is particularly relevant when a call is triggered before the app
    /// is fully active, such as via [CallkeepDelegate.continueStartCallIntent]
    /// (e.g., from phone recents).

    final newRegistration = change.nextState.callServiceState.registration;
    final previousRegistration = change.currentState.callServiceState.registration;

    if (newRegistration != previousRegistration && newRegistration != null) {
      _logger.fine('_onRegistrationChange: $newRegistration to $previousRegistration');

      final newRegistrationStatus = newRegistration.status;
      final previousRegistrationStatus = previousRegistration?.status;

      if (previousRegistrationStatus?.isRegistered == false && newRegistrationStatus.isRegistered == true) {
        presenceSettingsRepository.resetLastSettingsSync();
        submitNotification(AppOnlineNotification());
      }

      if (previousRegistrationStatus?.isRegistered == true && newRegistrationStatus.isRegistered == false) {
        submitNotification(AppOfflineNotification());
      }

      if (newRegistrationStatus.isFailed == true || newRegistrationStatus.isUnregistered == true) {
        add(const _ResetStateEvent.completeCalls());
      }

      if (newRegistrationStatus.isFailed == true) {
        submitNotification(
          SipRegistrationFailedNotification(
            knownCode: SignalingRegistrationFailedCode.values.byCode(newRegistration.code),
            systemCode: newRegistration.code,
            systemReason: newRegistration.reason,
          ),
        );
      }
    }

    linesStateRepository.setState(change.nextState.toLinesState());
    _handleSignalingSessionError(
      previous: change.currentState.callServiceState,
      current: change.nextState.callServiceState,
    );

    if (change.nextState.activeCalls.length < change.currentState.activeCalls.length) {
      onCallEnded?.call();
    }

    /// Manages global side effects triggered by call lifecycle transitions.
    /// Key responsibility:
    /// - **iOS Audio Reset:** On the start of the *first* call, it forces the
    ///   audio route back to the Receiver (Earpiece). This prevents the "sticky speaker"
    ///   issue where iOS remembers the Speaker output from a previous session.
    _handleCallLifecycleTransitions(
      previousCalls: change.currentState.activeCalls,
      currentCalls: change.nextState.activeCalls,
    );
  }

  /// Analyzes changes in the active call list to trigger specific lifecycle hooks.
  ///
  /// This method identifies keys transitions:
  /// * **First Call Started (`0 -> 1`):** A cold start of the calling session.
  ///     Crucial for initializing hardware resources (e.g., resetting speaker output on iOS).
  /// * **Last Call Ended (`N -> 0`):** The termination of the calling session.
  ///     Used for global cleanup and resource release.
  void _handleCallLifecycleTransitions({
    required List<ActiveCall> previousCalls,
    required List<ActiveCall> currentCalls,
  }) {
    final wasEmpty = previousCalls.isEmpty;
    final isEmpty = currentCalls.isEmpty;

    if (wasEmpty && !isEmpty) {
      _onFirstCallStarted();
    }

    if (!wasEmpty && isEmpty) {
      _onLastCallEnded();
    }
  }

  /// Triggered when the first active call is established (0 -> 1 active calls).
  ///
  /// * **iOS:** Forces the audio output to the Receiver (Earpiece) via `Helper.setSpeakerphoneOn(false)`.
  ///   This is a critical hard-reset to fix the "sticky speaker" issue where iOS
  ///   retains the speaker route from a previous, unrelated session.
  void _onFirstCallStarted() {
    _logger.info(() => 'Lifecycle: First call started');
    if (Platform.isIOS) Helper.setSpeakerphoneOn(false);
  }

  /// Triggered when the last remaining active call ends (N -> 0 active calls).
  ///
  /// Resets platform audio routing to media profile:
  /// * **iOS:** Disables speakerphone to release AVAudioSession from voice chat mode,
  ///   preventing state bleeding between sessions.
  /// * **Android:** Clears communication device to switch from SCO (call profile)
  ///   back to A2DP (media profile), fixing degraded audio in YouTube/music after calls.
  void _onLastCallEnded() {
    _logger.info(() => 'Lifecycle: Last call ended');
    if (Platform.isIOS) Helper.setSpeakerphoneOn(false);
    if (Platform.isAndroid) Helper.clearAndroidCommunicationDevice();
  }

  void _handleConnectionFailed(SignalingFailureInfo failure) {
    final (:knownCode, :systemCode, :systemReason) = failure;
    switch (knownCode) {
      case SignalingDisconnectCode.signalingKeepaliveTimeoutError:
      case SignalingDisconnectCode.controllerForceAttachClose:
        // Expected silent reconnect: keepalive timeout on lock-screen or duplicate-session cleanup.
        _logger.warning('onConnectionFailed: silent reconnect for code=$knownCode');
        return;
      case SignalingDisconnectCode.controllerUnknownError:
        // controllerUnknownError (4400): the server-side Controller process died because
        // the Janus connection went down. The new WebSocket timed out (GenServer.call,
        // 5s default) waiting for the Controller to finish re-initializing (new Janus
        // session + SIP registration). The Controller continues initializing in the
        // background — the next reconnect attempt will succeed once it is ready.
        //
        // Silent reconnect: no user-visible notification needed.
        _logger.warning('onConnectionFailed: silent reconnect for code=$knownCode');
        return;
      default:
        break;
    }
    if (state.isActive) return;
    final notification = switch (knownCode) {
      SignalingDisconnectCode.sessionMissedError => const SignalingSessionMissedNotification(),
      null => const SignalingConnectFailedNotification(),
      _ => SignalingDisconnectNotification(knownCode: knownCode, systemCode: systemCode, systemReason: systemReason),
    };
    submitNotification(notification);
  }

  void _handleSignalingSessionError({required CallServiceState previous, required CallServiceState current}) {
    final signalingChanged =
        previous.signalingClientStatus != current.signalingClientStatus ||
        previous.lastSignalingDisconnectCode != current.lastSignalingDisconnectCode;

    if (!signalingChanged) return;

    if (current.signalingClientStatus == SignalingClientStatus.disconnect &&
        current.lastSignalingDisconnectCode is int) {
      final code = SignalingDisconnectCode.values.byCode(current.lastSignalingDisconnectCode as int);

      if (code == SignalingDisconnectCode.sessionMissedError) {
        _logger.info('Signaling session listener: session is missing ${current.lastSignalingDisconnectCode}');

        unawaited(_notifyAccountErrorSafely());
        onSessionInvalidated();
      }
    }
  }

  // TODO: Consider moving this method to a separate repository
  Future<void> _notifyAccountErrorSafely() async {
    try {
      await userRepository.getRemoteInfo();
    } on RequestFailure catch (e) {
      final errorCode = AccountErrorCode.values.firstWhereOrNull((it) => it.value == e.error?.code);
      _logger.warning('Account error code: $errorCode');

      if (errorCode != null) {
        submitNotification(AccountErrorNotification(errorCode));
      } else {
        _logger.fine('Account error code not mapped: ${e.error?.code}', e);
      }
    } catch (e, st) {
      _logger.warning('Unexpected error during account info refresh', e, st);
    }
  }

  //

  Future<void> _onCallStarted(CallStarted event, Emitter<CallState> emit) async {
    AppleNativeAudioManagement.setUseManualAudio(true);

    // Initialize app lifecycle state
    final lifecycleState = WidgetsFlutterBinding.ensureInitialized().lifecycleState;
    emit(state.copyWith(currentAppLifecycleState: lifecycleState));
    _logger.fine('_onCallStarted initial lifecycle state: $lifecycleState');

    // Initialize connectivity state
    final connectivityState = (await Connectivity().checkConnectivity()).first;
    emit(
      state.copyWith(
        callServiceState: state.callServiceState.copyWith(networkStatus: connectivityState.toNetworkStatus()),
      ),
    );
    _logger.finer('_onCallStarted initial connectivity state: $connectivityState');

    // Subscribe to future connectivity changes
    _connectivityChangedSubscription = Connectivity().onConnectivityChanged.listen((result) {
      final currentConnectivityResult = result.first;
      add(_ConnectivityResultChanged(currentConnectivityResult));
    });

    if (connectivityState == ConnectivityResult.none) {
      _reconnectController.notifyNetworkUnavailable();
    } else {
      _reconnectController.notifyNetworkAvailable();
    }

    WebRTC.initialize(options: webRtcOptionsBuilder?.build());
  }

  Future<void> _onAppLifecycleStateChanged(_AppLifecycleStateChanged event, Emitter<CallState> emit) async {
    final appLifecycleState = event.state;
    _logger.fine('_onAppLifecycleStateChanged: $appLifecycleState');

    emit(state.copyWith(currentAppLifecycleState: appLifecycleState));

    if (appLifecycleState == AppLifecycleState.paused || appLifecycleState == AppLifecycleState.detached) {
      _reconnectController.notifyAppPaused(hasActiveCalls: state.isActive);
    } else if (appLifecycleState == AppLifecycleState.resumed) {
      _reconnectController.notifyAppResumed();
    }
  }

  Future<void> _onConnectivityResultChanged(_ConnectivityResultChanged event, Emitter<CallState> emit) async {
    final connectivityResult = event.result;
    _logger.fine('_onConnectivityResultChanged: $connectivityResult');
    if (connectivityResult == ConnectivityResult.none) {
      _reconnectController.notifyNetworkUnavailable();
    } else {
      _reconnectController.notifyNetworkAvailable();

      // Restart ICE for all active calls to trigger faster recovery from connectivity loss.
      //
      //  - in network loss scenario restarts RTP from almost imediately compating to built-in WebRTC connectivity checks which can take around 10-20 seconds
      //  - in double network scenario (e.g already has mobile network, but also connected to wifi)
      //    it helps to switch to better network instead of staying on old until rtp breaks.
      for (var activeCall in state.activeCalls) {
        _logger.info('_onConnectivityResultChanged: restarting ICE for call ${activeCall.callId} ');
        final pc = await _peerConnectionManager.retrieve(activeCall.callId);
        pc?.restartIce();
      }
    }

    emit(
      state.copyWith(
        callServiceState: state.callServiceState.copyWith(networkStatus: connectivityResult.toNetworkStatus()),
      ),
    );
  }

  Future<void> _onNavigatorMediaDevicesChange(_NavigatorMediaDevicesChange event, Emitter<CallState> emit) async {
    if (Platform.isIOS) {
      // Cleanup devices info if change happened after hangup
      // to avoid presenting stale data on next call initialization
      if (state.activeCalls.isEmpty) return emit(state.copyWith(availableAudioDevices: [], audioDevice: null));

      final devices = await navigator.mediaDevices.enumerateDevices();
      final output = devices.where((d) => d.kind == 'audiooutput').toList();
      final input = devices.where((d) => d.kind == 'audioinput').toList();
      _logger.info('Devices change - out:${output.map((e) => e.str).toList()}, in:${input.map((e) => e.str).toList()}');

      final available = [
        CallAudioDevice(type: CallAudioDeviceType.speaker),
        ...input.map(CallAudioDevice.fromMediaInput),
      ];

      CallAudioDevice current;

      if (output.isNotEmpty) {
        current = CallAudioDevice.fromMediaOutput(output.first);
      } else {
        // Fallback behavior for iOS when out:[]
        // We prioritize the Earpiece (Receiver) if available (derived from MicrophoneBuiltIn),
        // otherwise fallback to the first available device (which is Speaker based on the list above).
        current = available.firstWhere(
          (device) => device.type == CallAudioDeviceType.earpiece,
          orElse: () => available.first,
        );

        _logger.warning(
          'No "audiooutput" devices reported. Fallback selected: ${current.name} (type: ${current.type})',
        );
      }

      emit(state.copyWith(availableAudioDevices: available, audioDevice: current));
    }
  }

  // processing the registration event change

  Future<void> _onRegistrationChange(_RegistrationChange event, Emitter<CallState> emit) async {
    emit(state.copyWith(callServiceState: state.callServiceState.copyWith(registration: event.registration)));
  }

  // processing the handling of the app state
  Future<void> _onResetStateEvent(_ResetStateEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _ResetStateEventCompleteCalls() => __onResetStateEventCompleteCalls(event, emit),
      _ResetStateEventCompleteCall() => __onResetStateEventCompleteCall(event, emit),
    };
  }

  Future<void> __onResetStateEventCompleteCalls(_ResetStateEventCompleteCalls event, Emitter<CallState> emit) async {
    _logger.warning('__onResetStateEventCompleteCalls: ${state.activeCalls}');

    for (var element in state.activeCalls) {
      add(_ResetStateEvent.completeCall(element.callId));
    }
  }

  Future<void> __onResetStateEventCompleteCall(_ResetStateEventCompleteCall event, Emitter<CallState> emit) async {
    _logger.warning('__onResetStateEventCompleteCall: ${event.callId}');

    await _stopRingbackSound();

    try {
      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(processingStatus: CallProcessingStatus.disconnecting);
        }),
      );

      await state.performOnActiveCall(event.callId, (activeCall) async {
        // Dispose the peer connection first. If it was already completed with an error
        // (e.g. UserMediaError in the answer path), disposePeerConnection may throw.
        // Wrap it so that callkeep notification and stream release always run.
        try {
          await _peerConnectionManager.disposePeerConnection(activeCall.callId);
        } catch (e) {
          _logger.warning('__onResetStateEventCompleteCall: disposePeerConnection error $e');
        }

        await callkeep.reportEndCall(
          activeCall.callId,
          activeCall.displayName ?? activeCall.handle.value,
          event.endReason,
        );
        await _releaseLocalStream(activeCall.localStream);
      });
      emit(state.copyWithPopActiveCall(event.callId));
    } catch (e) {
      _logger.warning('__onResetStateEventCompleteCall: $e');
    }
  }

  // processing signaling client events

  Future<void> _onSignalingClientEvent(_SignalingClientEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _SignalingClientEventConnecting() => __onSignalingClientEventConnecting(event, emit),
      _SignalingClientEventConnected() => __onSignalingClientEventConnected(event, emit),
      _SignalingClientEventFailed() => __onSignalingClientEventFailed(event, emit),
      _SignalingClientEventDisconnecting() => __onSignalingClientEventDisconnecting(event, emit),
      _SignalingClientEventDisconnected() => __onSignalingClientEventDisconnected(event, emit),
    };
  }

  Future<void> __onSignalingClientEventConnecting(
    _SignalingClientEventConnecting event,
    Emitter<CallState> emit,
  ) async {
    emit(
      state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.connecting,
          lastSignalingClientConnectError: null,
          lastSignalingClientDisconnectError: null,
          lastSignalingDisconnectCode: null,
        ),
      ),
    );
  }

  Future<void> __onSignalingClientEventConnected(_SignalingClientEventConnected event, Emitter<CallState> emit) async {
    // Renegotiate active calls if there was reconnect
    //
    // Important to do in case if there was connection loss for a while and then webrtc detects network loss and restarts ice e.g
    // user turn off all network interfaces >> __onPeerConnectionEventIceConnectionStateChanged >> RTCIceConnectionStateFailed >> peerConnection.restartIce() >> onRenegotiationNeeded >> _safeRenegotiate >> if(!signalingConnected) return;
    // user turn on network interfaces >> _onSignalingClientEventConnected >> safeRenegotiate
    for (final call in state.activeCalls) {
      // Skip calls that are being torn down — sending UpdateRequest for a
      // disconnecting call would keep the server-side leg alive unnecessarily.
      if (call.processingStatus == CallProcessingStatus.disconnecting) continue;
      _logger.warning('__onSignalingClientEventConnected: triggering safe renegotiation for call ${call.callId}');
      _safeRenegotiate(call.callId, call.line);
    }

    emit(
      state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.connect,
          lastSignalingClientConnectError: null,
          lastSignalingDisconnectCode: null,
        ),
      ),
    );
  }

  Future<void> __onSignalingClientEventFailed(_SignalingClientEventFailed event, Emitter<CallState> emit) async {
    if (emit.isDone) return;
    emit(
      state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.failure,
          lastSignalingClientConnectError: event.error,
        ),
      ),
    );
  }

  Future<void> __onSignalingClientEventDisconnecting(
    _SignalingClientEventDisconnecting event,
    Emitter<CallState> emit,
  ) async {
    emit(
      state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnecting,
          lastSignalingClientConnectError: null,
        ),
      ),
    );
  }

  Future<void> __onSignalingClientEventDisconnected(
    _SignalingClientEventDisconnected event,
    Emitter<CallState> emit,
  ) async {
    final code = SignalingDisconnectCode.values.byCode(event.code ?? -1);

    // Notification decisions are handled by SignalingReconnectController via its
    // onConnectionFailed callback. This method only updates [CallState].

    CallState newState = state.copyWith(
      callServiceState: state.callServiceState.copyWith(
        signalingClientStatus: SignalingClientStatus.disconnect,
        lastSignalingDisconnectCode: event.code,
      ),
    );

    if (code == SignalingDisconnectCode.appUnregisteredError) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.unregistered));
    } else if (code == SignalingDisconnectCode.requestCallIdError) {
      state.activeCalls.where((e) => e.wasHungUp).forEach((e) => add(_ResetStateEvent.completeCall(e.callId)));
    } else if (code == SignalingDisconnectCode.controllerExitError) {
      _logger.info('__onSignalingClientEventDisconnected: skipping expected system unregistration notification');
    } else if (code == SignalingDisconnectCode.signalingKeepaliveTimeoutError) {
      // Keepalive timeout while backgrounded (Android network restrictions).
      // Keep lastSignalingDisconnectCode null so connectIssue is never shown.
      newState = state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnect,
          lastSignalingDisconnectCode: null,
        ),
      );
    } else if (code == SignalingDisconnectCode.controllerForceAttachClose) {
      // Server closed the connection because a duplicate signaling session was detected
      // (e.g. background push isolate still connected when main engine reconnects).
      // Keep lastSignalingDisconnectCode null so connectIssue is never shown.
      _logger.warning(
        '__onSignalingClientEventDisconnected: signaling race detected - '
        'server force-closed duplicate session (code=${event.code}, reason="${event.reason}").',
      );
      newState = state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnect,
          lastSignalingDisconnectCode: null,
        ),
      );
    } else if (code == SignalingDisconnectCode.controllerUnknownError) {
      // Server-side transient state after long inactivity or multi-device reconnect.
      // The subsequent reconnect resolves it; keep lastSignalingDisconnectCode null
      // so connectIssue status is never shown to the user.
      _logger.warning(
        '__onSignalingClientEventDisconnected: transient controllerUnknownError - '
        'silent reconnect (code=${event.code}, reason="${event.reason}").',
      );
      newState = state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnect,
          lastSignalingDisconnectCode: null,
        ),
      );
    } else if (code.type == SignalingDisconnectCodeType.auxiliary) {
      /// Fun facts
      /// - in case of network disconnection on android this section is evaluating faster than [_onConnectivityResultChanged].
      /// - also in case of network disconnection error code is protocolError instead of normalClosure by unknown reason
      /// so we need to handle it here as regular disconnection
      _logger.info('__onSignalingClientEventDisconnected: socket goes down');
    }

    emit(newState);
  }

  // processing call push events

  Future<void> _onCallPushEventIncoming(_CallPushEventIncoming event, Emitter<CallState> emit) async {
    final eventError = event.error;
    if (eventError != null) {
      // iOS only: CXProvider rejected the incoming call registration before it was
      // ever presented to the user (e.g. DND / Focus active, Call Directory blocklist,
      // missing VoIP entitlement, or unexpected CXProvider failure).
      //
      // Consequences:
      // - performEndCall will NOT fire (CallKit never registered the call).
      // - _signalingModule is very likely disconnected: VoIP push wakes the app
      //   before the WebSocket is established, so the CXProvider completion fires
      //   before signaling reconnects.
      //
      // Recovery path: when signaling reconnects the server replays the incoming
      // call event via the handshake. HandshakeProcessor generates a
      // HandleIncomingCallAction for the unknown callId, which re-enters
      // __onCallSignalingEventIncoming. At that point we have the SIP line and
      // can send a DeclineRequest immediately (see that method below).
      _logger.warning(
        '_onCallPushEventIncoming: OS rejected call registration '
        '(callId: ${event.callId}, error: $eventError) — server will be notified on next handshake',
      );
      return;
    }

    final contactName = await contactNameResolver.resolveWithNumber(event.handle.value);
    final displayName = contactName ?? event.displayName;

    // Re-check after the async gap: the signaling path may have created an entry
    // for this callId while contact resolution was in progress.
    if (state.activeCalls.any((c) => c.callId == event.callId)) {
      _logger.fine(
        '_onCallPushEventIncoming: callId ${event.callId} handled during contact resolution - skipping push duplicate',
      );
      return;
    }

    emit(
      state.copyWithPushActiveCall(
        ActiveCall(
          direction: CallDirection.incoming,
          line: _kUndefinedLine,
          callId: event.callId,
          handle: event.handle,
          displayName: displayName,
          video: event.video,
          createdTime: clock.now(),
          processingStatus: CallProcessingStatus.incomingFromPush,
        ),
      ),
    );

    // Replace the display name in Callkeep if it differs from the one in the event
    // mostly needed for ios, coz android can do it on background fcm isolate directly before push
    // TODO:
    // - do it on backend side same as for messaging
    //   currently push notification contain display name from sip header
    if (displayName != event.displayName) {
      await callkeep.reportUpdateCall(event.callId, displayName: displayName);
    }

    // Function to verify speaker availability for the upcoming event, ensuring the speaker button is correctly enabled or disabled
    add(const _NavigatorMediaDevicesChange());

    // the rest logic implemented within _onSignalingStateHandshake on IncomingCallEvent from call logs processing
  }

  // processing handshake signaling events

  Future<void> _onHandshakeSignalingEventState(_HandshakeSignalingEventState event, Emitter<CallState> emit) async {
    emit(state.copyWith(linesCount: event.linesCount));

    add(_RegistrationChange(registration: event.registration));
  }

  // processing call signaling events

  Future<void> _onCallSignalingEvent(_CallSignalingEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallSignalingEventIncoming() => __onCallSignalingEventIncoming(event, emit),
      _CallSignalingEventRinging() => __onCallSignalingEventRinging(event, emit),
      _CallSignalingEventProgress() => __onCallSignalingEventProgress(event, emit),
      _CallSignalingEventAccepted() => __onCallSignalingEventAccepted(event, emit),
      _CallSignalingEventHangup() => __onCallSignalingEventHangup(event, emit),
      _CallSignalingEventUpdating() => __onCallSignalingEventUpdating(event, emit),
      _CallSignalingEventCallUpdating() => __onCallSignalingEventCallUpdating(event, emit),
      _CallSignalingEventUpdated() => __onCallSignalingEventUpdated(event, emit),
      _CallSignalingEventTransfer() => __onCallSignalingEventTransfer(event, emit),
      _CallSignalingEventTransferring() => __onCallSignalingEventTransfering(event, emit),
      _CallSignalingEventNotifyRefer() => __onCallSignalingEventNotifyRefer(event, emit),
      _CallSignalingEventNotifyUnknown() => __onCallSignalingEventNotifyUnknown(event, emit),
      _CallSignalingEventRegistration() => __onCallSignalingEventRegistration(event, emit),
    };
  }

  // processing global events

  Future<void> _onGlobalEvent(_GlobalEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _GlobalEventNumberPresenceUpdate() => __onGlobalEventNumberPresenceUpdate(event, emit),
      _GlobalEventNumberDialogsUpdate() => __onGlobalEventNumberDialogsUpdate(event, emit),
    };
  }

  /// Handles incoming call offer.
  ///
  /// - Creates a new full [ActiveCall] with offer and line.
  /// - Or enriches existing [ActiveCall] with line and offer if
  /// its placed by push [__onCallPushEventIncoming] before the signaling was initialized.
  ///
  /// - continues in  [__onCallControlEventAnswered], [__onCallPerformEventAnswered] or [__onCallControlEventEnded], [__onCallPerformEventEnded]
  ///
  /// Be aware the answering intent can be submitted before the full [ActiveCall].
  /// So the answering method [__onCallPerformEventAnswered] will wait until offer and line is assigned
  /// to the [ActiveCall] by logic below, do not change status in that case.
  Future<void> __onCallSignalingEventIncoming(_CallSignalingEventIncoming event, Emitter<CallState> emit) async {
    _logger.infoPretty(event.jsep?.sdp, tag: '__onCallSignalingEventIncoming');

    final video = event.jsep?.hasVideo ?? false;
    final handle = CallkeepHandle.number(event.caller);
    final contactName = await contactNameResolver.resolveWithNumber(handle.value);
    final displayName = contactName ?? event.callerDisplayName;

    final activeCallWithSameId = state.retrieveActiveCall(event.callId);
    // Skip the "call to myself" check when the existing call was registered via push
    // with an undefined line (_kUndefinedLine). In that case the signaling event carries
    // the real line and should update the call rather than decline it.
    if (activeCallWithSameId != null &&
        activeCallWithSameId.line != _kUndefinedLine &&
        activeCallWithSameId.line != event.line) {
      _logger.info(
        '__onCallSignalingEventIncoming: received incoming call with existing callId but different line - callId: ${event.callId}, probably call to myself or transfer to myself',
      );
      final declineRequest = DeclineRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: event.line,
        callId: event.callId,
      );
      try {
        await _signalingModule.execute(declineRequest);
      } catch (e, s) {
        callErrorReporter.handle(e, s, '__onCallSignalingEventIncoming declineRequest error');
      }
      return;
    }

    // Glare detection: check if there is an active outgoing call with the same caller which is not yet connected or disconnecting.
    // Typical useccase is when two devices with the same account are calling each other at the same time, e.g. by pressing "call" button in recents or notifications.
    final nonConnectedCallWithSameCaller = state.activeCalls
        .where(
          (call) =>
              call.handle.value == event.caller &&
              call.callId != event.callId &&
              call.direction == CallDirection.outgoing &&
              call.processingStatus != CallProcessingStatus.connected &&
              call.processingStatus != CallProcessingStatus.disconnecting,
        )
        .firstOrNull;

    if (nonConnectedCallWithSameCaller != null) {
      // Polite glare resolution: compare call IDs lexicographically so both sides independently
      // reach the same deterministic decision - exactly one device yields.
      // The side whose outgoing callId is lexicographically greater yields: it ends its outgoing
      // call and lets the incoming proceed. The other side declines the incoming and keeps its outgoing.
      final q = [nonConnectedCallWithSameCaller.callId, event.callId]..sort();
      final shouldYield = q.first == event.callId;
      _logger.info(
        '__onCallSignalingEventIncoming: glare detected - nonConnectedCallWithSameCaller.callId: ${nonConnectedCallWithSameCaller.callId}, event.callId: ${event.callId}, shouldYield: $shouldYield',
      );

      if (shouldYield) {
        _logger.info(
          '__onCallSignalingEventIncoming: glare detected - yielding, ending outgoing call '
          '(callId: ${nonConnectedCallWithSameCaller.callId}), letting incoming (${event.callId}) proceed',
        );
        add(CallControlEvent.ended(nonConnectedCallWithSameCaller.callId));
      }
    }

    final error = await callkeep.reportNewIncomingCall(event.callId, handle, displayName: displayName, hasVideo: video);

    // Check if a call instance already exists in the callkeep, which might have been added via push notifications
    // before the signaling was initialized.
    final callAlreadyExists = error == CallkeepIncomingCallError.callIdAlreadyExists;

    // Check if a call instance already exists in the callkeep, which might have been added via push notifications
    // before the signaling  was initialized. Also, check if the call status has been changed to "answered,"
    // indicating it can be triggered by pressing the answer button in the notification.
    final callAlreadyAnswered = error == CallkeepIncomingCallError.callIdAlreadyExistsAndAnswered;

    // Check if a call instance already terminated in the callkeep, which might have been added via push notifications
    // before the signaling  was initialized. Also, check if the call status has been changed to "terminated"
    // indicating it can be triggered by pressing the decline button in the notification or flutter ui.
    final callAlreadyTerminated = error == CallkeepIncomingCallError.callIdAlreadyTerminated;

    if (error != null && !callAlreadyExists && !callAlreadyAnswered && !callAlreadyTerminated) {
      // reportNewIncomingCall rejected the call with an unexpected error:
      //   - Android: callRejectedBySystem — Telecom already has a call in RINGING state
      //     (AOSP behaviour, Android 11+), or the 5 s Telecom confirmation timeout elapsed.
      //   - iOS: unknown / unentitled / internal — rare CXProvider failure on the
      //     signaling-path reportNewIncomingCall (not the VoIP-push path).
      //
      // The call was never presented to the user, so performEndCall will NOT fire.
      // Notify the server immediately so the remote party is not left ringing.
      // _signalingModule.execute returns null when disconnected — the ?. handles that safely.
      _logger.warning(
        '__onCallSignalingEventIncoming: reportNewIncomingCall error=$error '
        '(callId: ${event.callId}, line: ${event.line}) — sending decline',
      );
      await _signalingModule
          .execute(
            DeclineRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: event.line,
              callId: event.callId,
            ),
          )
          ?.catchError((e, s) {
            callErrorReporter.handle(e, s, '__onCallSignalingEventIncoming declineRequest error');
          });
      return;
    }

    final transfer = (event.referredBy != null && event.replaceCallId != null)
        ? InviteToAttendedTransfer(replaceCallId: event.replaceCallId!, referredBy: event.referredBy!)
        : null;

    ActiveCall? activeCall = state.retrieveActiveCall(event.callId);

    if (activeCall != null) {
      activeCall = activeCall.copyWith(
        line: event.line,
        handle: handle,
        displayName: displayName,
        video: video,
        transfer: transfer,
        incomingOffer: event.jsep,
      );
      emit(state.copyWithMappedActiveCall(event.callId, (_) => activeCall!));
    } else {
      activeCall = ActiveCall(
        direction: CallDirection.incoming,
        line: event.line,
        callId: event.callId,
        handle: handle,
        displayName: displayName,
        video: video,
        createdTime: clock.now(),
        transfer: transfer,
        incomingOffer: event.jsep,
        processingStatus: CallProcessingStatus.incomingFromOffer,
      );
      emit(state.copyWithPushActiveCall(activeCall));
    }

    // Ensure to continue processing call if push action(answer, decline) pressed but app was'nt active at this moment
    // typically happens on android from terminated or background state,
    // on ios it produce second call of [__onCallPerformEventAnswered] or [__onCallPerformEventEnded]
    // so make sure to guard it from race conditions
    await Future.delayed(Duration.zero); // Defer execution to avoid exceptions like CallkeepCallRequestError.internal.
    if (callAlreadyAnswered) add(CallControlEvent.answered(event.callId));
    if (callAlreadyTerminated) add(CallControlEvent.ended(event.callId));
  }

  // no early media - play ringtone
  Future<void> __onCallSignalingEventRinging(_CallSignalingEventRinging event, Emitter<CallState> emit) async {
    await _playRingbackSound();

    emit(
      state.copyWithMappedActiveCall(event.callId, (call) {
        return call.copyWith(processingStatus: CallProcessingStatus.outgoingRinging);
      }),
    );
  }

  // early media - set specified session description
  Future<void> __onCallSignalingEventProgress(_CallSignalingEventProgress event, Emitter<CallState> emit) async {
    await _stopRingbackSound();

    final jsep = event.jsep;
    if (jsep != null) {
      final peerConnection = await _peerConnectionManager.retrieve(event.callId);
      if (peerConnection == null) {
        _logger.warning('__onCallSignalingEventProgress: peerConnection is null - most likely some permissions issue');
      } else {
        final remoteDescription = jsep.toDescription();
        sdpSanitizer?.apply(remoteDescription);
        await peerConnection.setRemoteDescription(remoteDescription);
      }
    } else {
      _logger.warning('__onCallSignalingEventProgress: jsep must not be null');
    }
  }

  /// Event fired when the call is accepted by any! user or call update request aplied.
  /// main cases:
  /// as call connected event after [__onCallPerformEventAnswered] or [__onCallPerformEventStarted]
  /// or as acknowledge of [UpdateRequest] with new jsep.
  Future<void> __onCallSignalingEventAccepted(_CallSignalingEventAccepted event, Emitter<CallState> emit) async {
    ActiveCall? call = state.retrieveActiveCall(event.callId);
    if (call == null) return;

    final initialAccept = call.acceptedTime == null;
    final outgoing = call.direction == CallDirection.outgoing;
    final jsep = event.jsep;

    if (initialAccept) {
      call = call.copyWith(processingStatus: CallProcessingStatus.connected, acceptedTime: clock.now());

      if (outgoing) {
        await _stopRingbackSound();
        await callkeep.reportConnectedOutgoingCall(event.callId);
      }
    } else {
      call = call.copyWith(updating: false);
    }

    emit(state.copyWithMappedActiveCall(event.callId, (_) => call!));

    final peerConnection = await _peerConnectionManager.retrieve(event.callId);
    if (jsep != null && peerConnection != null) {
      final remoteDescription = jsep.toDescription();
      sdpSanitizer?.apply(remoteDescription);

      // An accepted event with an answer jsep is only valid when the PC is in
      // have-local-offer state. During a glare race the local offer may have
      // been rolled back in __onCallSignalingEventCallUpdating, leaving the PC in
      // stable. Applying a stale answer in stable throws a wrong-state error,
      // so skip it and rely on libwebrtc re-firing onRenegotiationNeeded once
      // the PC returns to stable.
      final signalingState = peerConnection.signalingState;
      if (remoteDescription.type == 'answer' && signalingState != RTCSignalingState.RTCSignalingStateHaveLocalOffer) {
        _logger.warning(
          '__onCallSignalingEventAccepted: skipping setRemoteDescription(answer) '
          'because signalingState=$signalingState (expected have-local-offer).',
        );
        return;
      }

      _logger.info(
        '__onCallSignalingEventAccepted answer SDP (callId=${event.callId}, initialAccept=$initialAccept):\n'
        '${remoteDescription.sdp}',
      );

      try {
        await peerConnection.setRemoteDescription(remoteDescription);
        final transceivers = await peerConnection.getTransceivers();
        for (final t in transceivers) {
          final dir = await t.getDirection();
          final curDir = await t.getCurrentDirection();
          _logger.info(
            '__onCallSignalingEventAccepted transceiver: mid=${t.mid} '
            'direction=$dir currentDirection=$curDir',
          );
        }
      } on String catch (e) {
        _logger.warning('__onCallSignalingEventAccepted: setRemoteDescription failed ($e)');
      }
    }
  }

  Future<void> __onCallSignalingEventHangup(_CallSignalingEventHangup event, Emitter<CallState> emit) async {
    final code = SignalingResponseCode.values.byCode(event.code);
    final call = state.retrieveActiveCall(event.callId);
    _logger.warning(
      '__onCallSignalingEventHangup callId=${event.callId} '
      'code=${event.code}(${code?.name}) reason="${event.reason}" '
      'direction=${call?.direction.name} status=${call?.processingStatus.name}',
    );

    switch (code) {
      case null:
        break;
      case SignalingResponseCode.declineCall:
        break;
      case SignalingResponseCode.normalUnspecified:
        break;
      case SignalingResponseCode.requestTerminated:
        break;
      case SignalingResponseCode.unauthorizedRequest:
        submitNotification(CallWhileUnregisteredNotification());
      default:
        final signalingHangupException = SignalingHangupFailure(code);
        final defaultErrorNotification = DefaultErrorNotification(signalingHangupException);
        submitNotification(defaultErrorNotification);
    }

    try {
      _stopRingbackSound();

      ActiveCall? call = state.retrieveActiveCall(event.callId);

      if (call != null) {
        CallkeepEndCallReason endReason = CallkeepEndCallReason.remoteEnded;

        if (call.wasHungUp == false) {
          _addToRecents(call.copyWith(hungUpTime: clock.now()));
        }

        if (call.direction == CallDirection.incoming && !call.wasAccepted) {
          if (code == SignalingResponseCode.declineCall) endReason = CallkeepEndCallReason.declinedElsewhere;
          if (code == SignalingResponseCode.requestTerminated) endReason = CallkeepEndCallReason.unanswered;
        }

        // Updated: Delegate disposal to manager.
        // This handles closing the connection and removing the completer.
        await _peerConnectionManager.disposePeerConnection(event.callId);

        await _releaseLocalStream(call.localStream);

        emit(state.copyWithPopActiveCall(event.callId));

        await callkeep.reportEndCall(event.callId, call.displayName ?? call.handle.value, endReason);
      }
    } catch (e) {
      _logger.warning('__onCallSignalingEventHangup: $e');
    }
  }

  Future<void> __onCallSignalingEventCallUpdating(
    _CallSignalingEventCallUpdating event,
    Emitter<CallState> emit,
  ) async {
    final handle = CallkeepHandle.number(event.caller);
    final contactName = await contactNameResolver.resolveWithNumber(handle.value);
    final displayName = contactName ?? event.callerDisplayName;

    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(
          handle: handle,
          displayName: displayName ?? activeCall.displayName,
          video: event.jsep?.hasVideo ?? activeCall.video,
          updating: true,
        );
      }),
    );

    final activeCall = state.retrieveActiveCall(event.callId)!;

    await callkeep.reportUpdateCall(
      event.callId,
      handle: handle,
      displayName: activeCall.displayName,
      hasVideo: activeCall.video,
      proximityEnabled: state.shouldListenToProximity,
    );

    try {
      final jsep = event.jsep;
      if (jsep != null) {
        final remoteDescription = jsep.toDescription();
        sdpSanitizer?.apply(remoteDescription);
        await state.performOnActiveCall(event.callId, (activeCall) async {
          final peerConnection = await _peerConnectionManager.retrieve(event.callId);
          if (peerConnection == null) {
            _logger.warning(
              '__onCallSignalingEventCallUpdating: peerConnection is null - most likely some state issue',
            );
          } else {
            final localStream = activeCall.localStream;
            if (localStream != null) {
              await peerConnectionPolicyApplier?.apply(
                peerConnection,
                hasRemoteVideo: jsep.hasVideo,
                localStream: localStream,
                frontCamera: activeCall.frontCamera,
              );
            }

            // Optimistic pre-check for glare condition. May be stale because
            // flutter_webrtc caches signalingState and updates it only when the
            // onSignalingState callback fires - not when setLocalDescription completes.
            // The try-catch below is the authoritative fallback.
            final signalingState = peerConnection.signalingState;
            if (signalingState == RTCSignalingState.RTCSignalingStateHaveLocalOffer) {
              _logger.warning(
                '__onCallSignalingEventCallUpdating: glare detected via pre-check (signalingState=$signalingState), rolling back local offer',
              );
              await peerConnection.setLocalDescription(RTCSessionDescription('', 'rollback'));
            }

            try {
              await peerConnection.setRemoteDescription(remoteDescription);
            } on String catch (e) {
              if (e.contains('have-local-offer')) {
                // Glare condition: signalingState pre-check was stale (flutter_webrtc
                // caching), setLocalDescription completed on the native side but the
                // Dart-side callback had not yet fired. Roll back and retry.
                _logger.warning(
                  '__onCallSignalingEventCallUpdating: glare detected via catch ($e), rolling back local offer and retrying',
                );
                await peerConnection.setLocalDescription(RTCSessionDescription('', 'rollback'));
                await peerConnection.setRemoteDescription(remoteDescription);
              } else {
                rethrow;
              }
            }
            final localDescription = await peerConnection.createAnswer({});
            sdpMunger?.apply(localDescription);

            // According to RFC 8829 5.6 (https://datatracker.ietf.org/doc/html/rfc8829#section-5.6),
            // localDescription should be set before sending the answer to transition into stable state.
            await peerConnection.setLocalDescription(localDescription);

            await _signalingModule.execute(
              UpdateRequest(
                transaction: WebtritSignalingClient.generateTransactionId(),
                line: activeCall.line,
                callId: activeCall.callId,
                jsep: localDescription.toMap(),
              ),
            );
          }
        });
      }
    } catch (e, s) {
      callErrorReporter.handle(e, s, '__onCallSignalingEventCallUpdating && jsep error:');

      _peerConnectionManager.completeError(event.callId, e);
      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onCallSignalingEventUpdating(_CallSignalingEventUpdating event, Emitter<CallState> emit) async {
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(updating: true);
      }),
    );
  }

  Future<void> __onCallSignalingEventUpdated(_CallSignalingEventUpdated event, Emitter<CallState> emit) async {
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(updating: false);
      }),
    );
  }

  Future<void> __onCallSignalingEventTransfer(_CallSignalingEventTransfer event, Emitter<CallState> emit) async {
    final replaceCallId = event.replaceCallId;
    final referredBy = event.referredBy;
    final referId = event.referId;
    final referTo = event.referTo;

    // If replaceCallId exists, it means that the REFER request for attended transfer
    if (replaceCallId != null && referredBy != null) {
      // Find the active call that is should be replaced
      final callToReplace = state.retrieveActiveCall(replaceCallId);
      if (callToReplace == null) return;

      // Update call with confirmation request state
      final transfer = Transfer.attendedTransferConfirmationRequested(
        referId: referId,
        referTo: referTo,
        referredBy: referredBy,
      );
      final callUpdate = callToReplace.copyWith(transfer: transfer);
      emit(state.copyWithMappedActiveCall(replaceCallId, (_) => callUpdate));
    }
  }

  Future<void> __onCallSignalingEventTransfering(_CallSignalingEventTransferring event, Emitter<CallState> emit) async {
    final call = state.retrieveActiveCall(event.callId);
    if (call == null) return;

    final prev = call.transfer;
    final transfer = Transfer.transfering(
      fromAttendedTransfer: prev is AttendedTransferTransferSubmitted,
      fromBlindTransfer: prev is BlindTransferTransferSubmitted,
    );

    final callUpdate = call.copyWith(transfer: transfer);
    emit(state.copyWithMappedActiveCall(event.callId, (_) => callUpdate));
  }

  Future<void> __onGlobalEventNumberPresenceUpdate(
    _GlobalEventNumberPresenceUpdate event,
    Emitter<CallState> emit,
  ) async {
    _logger.fine('_GlobalEventNumberPresenceUpdate: $event');
    await _assignNumberPresence(event.number, event.presenceInfo);
  }

  Future<void> __onGlobalEventNumberDialogsUpdate(
    _GlobalEventNumberDialogsUpdate event,
    Emitter<CallState> emit,
  ) async {
    _logger.fine('_GlobalEventNumberDialogsUpdate: $event');
    await _assignNumberDialogs(event.number, event.dialogInfos);
  }

  Future<void> __onCallSignalingEventNotifyRefer(_CallSignalingEventNotifyRefer event, Emitter<CallState> emit) async {
    _logger.fine('_CallSignalingEventNotifyRefer: $event');
    if (event.subscriptionState != SubscriptionState.terminated) return;
    if (event.state != ReferNotifyState.ok) return;

    // Verifies if the original call line is currently active in the state
    if (state.activeCalls.any((it) => it.callId == event.callId)) add(CallControlEvent.ended(event.callId));
  }

  Future<void> __onCallSignalingEventNotifyUnknown(
    _CallSignalingEventNotifyUnknown event,
    Emitter<CallState> emit,
  ) async {
    _logger.fine('_CallSignalingEventNotifyUnknown: $event');
  }

  Future<void> __onCallSignalingEventRegistration(
    _CallSignalingEventRegistration event,
    Emitter<CallState> emit,
  ) async {
    final registration = Registration(status: event.status, code: event.code, reason: event.reason);
    add(_RegistrationChange(registration: registration));
  }

  // processing call control events

  Future<void> _onCallControlEvent(CallControlEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallControlEventStarted() => __onCallControlEventStarted(event, emit),
      _CallControlEventAnswered() => __onCallControlEventAnswered(event, emit),
      _CallControlEventEnded() => __onCallControlEventEnded(event, emit),
      _CallControlEventSetHeld() => __onCallControlEventSetHeld(event, emit),
      _CallControlEventSetMuted() => __onCallControlEventSetMuted(event, emit),
      _CallControlEventSentDTMF() => __onCallControlEventSentDTMF(event, emit),
      _CallControlEventCameraSwitched() => _onCallControlEventCameraSwitched(event, emit),
      _CallControlEventCameraEnabled() => _onCallControlEventCameraEnabled(event, emit),
      _CallControlEventAudioDeviceSet() => _onCallControlEventAudioDeviceSet(event, emit),
      _CallControlEventFailureApproved() => _onCallControlEventFailureApproved(event, emit),
      _CallControlEventBlindTransferInitiated() => _onCallControlEventBlindTransferInitiated(event, emit),
      _CallControlEventAttendedTransferInitiated() => _onCallControlEventAttendedTransferInitiated(event, emit),
      _CallControlEventBlindTransferSubmitted() => _onCallControlEventBlindTransferSubmitted(event, emit),
      _CallControlEventAttendedTransferSubmitted() => _onCallControlEventAttendedTransferSubmitted(event, emit),
      _CallControlEventAttendedRequestApproved() => _onCallControlEventAttendedRequestApproved(event, emit),
      _CallControlEventAttendedRequestDeclined() => _onCallControlEventAttendedRequestDeclined(event, emit),
    };
  }

  Future<void> __onCallControlEventStarted(_CallControlEventStarted event, Emitter<CallState> emit) async {
    if (state.callServiceState.registration?.status.isRegistered != true) {
      _logger.info('__onCallControlEventStarted account is not registered');
      submitNotification(CallWhileUnregisteredNotification());
      return;
    }

    int? line;
    if (event.fromNumber != null) {
      line = null;
    } else {
      line = state.retrieveIdleLine();
      if (line == null) {
        _logger.info('__onCallControlEventStarted no idle line');
        submitNotification(const CallUndefinedLineNotification());
        return;
      }
    }

    /// If there is an active call, the call should be put on hold before making a new call.
    /// Or it will be ended automatically by platform (via callkeep:performEndAction).
    await Future.forEach(state.activeCalls, (ActiveCall activeCall) async {
      final shouldHold = activeCall.held == false;
      if (shouldHold) await callkeep.setHeld(activeCall.callId, onHold: true);
    });

    final callId = WebtritSignalingClient.generateCallId();
    final contactName = await contactNameResolver.resolveWithNumber(event.handle.value);
    final displayName = contactName ?? event.displayName;

    final newCall = ActiveCall(
      direction: CallDirection.outgoing,
      line: line,
      callId: callId,
      handle: event.handle,
      displayName: displayName,
      video: event.video,
      createdTime: clock.now(),
      processingStatus: CallProcessingStatus.outgoingCreated,
      fromReplaces: event.replaces,
      fromNumber: event.fromNumber,
    );

    emit(state.copyWithPushActiveCall(newCall).copyWith(minimized: false));

    final callkeepError = await callkeep.startCall(
      callId,
      event.handle,
      displayNameOrContactIdentifier: displayName,
      hasVideo: event.video,
      proximityEnabled: !event.video,
    );

    if (callkeepError != null) {
      if (callkeepError == CallkeepCallRequestError.emergencyNumber) {
        final Uri telLaunchUri = Uri(scheme: 'tel', path: event.handle.value);
        launchUrl(telLaunchUri);
      } else if (callkeepError == CallkeepCallRequestError.selfManagedPhoneAccountNotRegistered) {
        _logger.warning('__onCallControlEventStarted selfManagedPhoneAccountNotRegistered');
        submitNotification(const CallErrorRegisteringSelfManagedPhoneAccountNotification());
      } else {
        _logger.warning('__onCallControlEventStarted callkeepError: $callkeepError');
        onDiagnosticReportRequested(callId, callkeepError);
      }
      emit(state.copyWithPopActiveCall(callId));

      return;
    }
  }

  /// Submitting the answer intent to system when answer button is pressed from app ui
  ///
  /// quick shortcut:
  /// call placed in [__onCallSignalingEventIncoming] or [__onCallPushEventIncoming]
  /// continues in [__onCallPerformEventAnswered]
  Future<void> __onCallControlEventAnswered(_CallControlEventAnswered event, Emitter<CallState> emit) async {
    final call = state.retrieveActiveCall(event.callId);
    if (call == null) return;

    // Prevents event doubling and race conditions
    final canSubmitAnswer = switch (call.processingStatus) {
      CallProcessingStatus.incomingFromPush => true,
      CallProcessingStatus.incomingFromOffer => true,
      _ => false,
    };

    if (canSubmitAnswer == false) {
      _logger.info('__onCallControlEventAnswered: skipping due to stale status: ${call.processingStatus}');
      return;
    }

    emit(
      state.copyWithMappedActiveCall(
        event.callId,
        (call) => call.copyWith(processingStatus: CallProcessingStatus.incomingSubmittedAnswer),
      ),
    );

    final error = await callkeep.answerCall(event.callId);
    if (error != null) _logger.warning('__onCallControlEventAnswered error: $error');
  }

  Future<void> __onCallControlEventEnded(_CallControlEventEnded event, Emitter<CallState> emit) async {
    // Cancel any queued signaling requests for this call immediately.
    // Handles the case where OutgoingCallRequest is still waiting in the queue
    // (no connection yet) — without this, it would be sent on reconnect,
    // causing the callee to see a phantom incoming call, and local cleanup
    // (ringback stop, PeerConnection disposal) would be delayed by the
    // 30-second queue timeout.
    _signalingModule.cancelRequestsByCallId(event.callId);

    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(processingStatus: CallProcessingStatus.disconnecting);
      }),
    );

    final error = await callkeep.endCall(event.callId);
    // Handle the case where the local connection is no longer available,
    // sending the call completion event directly to the signaling.
    if (error == CallkeepCallRequestError.unknownCallUuid) {
      add(_CallPerformEvent.ended(event.callId));
    }
    if (error != null) {
      _logger.warning('__onCallControlEventEnded error: $error');
    }
  }

  Future<void> __onCallControlEventSetHeld(_CallControlEventSetHeld event, Emitter<CallState> emit) async {
    final error = await callkeep.setHeld(event.callId, onHold: event.onHold);
    if (error != null) {
      _logger.warning('__onCallControlEventSetHeld error: $error');
    }
  }

  Future<void> __onCallControlEventSetMuted(_CallControlEventSetMuted event, Emitter<CallState> emit) async {
    final error = await callkeep.setMuted(event.callId, muted: event.muted);
    if (error != null) {
      _logger.warning('__onCallControlEventSetMuted error: $error');
    }
  }

  Future<void> __onCallControlEventSentDTMF(_CallControlEventSentDTMF event, Emitter<CallState> emit) async {
    final error = await callkeep.sendDTMF(event.callId, event.key);
    if (error != null) {
      _logger.warning('__onCallControlEventSentDTMF error: $error');
    }
  }

  Future<void> _onCallControlEventCameraSwitched(_CallControlEventCameraSwitched event, Emitter<CallState> emit) async {
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(frontCamera: null);
      }),
    );
    final frontCamera = await state.performOnActiveCall(event.callId, (activeCall) {
      final videoTrack = activeCall.localStream?.getVideoTracks()[0];
      if (videoTrack != null) {
        return Helper.switchCamera(videoTrack);
      }
    });
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(frontCamera: frontCamera);
      }),
    );
  }

  /// Enables or disables the camera for the active call, using local track enable state.
  ///
  /// If its audiocall, try to upgrade to videocal using renegotiation
  /// by adding the tracks to the peer connection.
  /// after success [_createPeerConnection].onRenegotiationNeeded will fired accordingly to webrtc state
  /// then [__onCallSignalingEventAccepted] will be called as acknowledge of [UpdateRequest] with new remote jsep.
  ///
  /// **Mute Implementation Note:**
  /// Currently, this method implements a **"Soft Mute"** strategy by toggling
  /// [MediaStreamTrack.enabled] instead of a **"Hard Mute"** (changing
  /// [RTCRtpTransceiver] direction to [TransceiverDirection.RecvOnly]).
  ///
  /// **Reason:** It was observed that switching to `RecvOnly` causes the server
  /// to stop sending the *incoming* video stream to the client.
  /// This behavior suggests that the server infrastructure might interpret the cessation
  /// of outgoing RTP packets as a connection timeout or does not correctly handle
  /// the session modification in the current configuration. "Soft Mute" avoids this
  /// by keeping the channel active (sending black/empty frames).
  Future<void> _onCallControlEventCameraEnabled(_CallControlEventCameraEnabled event, Emitter<CallState> emit) async {
    final activeCall = state.retrieveActiveCall(event.callId);
    if (activeCall == null) return;

    final localStream = activeCall.localStream;
    if (localStream == null) return;

    final currentVideoTrack = localStream.getVideoTracks().firstOrNull;
    if (currentVideoTrack != null) {
      currentVideoTrack.enabled = event.enabled;
      emit(state.copyWithMappedActiveCall(event.callId, (call) => call.copyWith(video: event.enabled)));
      return;
    }

    if (activeCall.held == true) return;

    final peerConnection = await _peerConnectionManager.retrieve(event.callId);
    if (peerConnection == null) return;

    try {
      final newVideoTrack = await userMediaBuilder.ensureVideoTrack(localStream, frontCamera: activeCall.frontCamera);
      if (newVideoTrack == null) {
        submitNotification(const CallUserMediaErrorNotification());
        return;
      }

      final senders = await peerConnection.getSenders();
      final videoSender = senders.firstWhereOrNull((s) => s.track?.kind == 'video');

      if (videoSender != null) {
        await videoSender.replaceTrack(newVideoTrack);
      } else {
        final videoSenderResult = await peerConnection.safeAddTrack(newVideoTrack, localStream);
        _checkSenderResult(videoSenderResult, 'video');
      }

      emit(state.copyWithMappedActiveCall(event.callId, (call) => call.copyWith(video: true)));

      await callkeep.reportUpdateCall(event.callId, hasVideo: true);
    } on UserMediaError catch (e) {
      _logger.warning('_onCallControlEventCameraEnabled cant enable: $e');
      submitNotification(const CallUserMediaErrorNotification());
    }
  }

  Future<void> _onCallControlEventAudioDeviceSet(_CallControlEventAudioDeviceSet event, Emitter<CallState> emit) async {
    await state.performOnActiveCall(event.callId, (activeCall) async {
      if (Platform.isAndroid) {
        callkeep.setAudioDevice(event.callId, event.device.toCallkeep());
      } else if (Platform.isIOS) {
        if (event.device.type == CallAudioDeviceType.speaker) {
          Helper.setSpeakerphoneOn(true);
        } else {
          Helper.setSpeakerphoneOn(false);
          final deviceId = event.device.id;
          if (deviceId != null) Helper.selectAudioInput(deviceId);
        }
      }
    });
  }

  Future<void> _onCallControlEventFailureApproved(
    _CallControlEventFailureApproved event,
    Emitter<CallState> emit,
  ) async {
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(failure: null);
      }),
    );
  }

  Future<void> _onCallControlEventBlindTransferInitiated(
    _CallControlEventBlindTransferInitiated event,
    Emitter<CallState> emit,
  ) async {
    final isSpeakerOn = state.audioDevice?.type == CallAudioDeviceType.speaker;

    var newState = state.copyWith(minimized: true);

    await __onCallControlEventSetHeld(_CallControlEventSetHeld(event.callId, true), emit);

    newState = newState.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(
        transfer: const Transfer.blindTransferInitiated(),
        speakerOnBeforeMinimize: isSpeakerOn,
      );
    });

    emit(newState);

    await callkeep.reportUpdateCall(state.activeCalls.current.callId, proximityEnabled: state.shouldListenToProximity);
  }

  Future<void> _onCallControlEventAttendedTransferInitiated(
    _CallControlEventAttendedTransferInitiated event,
    Emitter<CallState> emit,
  ) async {
    final isSpeakerOn = state.audioDevice?.type == CallAudioDeviceType.speaker;

    var newState = state.copyWith(minimized: true);

    newState = newState.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(speakerOnBeforeMinimize: isSpeakerOn);
    });

    emit(newState);

    await __onCallControlEventSetHeld(_CallControlEventSetHeld(event.callId, true), emit);
  }

  Future<void> _onCallControlEventBlindTransferSubmitted(
    _CallControlEventBlindTransferSubmitted event,
    Emitter<CallState> emit,
  ) async {
    final activeCallBlindTransferInitiated = state.activeCalls.blindTransferInitiated;
    final currentCall = state.activeCalls.current;

    final line = activeCallBlindTransferInitiated?.line ?? currentCall.line;
    final callId = activeCallBlindTransferInitiated?.callId ?? currentCall.callId;

    // Commented out to emphasize that the check is disabled by intention
    // to not add it again in future, to see why open ticket [WT-1160]
    // final isNumberAlreadyConnected = state.activeCalls.any((call) => call.handle.value == event.number);
    // if (isNumberAlreadyConnected) {
    //   submitNotification(ActiveLineBlindTransferWarningNotification());
    //   return;
    // }

    try {
      final transferRequest = TransferRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: line,
        callId: callId,
        number: event.number,
      );

      await _signalingModule.execute(transferRequest);

      var newState = state.copyWith(minimized: false);
      newState = newState.copyWithMappedActiveCall(callId, (activeCall) {
        final transfer = Transfer.blindTransferTransferSubmitted(toNumber: event.number);
        return activeCall.copyWith(transfer: transfer);
      });
      emit(newState);

      await callkeep.reportUpdateCall(
        state.activeCalls.current.callId,
        proximityEnabled: state.shouldListenToProximity,
      );

      final callBeingTransferred = state.retrieveActiveCall(callId);

      if (callBeingTransferred?.speakerOnBeforeMinimize == true) {
        final speakerDevice = state.availableAudioDevices.getSpeaker;
        if (speakerDevice != null) {
          add(CallControlEvent.audioDeviceSet(callId, speakerDevice));
        } else {
          _logger.warning(
            '_onCallControlEventBlindTransferSubmitted: speaker was on before minimize but its not available now',
          );
        }
      }

      // After request succesfully submitted, transfer flow will continue
      // by TransferringEvent event from anus and handled in [_CallSignalingEventTransferring]
      // that means that call transfering is now in progress
    } on NotConnectedException {
      _logger.warning('_onCallControlEventBlindTransferSubmitted: not connected, rollback and survive');
      emit(state.copyWithMappedActiveCall(callId, (activeCall) => activeCall.copyWith(transfer: null)));
    } on WebtritSignalingTransactionTimeoutException {
      _logger.warning('_onCallControlEventBlindTransferSubmitted: transaction timeout, rollback and survive');
      emit(state.copyWithMappedActiveCall(callId, (activeCall) => activeCall.copyWith(transfer: null)));
    } catch (e, s) {
      callErrorReporter.handle(e, s, '_onCallControlEventBlindTransferSubmitted request error:');
    }
  }

  Future<void> _onCallControlEventAttendedTransferSubmitted(
    _CallControlEventAttendedTransferSubmitted event,
    Emitter<CallState> emit,
  ) async {
    final referorCall = event.referorCall;
    final replaceCall = event.replaceCall;

    try {
      final transferRequest = TransferRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: referorCall.line,
        callId: referorCall.callId,
        number: replaceCall.handle.normalizedValue(),
        replaceCallId: replaceCall.callId,
      );

      await _signalingModule.execute(transferRequest);

      emit(
        state.copyWithMappedActiveCall(referorCall.callId, (activeCall) {
          final transfer = Transfer.attendedTransferTransferSubmitted(replaceCallId: replaceCall.callId);
          return activeCall.copyWith(transfer: transfer);
        }),
      );

      // After request succesfully submitted, transfer flow will continue
      // by TransferringEvent event from anus and handled in [_CallSignalingEventTransferring]
      // that means that call transfering is now in progress
    } on NotConnectedException {
      _logger.warning('_onCallControlEventAttendedTransferSubmitted: not connected, rollback and survive');
      emit(state.copyWithMappedActiveCall(referorCall.callId, (activeCall) => activeCall.copyWith(transfer: null)));
    } on WebtritSignalingTransactionTimeoutException {
      _logger.warning('_onCallControlEventAttendedTransferSubmitted: transaction timeout, rollback and survive');
      emit(state.copyWithMappedActiveCall(referorCall.callId, (activeCall) => activeCall.copyWith(transfer: null)));
    } catch (e, s) {
      callErrorReporter.handle(e, s, '_onCallControlEventAttendedTransferSubmitted request error:');
    }
  }

  Future<void> _onCallControlEventAttendedRequestApproved(
    _CallControlEventAttendedRequestApproved event,
    Emitter<CallState> emit,
  ) async {
    final referId = event.referId;
    final referTo = event.referTo;

    final newHandle = CallkeepHandle.number(referTo);

    final callId = WebtritSignalingClient.generateCallId();

    final error = await callkeep.startCall(callId, newHandle, hasVideo: false, proximityEnabled: true);

    if (error != null) {
      _logger.warning('__onCallControlEventStarted error: $error');
      submitNotification(ErrorMessageNotification(error.toString()));
      return;
    }

    final newCall = ActiveCall(
      direction: CallDirection.outgoing,
      line: state.retrieveIdleLine() ?? _kUndefinedLine,
      callId: callId,
      handle: newHandle,
      fromReferId: referId,
      video: false,
      createdTime: clock.now(),
      processingStatus: CallProcessingStatus.outgoingCreatedFromRefer,
    );

    emit(state.copyWithPushActiveCall(newCall).copyWith(minimized: false));
  }

  Future<void> _onCallControlEventAttendedRequestDeclined(
    _CallControlEventAttendedRequestDeclined event,
    Emitter<CallState> emit,
  ) async {
    final referId = event.referId;
    final callId = event.callId;

    final call = state.retrieveActiveCall(callId);
    if (call == null) return;

    try {
      final declineRequest = DeclineRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: call.line,
        callId: callId,
        referId: referId,
      );

      await _signalingModule.execute(declineRequest);

      emit(
        state.copyWithMappedActiveCall(callId, (activeCall) {
          return activeCall.copyWith(transfer: null);
        }),
      );
    } catch (e, s) {
      callErrorReporter.handle(e, s, '_onCallControlEventAttendedRequestDeclined request error:');
    }
  }

  // processing call perform events

  /// Returns true when [__onCallPerformEventStarted] should stop waiting for
  /// signaling readiness.
  ///
  /// Exits as soon as both the handshake and signaling are established, or when
  /// the call leaves [CallProcessingStatus.outgoingConnectingToSignaling] — for
  /// example because the user pressed hangup (status → disconnecting) or
  /// another code path removed the call entirely.
  bool _shouldExitOutgoingSignalingWait(CallState next, String callId) {
    if (next.isHandshakeEstablished && next.isSignalingEstablished) return true;
    final call = next.retrieveActiveCall(callId);
    return call == null || call.processingStatus != CallProcessingStatus.outgoingConnectingToSignaling;
  }

  Future<void> _onCallPerformEvent(_CallPerformEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallPerformEventStarted() => __onCallPerformEventStarted(event, emit),
      _CallPerformEventAnswered() => __onCallPerformEventAnswered(event, emit),
      _CallPerformEventEnded() => __onCallPerformEventEnded(event, emit),
      _CallPerformEventSetHeld() => __onCallPerformEventSetHeld(event, emit),
      _CallPerformEventSetMuted() => __onCallPerformEventSetMuted(event, emit),
      _CallPerformEventSentDTMF() => __onCallPerformEventSentDTMF(event, emit),
      _CallPerformEventAudioDeviceSet() => __onCallPerformEventAudioDeviceSet(event, emit),
      _CallPerformEventAudioDevicesUpdate() => __onCallPerformEventAudioDevicesUpdate(event, emit),
    };
  }

  Future<void> __onCallPerformEventStarted(_CallPerformEventStarted event, Emitter<CallState> emit) async {
    if (await state.performOnActiveCall(event.callId, (activeCall) => activeCall.line != _kUndefinedLine) != true) {
      event.fail();

      emit(state.copyWithPopActiveCall(event.callId));

      submitNotification(const CallUndefinedLineNotification());
      return;
    }

    // Guard: skip standard outgoing flow for calls restored via _onRestoreAcceptedCall.
    // Telecom fires performStartCall after startCall() regardless, but the call is already
    // set up - only reportConnectedOutgoingCall is needed to advance Telecom to ACTIVE state.
    final restoredCall = state.retrieveActiveCall(event.callId);
    final canPerformStart = switch (restoredCall?.processingStatus) {
      CallProcessingStatus.outgoingCreated => true,
      CallProcessingStatus.outgoingCreatedFromRefer => true,
      CallProcessingStatus.outgoingConnectingToSignaling => true,
      _ => false,
    };
    if (!canPerformStart) {
      _logger.info('__onCallPerformEventStarted: skipping due to stale status: ${restoredCall?.processingStatus}');
      await callkeep.reportConnectedOutgoingCall(event.callId);
      event.fulfill();
      return;
    } else {
      _logger.info('__onCallPerformEventStarted: proceeding with status: ${restoredCall?.processingStatus}');
    }

    ///
    /// Ensuring that the signaling client is connected before attempting to make an outgoing call
    ///

    var currentState = state;

    // Attempt to wait for signaling+handshake readiness within kOutgoingCallSignalingWaitTimeout.
    if (!currentState.isHandshakeEstablished || !currentState.isSignalingEstablished) {
      // Trigger reconnect so that an outgoing call recovers signaling even when the previous
      // disconnect was intentional (e.g. post-transfer cleanup) and no reconnect was scheduled.
      _reconnectController.notifyForceReconnect();

      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingConnectingToSignaling);
        }),
      );

      currentState = await stream
          .firstWhere((next) => _shouldExitOutgoingSignalingWait(next, event.callId), orElse: () => state)
          .timeout(kOutgoingCallSignalingWaitTimeout, onTimeout: () => state);
      if (isClosed) return;
    }

    // If the signaling client is not connected, decide how to clean up.
    if (!currentState.isSignalingEstablished) {
      event.fail();

      // If the call is no longer in outgoingConnectingToSignaling the hangup flow
      // has already taken over — avoid double-ending or showing a wrong notification.
      final waitingCall = state.retrieveActiveCall(event.callId);
      if (waitingCall?.processingStatus != CallProcessingStatus.outgoingConnectingToSignaling) {
        return;
      }

      // Notice that the tube was already hung up to avoid sending an extra event to the server
      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(hungUpTime: clock.now());
        }),
      );

      // Remove local connection
      callkeep.endCall(event.callId);

      submitNotification(const CallWhileOfflineNotification());
      return;
    }

    // If registration status is not registered after signaling is established, notify user
    if (currentState.callServiceState.registration?.status.isRegistered != true) {
      _logger.info('__onCallPerformEventStarted account is not registered');
      submitNotification(CallWhileUnregisteredNotification());

      event.fail();
      return;
    }

    ///
    /// Initializing media streams
    ///
    ///
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingInitializingMedia);
      }),
    );

    late final MediaStream localStream;
    try {
      localStream = await userMediaBuilder.build(
        video: event.video,
        frontCamera: state.retrieveActiveCall(event.callId)?.frontCamera,
      );
      event.fulfill();

      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(localStream: localStream);
        }),
      );
    } catch (e, stackTrace) {
      _logger.warning('__onCallPerformEventStarted _getUserMedia', e, stackTrace);

      event.fail();

      _peerConnectionManager.completeError(event.callId, e, stackTrace);

      emit(state.copyWithPopActiveCall(event.callId));

      submitNotification(const CallUserMediaErrorNotification());
      return;
    }

    ///
    /// Initializing peer connection and sending outgoing offer
    ///
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingOfferPreparing);
      }),
    );

    try {
      final activeCall = state.retrieveActiveCall(event.callId);
      final peerConnection = await _createPeerConnection(event.callId, activeCall!.line);
      await Future.wait(localStream.getTracks().map((track) => peerConnection.addTrack(track, localStream)));

      final localDescription = await peerConnection.createOffer({});
      sdpMunger?.apply(localDescription);
      _logger.infoPretty(localDescription.sdp, tag: '__onCallPerformEventStarted');

      // Need to initiate outgoing call before set localDescription to avoid races
      // between [OutgoingCallRequest] and [IceTrickleRequest]s.
      await _signalingModule.execute(
        OutgoingCallRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          from: activeCall.fromNumber,
          callId: activeCall.callId,
          number: activeCall.handle.normalizedValue(),
          jsep: localDescription.toMap(),
          referId: activeCall.fromReferId,
          replaces: activeCall.fromReplaces,
        ),
      );

      // In other cases setLocalDescription is called first; here it's delayed to avoid ICE race
      await peerConnection.setLocalDescription(localDescription);

      _peerConnectionManager.complete(event.callId, peerConnection);

      await callkeep.reportConnectingOutgoingCall(event.callId);

      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingOfferSent);
        }),
      );
    } catch (e, stackTrace) {
      // Handles exceptions during the outgoing call perform event, sends a notification, stops the ringtone, and completes the peer connection with an error.
      // The specific error "Error setting ICE locally" indicates an issue with ICE (Interactive Connectivity Establishment) negotiation in the WebRTC signaling process.
      callErrorReporter.handle(e, stackTrace, '__onCallPerformEventStarted error:');

      await _stopRingbackSound();
      _peerConnectionManager.completeError(event.callId, e, stackTrace);

      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  /// Performs answer after incoming call accepted by ui call controlls or native controls
  /// quick shortcuts:
  /// ui control event - [__onCallControlEventAnswered]
  /// after success - [__onCallSignalingEventAccepted]
  /// jsep processing in - [__onCallSignalingEventIncoming]
  Future<void> __onCallPerformEventAnswered(_CallPerformEventAnswered event, Emitter<CallState> emit) async {
    event.fulfill();

    ActiveCall? call = state.retrieveActiveCall(event.callId);
    if (call == null) return;

    // Prevent performing double answer and race conditions
    //
    // Main case happens when the call is answered from background(ios) or from the lock screen using navite controls
    // In such case performAnswered called emidiately and after signaling initialized via
    // [IncomingEvent] + (callAlreadyAnswered == true) > [callControlAnswered] > [performAnswered] called again
    //
    final canPerformAnswer = switch (call.processingStatus) {
      CallProcessingStatus.incomingFromPush => true,
      CallProcessingStatus.incomingFromOffer => true,
      CallProcessingStatus.incomingSubmittedAnswer => true,
      _ => false,
    };

    _logger.info(
      '__onCallPerformEventAnswered: callId=${event.callId} status=${call.processingStatus} '
      'hasOffer=${call.incomingOffer != null} signalingConnected=${_signalingModule.isConnected} '
      'appLifecycle=${state.currentAppLifecycleState}',
    );

    if (canPerformAnswer == false) {
      _logger.info('__onCallPerformEventAnswered: skipping due to stale status: ${call.processingStatus}');
      return;
    }

    emit(
      state.copyWithMappedActiveCall(event.callId, (call) {
        return call.copyWith(processingStatus: CallProcessingStatus.incomingPerformingStarted);
      }),
    );

    try {
      /// Prevent performing answer without offer
      ///
      /// Main case happens when the call is answered from push event while signaling is disconnected
      /// and main [IncomingEvent] with offer wasnt received yet
      ///
      if (call.incomingOffer == null) {
        _logger.info('__onCallPerformEventAnswered: wait for offer');

        // Signaling may still be disconnected when answering from push while the app was in background.
        // Trigger reconnect immediately so the offer can arrive — don't wait for AppLifecycleState.resumed.
        if (!_signalingModule.isConnected) {
          _logger.info('__onCallPerformEventAnswered: signaling not connected, forcing reconnect');
          _reconnectController.notifyForceReconnect();
        }

        final offerWaitStart = DateTime.now();
        await stream
            .firstWhere((s) {
              final activeCall = s.retrieveActiveCall(event.callId);
              return activeCall?.incomingOffer != null;
            })
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                throw TimeoutException('Timed out waiting for offer');
              },
            );

        final offerWaitMs = DateTime.now().difference(offerWaitStart).inMilliseconds;
        _logger.info('__onCallPerformEventAnswered: offer received after ${offerWaitMs}ms');

        call = state.retrieveActiveCall(event.callId)!;
      }
      final offer = call.incomingOffer!;

      _logger.info('__onCallPerformEventAnswered: processing offer, hasVideo=${offer.hasVideo}');

      emit(
        state.copyWithMappedActiveCall(event.callId, (call) {
          return call.copyWith(processingStatus: CallProcessingStatus.incomingInitializingMedia);
        }),
      );

      final localStream = await userMediaBuilder
          .build(video: offer.hasVideo, frontCamera: call.frontCamera, allowAudioFallback: true)
          .timeout(_getUserMediaPushKitTimeout, onTimeout: _onGetUserMediaPushKitTimeout);
      final peerConnection = await _createPeerConnection(event.callId, call.line);
      await Future.forEach(localStream.getTracks(), (t) => peerConnection.addTrack(t, localStream));

      emit(
        state.copyWithMappedActiveCall(event.callId, (call) {
          return call.copyWith(
            video: localStream.getVideoTracks().isNotEmpty,
            localStream: localStream,
            processingStatus: CallProcessingStatus.incomingAnswering,
          );
        }),
      );

      final remoteDescription = offer.toDescription();
      sdpSanitizer?.apply(remoteDescription);
      await peerConnection.setRemoteDescription(remoteDescription);
      _logger.info('__onCallPerformEventAnswered: remoteDescription set');
      final localDescription = await peerConnection.createAnswer({});
      sdpMunger?.apply(localDescription);

      // According to RFC 8829 5.6 (https://datatracker.ietf.org/doc/html/rfc8829#section-5.6),
      // localDescription should be set before sending the answer to transition into stable state.
      await peerConnection.setLocalDescription(localDescription).catchError((e) => throw SDPConfigurationError(e));
      _logger.info('__onCallPerformEventAnswered: localDescription set, sending AcceptRequest');

      // Re-check that the call still exists before sending AcceptRequest.
      // __onCallSignalingEventHangup may have run concurrently (e.g. 487 "Request Terminated"
      // from the server while SDP was being prepared), removing the call from state.
      // Sending accept on an already-terminated line results in a 4610 disconnect.
      if (state.retrieveActiveCall(event.callId) == null) {
        _logger.info('__onCallPerformEventAnswered: call terminated during SDP setup, skipping AcceptRequest');
        _peerConnectionManager.completeError(
          event.callId,
          Exception('call terminated during SDP setup'),
          StackTrace.current,
        );
        // __onCallSignalingEventHangup emits copyWithPopActiveCall before awaiting
        // callkeep.reportEndCall, so the native side may not have been notified yet.
        // Call it explicitly here to avoid leaving the Telecom connection in ACTIVE state.
        // Callkeep handles double calls gracefully (already-disconnected is a no-op).
        await callkeep.reportEndCall(
          event.callId,
          call.displayName ?? call.handle.value,
          CallkeepEndCallReason.unanswered,
        );
        return;
      }

      await _signalingModule.execute(
        AcceptRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: call.line,
          callId: call.callId,
          jsep: localDescription.toMap(),
        ),
      );

      _logger.info('__onCallPerformEventAnswered: AcceptRequest sent, completing peer connection');
      _peerConnectionManager.complete(event.callId, peerConnection);
    } catch (e, stackTrace) {
      _logger.warning(
        '__onCallPerformEventAnswered: failed callId=${event.callId} error=$e code:${e is WebtritSignalingErrorException ? e.code : 'N/A'}, reason=${e is WebtritSignalingErrorException ? e.reason : 'N/A'}',
        stackTrace,
      );

      // If call gone right before answer, consider it as normal flow and avoid showing error notification
      // TODO: implement signaling request response mechanism and handle request specific result instead of catching global errors
      if (e is WebtritSignalingErrorException && e.code == 410) {
        _peerConnectionManager.completeError(event.callId, e, stackTrace);
        add(_ResetStateEvent.completeCall(event.callId));
        _addToRecents(call!);
        return;
      }

      // If the server closed the connection because the line no longer exists (4610 "call request on wrong line"),
      // the call is already gone on the server side — clean up locally without sending a decline request.
      // Sending decline here would cause a reconnect loop: each reconnect attempt would send decline again,
      // receive 4610 again, disconnect again, and reconnect indefinitely.
      if (e is WebtritSignalingTransactionTerminateByDisconnectException &&
          e.closeCode == SignalingDisconnectCode.requestCallIdError.code) {
        _peerConnectionManager.completeError(event.callId, e, stackTrace);
        _addToRecents(call!);
        add(_ResetStateEvent.completeCall(event.callId, endReason: CallkeepEndCallReason.unanswered));
        return;
      }

      _peerConnectionManager.completeError(event.callId, e, stackTrace);
      _addToRecents(call!);
      add(_ResetStateEvent.completeCall(event.callId, endReason: CallkeepEndCallReason.unanswered));

      // If the WS was already closed when the answer flow failed, the server-side
      // call session is gone — sending DeclineRequest on the reconnected WS would
      // target a stale call and trigger another 4610 close.
      if (e is WebtritSignalingTransactionTerminateByDisconnectException) {
        callErrorReporter.handle(e, stackTrace, '__onCallPerformEventAnswered error:');
        return;
      }

      // For non-disconnect errors (e.g. UserMediaError, SDP errors) the server line
      // may still be alive. Send DeclineRequest to clean it up, and handle 4610 in
      // the inner catch — that means the caller already hung up server-side.
      try {
        final declineId = WebtritSignalingClient.generateTransactionId();
        await _signalingModule.execute(DeclineRequest(transaction: declineId, line: call.line, callId: call.callId));
        callErrorReporter.handle(e, stackTrace, '__onCallPerformEventAnswered error:');
      } catch (declineError, _) {
        if (declineError is WebtritSignalingTransactionTerminateByDisconnectException &&
            declineError.closeCode == SignalingDisconnectCode.requestCallIdError.code) {
          _logger.warning(
            '__onCallPerformEventAnswered: DeclineRequest rejected with 4610 callId=${event.callId} — call already terminated server-side, ignoring',
          );
          return;
        }
        callErrorReporter.handle(e, stackTrace, '__onCallPerformEventAnswered error:');
      }
    }
  }

  Future<void> __onCallPerformEventEnded(_CallPerformEventEnded event, Emitter<CallState> emit) async {
    try {
      await _onCallPerformEventEndedImpl(event, emit);
    } finally {
      // Release the post-cancel enqueue guard so the entry does not accumulate
      // for the lifetime of the signaling module.
      _signalingModule.clearTerminatingMark(event.callId);
    }
  }

  Future<void> _onCallPerformEventEndedImpl(_CallPerformEventEnded event, Emitter<CallState> emit) async {
    // Condition occur when the user interacts with a push notification before signaling is properly initialized.
    // In this case, the CallKeep method "reportNewIncomingCall" may return callIdAlreadyTerminated.
    if (state.retrieveActiveCall(event.callId)?.line == _kUndefinedLine) {
      add(_ResetStateEvent.completeCall(event.callId));
      return;
    }

    if (state.retrieveActiveCall(event.callId)?.wasHungUp == true) {
      // TODO: There's an issue where the user might have already ended the call, but the active call screen remains visible.
      if (state.isActive) {
        emit(state.copyWithPopActiveCall(event.callId));
      }
      event.fail();
      return;
    }
    event.fulfill();

    await _stopRingbackSound();

    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        final activeCallUpdated = activeCall.copyWith(hungUpTime: clock.now());
        _addToRecents(activeCallUpdated);
        return activeCallUpdated;
      }),
    );

    await state.performOnActiveCall(event.callId, (activeCall) async {
      if (activeCall.isIncoming && !activeCall.wasAccepted) {
        final declineRequest = DeclineRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId,
        );
        await _signalingModule.execute(declineRequest)?.catchError((e, s) {
          callErrorReporter.handle(e, s, '__onCallPerformEventEnded declineRequest error');
        });
      } else {
        // Skip hangup when a blind transfer is in Transfering state (server started to process it).
        // In this state the SIP dialog may already be closed server-side via REFER; sending hangup
        // results in a 4610 "call request on wrong line" rejection and an unexpected WebSocket disconnect.
        final isBlindTransferInTransferingState = switch (activeCall.transfer) {
          Transfering(:final fromBlindTransfer) => fromBlindTransfer,
          _ => false,
        };

        if (!isBlindTransferInTransferingState) {
          final hangupRequest = HangupRequest(
            transaction: WebtritSignalingClient.generateTransactionId(),
            line: activeCall.line,
            callId: activeCall.callId,
          );
          await _signalingModule.execute(hangupRequest)?.catchError((e, s) {
            callErrorReporter.handle(e, s, '__onCallPerformEventEnded hangupRequest error');
          });
        }
      }

      // Need to close peer connection after the signaling request (decline/hangup) has been sent,
      // or after skipping it for blind transfer, to prevent "Simulate a 'hangup' coming from the
      // application" triggered by "No WebRTC media anymore".
      await _peerConnectionManager.disposePeerConnection(activeCall.callId);
      await _releaseLocalStream(activeCall.localStream);
    });

    emit(state.copyWithPopActiveCall(event.callId));
  }

  Future<void> __onCallPerformEventSetHeld(_CallPerformEventSetHeld event, Emitter<CallState> emit) async {
    event.fulfill();

    try {
      await state.performOnActiveCall(event.callId, (activeCall) {
        if (event.onHold) {
          return _signalingModule.execute(
            HoldRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              callId: activeCall.callId,
              direction: HoldDirection.inactive,
            ),
          );
        } else {
          return _signalingModule.execute(
            UnholdRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              callId: activeCall.callId,
            ),
          );
        }
      });

      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(held: event.onHold);
        }),
      );
    } on NotConnectedException {
      _logger.warning('__onCallPerformEventSetHeld: not connected, let call survive');
    } on WebtritSignalingTransactionTimeoutException {
      _logger.warning('__onCallPerformEventSetHeld: transaction timeout, let call survive');
    } catch (e, stackTrace) {
      callErrorReporter.handle(e, stackTrace, '__onCallPerformEventSetHeld error');

      _peerConnectionManager.completeError(event.callId, e, stackTrace);

      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onCallPerformEventSetMuted(_CallPerformEventSetMuted event, Emitter<CallState> emit) async {
    event.fulfill();

    await state.performOnActiveCall(event.callId, (activeCall) {
      final audioTrack = activeCall.localStream?.getAudioTracks()[0];
      if (audioTrack != null) {
        Helper.setMicrophoneMute(event.muted, audioTrack);
      }
    });

    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(muted: event.muted);
      }),
    );
  }

  Future<void> __onCallPerformEventSentDTMF(_CallPerformEventSentDTMF event, Emitter<CallState> emit) async {
    event.fulfill();

    await state.performOnActiveCall(event.callId, (activeCall) async {
      final peerConnection = await _peerConnectionManager.retrieve(event.callId);
      if (peerConnection == null) {
        _logger.warning('__onCallPerformEventSentDTMF: peerConnection is null - most likely some permissions issue');
      } else {
        final senders = await peerConnection.senders;
        try {
          final audioSender = senders.firstWhere((sender) {
            final track = sender.track;
            if (track != null) {
              return track.kind == 'audio';
            } else {
              return false;
            }
          });
          await audioSender.dtmfSender.insertDTMF(event.key);
        } on StateError catch (_) {
          _logger.warning('__onCallPerformEventSentDTMF can\'t send DTMF');
        }
      }
    });
  }

  Future<void> __onCallPerformEventAudioDeviceSet(
    _CallPerformEventAudioDeviceSet event,
    Emitter<CallState> emit,
  ) async {
    _logger.info('CallPerformEventAudioDeviceSet: ${event.device}');
    event.fulfill();
    emit(state.copyWith(audioDevice: event.device));
  }

  Future<void> __onCallPerformEventAudioDevicesUpdate(
    _CallPerformEventAudioDevicesUpdate event,
    Emitter<CallState> emit,
  ) async {
    _logger.info('CallPerformEventAudioDevicesUpdate: ${event.devices}');
    event.fulfill();
    emit(state.copyWith(availableAudioDevices: event.devices));
  }

  // processing peer connection events

  Future<void> _onPeerConnectionEvent(_PeerConnectionEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _PeerConnectionEventSignalingStateChanged() => __onPeerConnectionEventSignalingStateChanged(event, emit),
      _PeerConnectionEventConnectionStateChanged() => __onPeerConnectionEventConnectionStateChanged(event, emit),
      _PeerConnectionEventIceGatheringStateChanged() => __onPeerConnectionEventIceGatheringStateChanged(event, emit),
      _PeerConnectionEventIceConnectionStateChanged() => __onPeerConnectionEventIceConnectionStateChanged(event, emit),
      _PeerConnectionEventIceCandidateIdentified() => __onPeerConnectionEventIceCandidateIdentified(event, emit),
      _PeerConnectionEventStreamAdded() => __onPeerConnectionEventStreamAdded(event, emit),
      _PeerConnectionEventStreamRemoved() => __onPeerConnectionEventStreamRemoved(event, emit),
      _PeerConnectionEventRenegotiationNeeded() => __onPeerConnectionEventRenegotiationNeeded(event, emit),
    };
  }

  Future<void> __onPeerConnectionEventSignalingStateChanged(
    _PeerConnectionEventSignalingStateChanged event,
    Emitter<CallState> emit,
  ) async {}

  Future<void> __onPeerConnectionEventConnectionStateChanged(
    _PeerConnectionEventConnectionStateChanged event,
    Emitter<CallState> emit,
  ) async {}

  Future<void> __onPeerConnectionEventRenegotiationNeeded(
    _PeerConnectionEventRenegotiationNeeded event,
    Emitter<CallState> emit,
  ) async {
    _logger.info('__onPeerConnectionEventRenegotiationNeeded: ${event.callId}');
    final _PeerConnectionEventRenegotiationNeeded(callId: callId, lineId: lineId) = event;
    await _safeRenegotiate(callId, lineId);
  }

  Future<void> __onPeerConnectionEventIceGatheringStateChanged(
    _PeerConnectionEventIceGatheringStateChanged event,
    Emitter<CallState> emit,
  ) async {
    if (event.state == RTCIceGatheringState.RTCIceGatheringStateComplete) {
      try {
        await state.performOnActiveCall(event.callId, (activeCall) {
          if (!activeCall.wasHungUp) {
            final iceTrickleRequest = IceTrickleRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              candidate: null,
            );
            return _signalingModule.execute(iceTrickleRequest);
          }
        });
      } on NotConnectedException {
        _logger.warning('__onPeerConnectionEventIceGatheringStateChanged: not connected, let call survive');
      } on WebtritSignalingTransactionTimeoutException {
        _logger.warning('__onPeerConnectionEventIceGatheringStateChanged: transaction timeout, let call survive');
      } catch (e, stackTrace) {
        callErrorReporter.handle(e, stackTrace, '__onPeerConnectionEventIceGatheringStateChanged error');

        _peerConnectionManager.completeError(event.callId, e, stackTrace);

        add(_ResetStateEvent.completeCall(event.callId));
      }
    }
  }

  Future<void> __onPeerConnectionEventIceConnectionStateChanged(
    _PeerConnectionEventIceConnectionStateChanged event,
    Emitter<CallState> emit,
  ) async {
    if (event.state == RTCIceConnectionState.RTCIceConnectionStateFailed) {
      try {
        final peerConnection = await _peerConnectionManager.retrieve(event.callId);
        if (peerConnection == null) return;
        final pcState = peerConnection.signalingState;
        _logger.warning('__onPeerConnectionEventIceConnectionStateChanged: ICE  failed, pcState: $pcState');
        if (pcState == RTCSignalingState.RTCSignalingStateStable) {
          // Will trigger [onPeerConnectionEventRenegotiationNeeded]
          // No need to create and send a new offer here, as the renegotiation flow will handle that.
          await peerConnection.restartIce();
        }
      } catch (e, stackTrace) {
        callErrorReporter.handle(e, stackTrace, '__onPeerConnectionEventIceConnectionStateChanged error');
      }
    }
  }

  Future<void> __onPeerConnectionEventIceCandidateIdentified(
    _PeerConnectionEventIceCandidateIdentified event,
    Emitter<CallState> emit,
  ) async {
    if (iceFilter?.filter(event.candidate) == true) {
      _logger.fine('__onPeerConnectionEventIceCandidateIdentified: skip by iceFiler');
      return;
    }

    try {
      await state.performOnActiveCall(event.callId, (activeCall) {
        if (!activeCall.wasHungUp) {
          final iceTrickleRequest = IceTrickleRequest(
            transaction: WebtritSignalingClient.generateTransactionId(),
            line: activeCall.line,
            candidate: event.candidate.toMap(),
          );
          return _signalingModule.execute(iceTrickleRequest);
        }
      });
    } on NotConnectedException {
      _logger.warning('__onPeerConnectionEventIceCandidateIdentified: not connected, let call survive');
    } on WebtritSignalingTransactionTimeoutException {
      _logger.warning('__onPeerConnectionEventIceCandidateIdentified: transaction timeout, let call survive');
    } catch (e, stackTrace) {
      callErrorReporter.handle(e, stackTrace, '__onPeerConnectionEventIceCandidateIdentified error');

      _peerConnectionManager.completeError(event.callId, e, stackTrace);

      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onPeerConnectionEventStreamAdded(
    _PeerConnectionEventStreamAdded event,
    Emitter<CallState> emit,
  ) async {
    // Skip stub stream created by Janus on unidirectional video
    if (event.stream.id == 'janus') return;

    final currentStream = state.retrieveActiveCall(event.callId)?.remoteStream;
    final sameRef = identical(currentStream, event.stream);
    _logger.info(
      '__onPeerConnectionEventStreamAdded: callId=${event.callId} '
      'streamId=${event.stream.id} '
      'videoTracks=${event.stream.getVideoTracks().length} '
      'sameRef=$sameRef',
    );

    // When onAddTrack fires with the same stream reference (existing stream gains
    // a new video track during renegotiation), the Freezed equality check on
    // ActiveCall would consider the state unchanged and skip the emit, leaving the
    // RTCVideoRenderer subscribed to the old track. Clear remoteStream first to
    // force a reference change that triggers renderer refresh.
    if (sameRef) {
      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(remoteStream: null);
        }),
      );
    }

    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(remoteStream: event.stream);
      }),
    );
  }

  Future<void> __onPeerConnectionEventStreamRemoved(
    _PeerConnectionEventStreamRemoved event,
    Emitter<CallState> emit,
  ) async {
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        final prevStream = activeCall.remoteStream;
        if (prevStream != null && prevStream.id == event.stream.id) {
          return activeCall.copyWith(remoteStream: null);
        }
        return activeCall;
      }),
    );
  }

  // procession call screen events

  Future<void> _onCallScreenEvent(CallScreenEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallScreenEventDidPush() => __onCallScreenEventDidPush(event, emit),
      _CallScreenEventDidPop() => __onCallScreenEventDidPop(event, emit),
    };
  }

  Future<void> __onCallScreenEventDidPush(_CallScreenEventDidPush event, Emitter<CallState> emit) async {
    final hasActiveCalls = state.activeCalls.isNotEmpty;
    var newState = state.copyWith(minimized: false);

    if (hasActiveCalls) {
      newState = newState.copyWithMappedActiveCalls((activeCall) {
        final transfer = activeCall.transfer;
        if (transfer != null && transfer is BlindTransferInitiated) {
          return activeCall.copyWith(transfer: null);
        } else {
          return activeCall;
        }
      });

      emit(newState);

      final currentCall = state.activeCalls.current;

      await callkeep.reportUpdateCall(currentCall.callId, proximityEnabled: state.shouldListenToProximity);

      if (currentCall.speakerOnBeforeMinimize == true) {
        final speakerDevice = state.availableAudioDevices.getSpeaker;
        if (speakerDevice != null) {
          add(CallControlEvent.audioDeviceSet(currentCall.callId, speakerDevice));
        } else {
          _logger.warning(
            '_onCallControlEventBlindTransferSubmitted: speaker was on before minimize but its not available now',
          );
        }
      }
    } else {
      _logger.warning('__onCallScreenEventDidPush: activeCalls is empty');
    }
  }

  Future<void> __onCallScreenEventDidPop(_CallScreenEventDidPop event, Emitter<CallState> emit) async {
    final shouldMinimize = state.activeCalls.isNotEmpty;
    _logger.info('__onCallScreenEventDidPop: shouldMinimize: $shouldMinimize');

    if (shouldMinimize) {
      final currentCallId = state.activeCalls.current.callId;
      final isSpeakerOn = state.audioDevice?.type == CallAudioDeviceType.speaker;

      emit(
        state
            .copyWithMappedActiveCall(currentCallId, (call) {
              return call.copyWith(speakerOnBeforeMinimize: isSpeakerOn);
            })
            .copyWith(minimized: true),
      );

      await callkeep.reportUpdateCall(currentCallId, proximityEnabled: state.shouldListenToProximity);
    }
  }

  void _onConfigEvent(CallConfigEvent event, Emitter<CallState> emit) {
    switch (event) {
      case _CallConfigEventUpdated(monitorCheckInterval: final interval):
        _logger.info('Updating PeerConnectionManager configuration: monitorCheckInterval=$interval');
        _peerConnectionManager.updateConfig(monitorCheckInterval: interval);
    }
  }

  // SignalingModule event handlers (called from stream subscription in constructor)

  void _handleHandshakeReceived(StateHandshake stateHandshake) async {
    add(
      _HandshakeSignalingEventState(registration: stateHandshake.registration, linesCount: stateHandshake.lines.length),
    );

    _assignInitialPresence(stateHandshake.presenceInfos);
    _assignInitialDialogs(stateHandshake.dialogInfos);

    // Hang up all active calls that are not associated with any line
    // or guest line, indicating that they are no longer valid.
    //
    // This is needed to drop or retain calls after reconnecting to the signaling server.
    // If you have troubles with line position mismatch replace the activeLineCallIds
    // computation with: https://gist.github.com/digiboridev/f7f1020731e8f247b5891983433bd159
    final activeLineCallIds = [
      ...stateHandshake.lines,
      stateHandshake.guestLine,
    ].whereType<Line>().map((line) => line.callId).toSet();

    for (final activeCall in state.callsToTerminate(activeLineCallIds)) {
      _peerConnectionManager.conditionalCompleteError(activeCall.callId, 'Active call Request Terminated');
      add(
        _CallSignalingEvent.hangup(
          line: activeCall.line,
          callId: activeCall.callId,
          code: 487,
          reason: 'Request Terminated',
        ),
      );
    }

    // Retry HangupRequest for calls that were being terminated when signaling dropped.
    // If a call is locally disconnecting AND the server still lists it in activeLineCallIds,
    // the hangup was lost mid-flight — resend it now so the server-side leg is torn down.
    for (final activeCall in state.activeCalls) {
      if (activeCall.processingStatus != CallProcessingStatus.disconnecting) continue;
      if (!activeLineCallIds.contains(activeCall.callId)) continue;
      _signalingModule
          .execute(
            HangupRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              callId: activeCall.callId,
            ),
          )
          ?.catchError((e, s) => callErrorReporter.handle(e, s, '_handleHandshakeReceived pendingHangup retry error'))
          .ignore();
    }

    final actions = await _handshakeProcessor.process(
      lines: stateHandshake.lines,
      guestLine: stateHandshake.guestLine,
      activeCallIds: state.activeCalls.map((c) => c.callId).toSet(),
    );

    for (final action in actions) {
      switch (action) {
        case HangupSignalingAction():
          await _signalingModule
              .execute(
                HangupRequest(
                  transaction: WebtritSignalingClient.generateTransactionId(),
                  line: action.line,
                  callId: action.callId,
                ),
              )
              ?.catchError((e, s) => callErrorReporter.handle(e, s, '_handleHandshakeReceived hangupRequest error'));
          return;

        case DeclineSignalingAction():
          await _signalingModule
              .execute(
                DeclineRequest(
                  transaction: WebtritSignalingClient.generateTransactionId(),
                  line: action.line,
                  callId: action.callId,
                ),
              )
              ?.catchError((e, s) => callErrorReporter.handle(e, s, '_handleHandshakeReceived declineRequest error'));
          return;

        case RestoreCallAction():
          add(
            _RestoreAcceptedCall(
              line: action.line,
              callId: action.callId,
              acceptedEvent: action.acceptedEvent,
              acceptedTime: action.acceptedTime,
              incomingCallEvent: action.incomingCallEvent,
            ),
          );

        case HandleIncomingCallAction():
          _handleSignalingEvent(action.event);

        case EndLocalCallAction():
          await callkeep.endCall(action.callId);
      }
    }
  }

  Future<void> _onRestoreAcceptedCall(_RestoreAcceptedCall event, Emitter<CallState> emit) async {
    final CallkeepHandle handle;
    final String? callerDisplayName;
    final bool video;
    final JsepValue? incomingOffer;
    final CallDirection direction;

    if (event.incomingCallEvent != null) {
      final incoming = event.incomingCallEvent!;
      final jsep = JsepValue.fromOptional(incoming.jsep);
      handle = CallkeepHandle.number(incoming.caller);
      callerDisplayName = incoming.callerDisplayName;
      video = jsep?.hasVideo ?? false;
      // The original offer SDP is stored for UI/video detection purposes only.
      // It is NOT used for media setup during restoration — __onCallPerformEventAnswered
      // is bypassed because the status starts at incomingRestoringMedia (excluded from
      // canPerformAnswer). Media is re-established via renegotiationNeeded -> UpdateRequest
      // (ICE restart), which creates a fresh offer with new ICE credentials.
      // Outgoing restored calls use outgoingRestoringMedia for the same reason
      // (excluded from canPerformStart normal flow).
      incomingOffer = jsep;
      direction = CallDirection.incoming;
    } else {
      final callee = event.acceptedEvent.callee ?? '';
      final number = callee.replaceFirst(RegExp(r'^sips?:'), '').split('@').first;
      final jsep = JsepValue.fromOptional(event.acceptedEvent.jsep);
      handle = CallkeepHandle.number(number);
      callerDisplayName = null;
      video = jsep?.hasVideo ?? false;
      incomingOffer = null;
      direction = CallDirection.outgoing;
    }

    final contactName = await contactNameResolver.resolveWithNumber(handle.value);
    final displayName = contactName ?? callerDisplayName;

    if (state.activeCalls.any((c) => c.callId == event.callId)) {
      _logger.warning('_onRestoreAcceptedCall: callId=${event.callId} already active, skipping');
      return;
    }

    final activeCall = ActiveCall(
      direction: direction,
      line: event.line,
      callId: event.callId,
      handle: handle,
      displayName: displayName,
      video: video,
      createdTime: clock.now(),
      incomingOffer: incomingOffer,
      processingStatus: direction == CallDirection.incoming
          ? CallProcessingStatus.incomingRestoringMedia
          : CallProcessingStatus.outgoingRestoringMedia,
    );
    emit(state.copyWithPushActiveCall(activeCall));

    if (direction == CallDirection.incoming) {
      final reportError = await callkeep.reportNewIncomingCall(
        event.callId,
        handle,
        displayName: displayName,
        hasVideo: video,
      );

      final acceptableReportErrors = {
        null,
        CallkeepIncomingCallError.callIdAlreadyExists,
        CallkeepIncomingCallError.callIdAlreadyExistsAndAnswered,
      };
      if (!acceptableReportErrors.contains(reportError)) {
        _logger.warning('_onRestoreAcceptedCall: reportNewIncomingCall returned $reportError, aborting');
        add(_ResetStateEvent.completeCall(event.callId));
        return;
      }

      if (reportError == null || reportError == CallkeepIncomingCallError.callIdAlreadyExists) {
        final answerError = await callkeep.answerCall(event.callId);
        if (answerError != null) {
          _logger.warning('_onRestoreAcceptedCall: answerCall error: $answerError, aborting');
          add(_ResetStateEvent.completeCall(event.callId));
          return;
        }
      }
    } else {
      // Register with Telecom; performStartCall is handled by the canPerformStart guard.
      final startCallError = await callkeep.startCall(
        event.callId,
        handle,
        displayNameOrContactIdentifier: displayName,
        hasVideo: video,
        proximityEnabled: !video,
      );
      if (startCallError != null) {
        _logger.warning('_onRestoreAcceptedCall: startCall error: $startCallError');
      }
    }

    MediaStream? localStream;
    RTCPeerConnection? peerConnection;

    try {
      localStream = await userMediaBuilder.build(video: video, frontCamera: activeCall.frontCamera);
      peerConnection = await _createPeerConnection(event.callId, event.line);
      await Future.forEach(localStream.getTracks(), (t) => peerConnection!.addTrack(t, localStream!));

      emit(
        state.copyWithMappedActiveCall(
          event.callId,
          (c) => c.copyWith(
            localStream: localStream,
            processingStatus: CallProcessingStatus.connected,
            acceptedTime: event.acceptedTime,
          ),
        ),
      );
      localStream = null;

      _peerConnectionManager.complete(event.callId, peerConnection);
      peerConnection = null;

      add(_PeerConnectionEvent.renegotiationNeeded(event.callId, event.line));
    } catch (e, stackTrace) {
      localStream?.getTracks().forEach((t) => t.stop());
      await _releaseLocalStream(localStream);
      await peerConnection?.dispose();
      _peerConnectionManager.completeError(event.callId, e, stackTrace);
      add(_ResetStateEvent.completeCall(event.callId));
      callErrorReporter.handle(e, stackTrace, '_onRestoreAcceptedCall error:');
    }
  }

  void _handleSignalingEvent(Event event) {
    _logger.info('[SIG] ${event.runtimeType}');
    if (event is IncomingCallEvent) {
      _logger.warning('[SIG] IncomingCallEvent: callId=${event.callId} caller=${event.caller} callee=${event.callee}');
      add(
        _CallSignalingEvent.incoming(
          line: event.line,
          callId: event.callId,
          callee: event.callee,
          caller: event.caller,
          callerDisplayName: event.callerDisplayName,
          referredBy: event.referredBy,
          replaceCallId: event.replaceCallId,
          isFocus: event.isFocus,
          jsep: JsepValue.fromOptional(event.jsep),
        ),
      );
    } else if (event is RingingEvent) {
      add(_CallSignalingEvent.ringing(line: event.line, callId: event.callId));
    } else if (event is ProgressEvent) {
      add(
        _CallSignalingEvent.progress(
          line: event.line,
          callId: event.callId,
          callee: event.callee,
          jsep: JsepValue.fromOptional(event.jsep),
        ),
      );
    } else if (event is AcceptedEvent) {
      add(
        _CallSignalingEvent.accepted(
          line: event.line,
          callId: event.callId,
          callee: event.callee,
          jsep: JsepValue.fromOptional(event.jsep),
        ),
      );
    } else if (event is HangupEvent) {
      _logger.warning('[SIG] HangupEvent: callId=${event.callId} code=${event.code} reason="${event.reason}"');
      add(_CallSignalingEvent.hangup(line: event.line, callId: event.callId, code: event.code, reason: event.reason));
    } else if (event is UpdatingCallEvent) {
      add(
        _CallSignalingEvent.callUpdating(
          line: event.line,
          callId: event.callId,
          callee: event.callee,
          caller: event.caller,
          callerDisplayName: event.callerDisplayName,
          referredBy: event.referredBy,
          replaceCallId: event.replaceCallId,
          isFocus: event.isFocus,
          jsep: JsepValue.fromOptional(event.jsep),
        ),
      );
    } else if (event is UpdatingEvent) {
      add(_CallSignalingEvent.updating(line: event.line, callId: event.callId));
    } else if (event is UpdatedEvent) {
      add(_CallSignalingEvent.updated(line: event.line, callId: event.callId));
    } else if (event is TransferEvent) {
      add(
        _CallSignalingEvent.transfer(
          line: event.line,
          referId: event.referId,
          referTo: event.referTo,
          referredBy: event.referredBy,
          replaceCallId: event.replaceCallId,
        ),
      );
    } else if (event is NotifyEvent) {
      add(switch (event) {
        ReferNotifyEvent event => _CallSignalingEvent.notifyRefer(
          line: event.line,
          callId: event.callId,
          notify: event.notify,
          subscriptionState: event.subscriptionState,
          state: event.state,
        ),
        UnknownNotifyEvent event => _CallSignalingEvent.notifyUnknown(
          line: event.line,
          callId: event.callId,
          notify: event.notify,
          subscriptionState: event.subscriptionState,
          contentType: event.contentType,
          content: event.content,
        ),
      });
    } else if (event is RegisteringEvent) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.registering));
    } else if (event is RegisteredEvent) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.registered));
    } else if (event is RegistrationFailedEvent) {
      final registrationFailedEvent = _CallSignalingEvent.registration(
        RegistrationStatus.registration_failed,
        code: event.code,
        reason: event.reason,
      );
      add(registrationFailedEvent);
    } else if (event is UnregisteringEvent) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.unregistering));
    } else if (event is UnregisteredEvent) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.unregistered));
    } else if (event is TransferringEvent) {
      add(_CallSignalingEvent.transferring(line: event.line, callId: event.callId));
    } else if (event is GlobalEvent) {
      add(switch (event) {
        NumberPresenceUpdate event => _GlobalEvent.numberPresenceUpdate(
          number: event.number,
          presenceInfo: event.presenceInfo,
        ),
        NumberDialogsUpdate event => _GlobalEvent.numberDialogsUpdate(
          number: event.number,
          dialogInfos: event.dialogInfos,
        ),
      });
    } else if (event is CallingEvent) {
      _logger.info('[SIG] CallingEvent: callId=${event.callId} line=${event.line} - remote is ringing');
    } else if (event is HangingupEvent) {
      _logger.info('[SIG] HangingupEvent: callId=${event.callId} line=${event.line} - hangup in progress');
    } else if (event is IceHangupEvent) {
      _logger.info('[SIG] IceHangupEvent: line=${event.line} reason="${event.reason}"');
    } else {
      _logger.warning('unhandled signaling event $event');
    }
  }

  // WidgetsBindingObserver

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _logger.finer('didChangeAppLifecycleState: $state');
    add(_AppLifecycleStateChanged(state));
  }

  // CallkeepDelegate

  @override
  void continueStartCallIntent(CallkeepHandle handle, String? displayName, bool video) {
    _logger.fine(() => 'continueStartCallIntent handle: $handle displayName: $displayName video: $video');

    _continueStartCallIntent(handle, displayName, video);
  }

  Future<void> _continueStartCallIntent(CallkeepHandle handle, String? displayName, bool video) async {
    _logger.fine(
      () => StringBuffer()
        ..write('_continueStartCallIntent - Attempting to start call')
        ..write(' handle: $handle')
        ..write(' displayName: $displayName')
        ..write(' video: $video')
        ..write(' isHandshakeActive: ${state.isHandshakeEstablished}')
        ..write(' isSignalingActive: ${state.isSignalingEstablished}'),
    );

    try {
      // Wait until both signaling and handshake are active.
      // If the desired state is not reached within kSignalingClientConnectionTimeout, a TimeoutException will be thrown.
      final resolvedState = await stream
          .firstWhere((state) => state.isHandshakeEstablished && state.isSignalingEstablished)
          .timeout(kSignalingClientConnectionTimeout);

      if (isClosed) return;

      _logger.fine(
        () => StringBuffer()
          ..write('_continueStartCallIntent - Signaling and handshake are now active for')
          ..write(' handle: $handle')
          ..write(' displayName: $displayName')
          ..write(' video: $video')
          ..write(' isHandshakeActive: ${resolvedState.isHandshakeEstablished}')
          ..write(' isSignalingActive: ${resolvedState.isSignalingEstablished}'),
      );

      final event = CallControlEvent.started(
        generic: handle.isGeneric ? handle.value : null,
        number: handle.isNumber ? handle.value : null,
        email: handle.isEmail ? handle.value : null,
        displayName: displayName,
        video: video,
      );

      add(event);
    } on TimeoutException {
      if (isClosed) return;

      _logger.warning(
        () => StringBuffer()
          ..write('_continueStartCallIntent - Failed to start call')
          ..write(' handle: $handle')
          ..write(' (Signaling/handshake connection timed out after ${kSignalingClientConnectionTimeout.inSeconds}s)')
          ..write(' isHandshakeActive: ${state.isHandshakeEstablished}')
          ..write(' isSignalingActive: ${state.isSignalingEstablished}'),
      );

      submitNotification(const SignalingConnectFailedNotification());
    } catch (e, s) {
      if (isClosed) return;

      final severeMessage = StringBuffer()
        ..write('_continueStartCallIntent - An unexpected error occurred while waiting for signaling')
        ..write(' handle: $handle');
      _logger.severe(() => severeMessage, e, s);

      submitNotification(ErrorMessageNotification(e.toString()));
    }
  }

  @override
  // Handles incoming call notifications from the native side.
  // On iOS, this is triggered via PushKit when a push is received.
  //
  // On Android, this method is currently not used. Call state synchronization
  // from the background is handled by `CallkeepConnections`. A future refactoring
  // could unify this logic so that both platforms use this delegate method.
  //
  // On Android, this is now fully feasible because after the recent callback
  // improvement we can reliably detect when the bloc is ready.
  //
  // PDelegateFlutterApi.setUp(null);
  // _api.onDelegateSet();
  //
  // TODO: Unify incoming-call handling for both iOS and Android so that
  // this method becomes the shared entry point. This may require removing
  // `CallkeepConnections` and adjusting the method signature.
  void didPushIncomingCall(
    CallkeepHandle handle,
    String? displayName,
    bool video,
    String callId,
    CallkeepIncomingCallError? error,
  ) {
    _logger.fine(
      () =>
          'didPushIncomingCall handle: $handle displayName: $displayName video: $video'
          ' callId: $callId error: $error',
    );

    add(_CallPushEventIncoming(callId: callId, handle: handle, displayName: displayName, video: video, error: error));
  }

  @override
  Future<bool> performStartCall(
    String callId,
    CallkeepHandle handle,
    String? displayNameOrContactIdentifier,
    bool video,
  ) {
    return _perform(
      _CallPerformEvent.started(callId, handle: handle, displayName: displayNameOrContactIdentifier, video: video),
    );
  }

  @override
  Future<bool> performAnswerCall(String callId) {
    return _perform(_CallPerformEvent.answered(callId));
  }

  @override
  Future<bool> performEndCall(String callId) {
    return _perform(_CallPerformEvent.ended(callId));
  }

  @override
  Future<bool> performSetHeld(String callId, bool onHold) {
    return _perform(_CallPerformEvent.setHeld(callId, onHold));
  }

  @override
  Future<bool> performSetMuted(String callId, bool muted) {
    return _perform(_CallPerformEvent.setMuted(callId, muted));
  }

  @override
  Future<bool> performSendDTMF(String callId, String key) {
    return _perform(_CallPerformEvent.sentDTMF(callId, key));
  }

  @override
  Future<bool> performAudioDeviceSet(String callId, CallkeepAudioDevice device) {
    final callDevice = CallAudioDevice.fromCallkeep(device);
    return _perform(_CallPerformEvent.audioDeviceSet(callId, callDevice));
  }

  @override
  Future<bool> performAudioDevicesUpdate(String callId, List<CallkeepAudioDevice> devices) {
    final callDevices = devices.map(CallAudioDevice.fromCallkeep).toList();
    return _perform(_CallPerformEvent.audioDevicesUpdate(callId, callDevices));
  }

  @override
  void didActivateAudioSession() {
    _logger.fine('didActivateAudioSession');
    () async {
      await AppleNativeAudioManagement.audioSessionDidActivate();
      await AppleNativeAudioManagement.setIsAudioEnabled(true);
    }();
  }

  @override
  void didDeactivateAudioSession() {
    _logger.fine('didDeactivateAudioSession');
    () async {
      await AppleNativeAudioManagement.setIsAudioEnabled(false);
      await AppleNativeAudioManagement.audioSessionDidDeactivate();
    }();
  }

  @override
  void didReset() {
    _logger.warning('didReset');
  }

  // helpers

  Future<bool> _perform(_CallPerformEvent callPerformEvent) {
    add(callPerformEvent);
    return callPerformEvent.future;
  }

  Future<RTCPeerConnection> _createPeerConnection(String callId, int? lineId) {
    return _peerConnectionManager.createPeerConnection(
      callId,
      observer: PeerConnectionObserver(
        onSignalingState: (state) => add(_PeerConnectionEvent.signalingStateChanged(callId, state)),
        onConnectionState: (state) => add(_PeerConnectionEvent.connectionStateChanged(callId, state)),
        onIceGatheringState: (state) => add(_PeerConnectionEvent.iceGatheringStateChanged(callId, state)),
        onIceConnectionState: (state) => add(_PeerConnectionEvent.iceConnectionStateChanged(callId, state)),
        onIceCandidate: (candidate) => add(_PeerConnectionEvent.iceCandidateIdentified(callId, candidate)),
        onAddStream: (stream) => add(_PeerConnectionEvent.streamAdded(callId, stream)),
        onRemoveStream: (stream) => add(_PeerConnectionEvent.streamRemoved(callId, stream)),
        // onAddTrack fires during renegotiation when a new track is added to an
        // existing stream. In that case onAddStream does NOT re-fire (only fired
        // once per unique stream ID). Forwarding the stream here ensures the BLoC
        // state is updated with the latest stream reference when video is added
        // mid-call (e.g. after a glare-resolution rollback).
        onAddTrack: (stream, track) => add(_PeerConnectionEvent.streamAdded(callId, stream)),
        onRenegotiationNeeded: (pc) {
          // Skips initial triggering that happens during peer connection setup
          if (pc.signalingState != null) add(_PeerConnectionEvent.renegotiationNeeded(callId, lineId));
        },
      ),
    );
  }

  void _addToRecents(ActiveCall activeCall) {
    final number = activeCall.handle.value;
    final username = activeCall.displayName;

    _logger.info(
      '[Recents:store] '
      'direction=${activeCall.direction.name} '
      'number=$number '
      'number.hash=${number.hashCode} '
      'username=$username '
      'username.hash=${username?.hashCode} '
      'numberEqualsUsername=${number == username} '
      'usernameIsNull=${username == null}',
    );

    NewCall call = (
      direction: activeCall.direction,
      number: number,
      video: activeCall.video,
      username: username,
      createdTime: activeCall.createdTime,
      acceptedTime: activeCall.acceptedTime,
      hungUpTime: activeCall.hungUpTime,
    );
    callLogsRepository.add(call);
  }

  Future<void> _playRingbackSound() => _callkeepSound.playRingbackSound();

  Future<void> _stopRingbackSound() => _callkeepSound.stopRingbackSound();

  Future<void> _releaseLocalStream(MediaStream? stream) async {
    if (stream == null) return;
    await userMediaBuilder.release(stream);
  }

  Future<void> _assignInitialPresence(List<SignalingPresenceInfo> data) async {
    _logger.info('Received initial presence info: ${data.length} entries');

    final presenceInfo = data.map(SignalingPresenceInfoMapper.fromSignaling).toList();
    presenceInfoRepository.setInitialPresenceInfo(presenceInfo);
  }

  Future<void> _assignNumberPresence(String number, List<SignalingPresenceInfo> data) async {
    _logger.info('Received presence update for number $number: ${data.length} entries');

    final presenceInfo = data.map(SignalingPresenceInfoMapper.fromSignaling).toList();
    presenceInfoRepository.setNumberPresence(number, presenceInfo);
  }

  Future<void> _assignInitialDialogs(List<SignalingDialogInfo> data) async {
    _logger.info('Received initial dialogs: ${data.length} dialogs');

    final dialogInfos = data.map(SignalingDialogInfoMapper.fromSignaling).toList();
    dialogInfoRepository.setInitialDialogInfo(dialogInfos);
  }

  Future<void> _assignNumberDialogs(String number, List<SignalingDialogInfo> data) async {
    _logger.info('Received dialogs update for number $number: ${data.length} dialogs');

    final dialogInfos = data.map(SignalingDialogInfoMapper.fromSignaling).toList();
    dialogInfoRepository.setNumberDialogs(number, dialogInfos);
  }

  Future<void> syncPresenceSettings() async {
    final now = DateTime.now();
    final lastSync = presenceSettingsRepository.lastSettingsSync;
    final presenceSettings = presenceSettingsRepository.presenceSettings;

    final canUpdate = state.callServiceState.status == CallStatus.ready;
    bool shouldUpdate = false;
    if (lastSync == null) {
      shouldUpdate = true;
    } else if (presenceSettings.timestamp.difference(lastSync).inSeconds > 0) {
      shouldUpdate = true;
    } else if (now.difference(lastSync).inMinutes >= 30) {
      shouldUpdate = true;
    }

    if (shouldUpdate && canUpdate) {
      _logger.fine('_presenceInfoSyncTimer: updating presence settings');
      try {
        await _signalingModule.execute(
          PresenceSettingsUpdateRequest(
            transaction: clock.now().millisecondsSinceEpoch.toString(),
            settings: SignalingPresenceSettingsMapper.toSignaling(presenceSettings),
          ),
        );
        presenceSettingsRepository.updateLastSettingsSync(now);
        _logger.fine('Presence settings updated at $now');
      } on Exception catch (e, s) {
        _logger.warning('Failed to update presence settings', e, s);
      }
    }
  }

  void _checkSenderResult(RTCRtpSender? senderResult, String kind) {
    if (senderResult == null) {
      _logger.warning('safeAddTrack for $kind returned null: track not added, possibly due to closed connection');
    }
  }

  void _clearRenegotiationHandler(String callId) {
    _renegotiationHandlers.remove(callId);
  }

  void _clearRenegotiationHandlers() {
    _renegotiationHandlers.clear();
  }

  RenegotiationHandler _getOrCreateRenegotiationHandler(String callId) {
    return _renegotiationHandlers.putIfAbsent(
      callId,
      () => RenegotiationHandler(callErrorReporter: callErrorReporter, sdpMunger: sdpMunger),
    );
  }

  /// Performs a safe renegotiation by first checking if the active call and peer connection still exist before proceeding and no "updating" state is detected on the call.
  ///
  /// Designed to be triggered in response to the `onRenegotiationNeeded` or manually for scenarios like:
  /// - boost call recovery after network switch
  ///   (currently WebRTC built-in detector triggers after 10-15s, better to synchronize it with our signaling reconnection)
  /// - force renegotiation after double network
  ///   (when device had poor GSM, and then WIFI connected as second interface
  ///   but WebRTC prefer stay on GSM network interface instead of switching to WIFI, so we can trigger renegotiation to make WebRTC switch to WIFI)
  /// - if "STALLED" rtp traffic is detected
  ///   (of something unexpected happens with RTP stream, will be good to try to recorer it with renegotiation)
  /// - you name it..
  Future<void> _safeRenegotiate(String callId, int? lineId, {int retryCount = 0}) async {
    final activeCall = state.retrieveActiveCall(callId);
    if (activeCall == null) {
      _logger.info('_safeRenegotiate: activeCall disposed, skipping renegotiation');
      return;
    }

    if (activeCall.line == null || activeCall.line == _kUndefinedLine) {
      _logger.info('_safeRenegotiate: activeCall line is ${activeCall.line}, skipping renegotiation');
      return;
    }

    final pc = await _peerConnectionManager.retrieve(callId);
    if (pc == null) {
      _logger.info('_safeRenegotiate: pc disposed, skipping renegotiation');
      return;
    }

    // Warning, this code block will executes even in case when app has no connection at all
    // Example1:
    // user turn off all network interfaces >> __onPeerConnectionEventIceConnectionStateChanged >> RTCIceConnectionStateFailed >> peerConnection.restartIce() >> onRenegotiationNeeded >> _safeRenegotiate
    //
    // so its important to prevent it from creating new offer and send it to nowhere or it will lead to hasLocalOffer stuck.
    // Dont forget to invoke _safeRenegotiate manualy when signaling reconnected to make sure the new offer will be sended
    //
    final signalingConnected = state.isSignalingEstablished;
    if (!signalingConnected) {
      _logger.info('_safeRenegotiate: signaling not connected, skipping renegotiation');
      return;
    }

    // If call already in updating state, mostly by remote renegetiation, hold, transfer etc..
    // we trying to wait and retry renegotiation after 1s,
    // but after 3 times do it forcefully to avoid stuck in renegotiation loop if something goes wrong with call state
    if (activeCall.updating && retryCount != 3) {
      final newCount = retryCount + 1;
      await Future.delayed(Duration(seconds: newCount));
      _logger.info('_safeRenegotiate: activeCall is updating, retrying renegotiation (retryCount: $retryCount)');
      return _safeRenegotiate(callId, lineId, retryCount: newCount);
    }

    final renegotiationHandler = _getOrCreateRenegotiationHandler(callId);
    await renegotiationHandler.handle(callId, pc, _sendRenegotiationUpdate);
  }

  /// Sends a renegotiation [UpdateRequest] to the signaling server with the given [jsep] offer.
  ///
  /// Used as a [RenegotiationExecutor] callback by [RenegotiationHandler].
  Future<void> _sendRenegotiationUpdate(String callId, RTCSessionDescription jsep) async {
    state.performOnActiveCall(callId, (call) async {
      if (call.line == null || call.line == _kUndefinedLine) {
        _logger.severe('_sendRenegotiationUpdate: activeCall line is ${call.line}, its should never happen!!');
        return;
      }

      final updateRequest = UpdateRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: call.line,
        callId: callId,
        jsep: jsep.toMap(),
      );
      await _signalingModule.execute(updateRequest);
    });
  }

  Never _onGetUserMediaPushKitTimeout() {
    _logger.warning(
      'getUserMedia blocked for ${_getUserMediaPushKitTimeout.inSeconds}s — aborting to stay within PushKit deadline',
    );
    throw TimeoutException('getUserMedia timeout', _getUserMediaPushKitTimeout);
  }
}
