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
import 'package:ssl_certificates/ssl_certificates.dart';
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

import '../bridge/platform_bridge.dart';
import '../bridge/platform_event.dart';
import '../extensions/extensions.dart';
import '../models/models.dart';
import '../utils/utils.dart';

export 'package:webtrit_callkeep/webtrit_callkeep.dart' show CallkeepHandle, CallkeepHandleType;

part 'call_bloc.freezed.dart';

part 'call_event.dart';

part 'call_state.dart';

part '../utils/signaling_module.dart';

part '../utils/call_session.dart';

part 'transfer_coordinator.dart';

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

class CallBloc extends Bloc<CallEvent, CallState>
    with WidgetsBindingObserver
    implements SignalingModuleDelegate, _CallSessionDelegate, _TransferCoordinatorDelegate {
  final CallLogsRepository callLogsRepository;
  final CallPullRepository callPullRepository;
  final UserRepository userRepository;
  final LinesStateRepository linesStateRepository;
  final PresenceInfoRepository presenceInfoRepository;
  final PresenceSettingsRepository presenceSettingsRepository;
  final Function(Notification) submitNotification;

  /// Callback invoked when the signaling client reports a critical session error
  /// (e.g. [SignalingDisconnectCode.sessionMissedError]), indicating the
  /// current session is no longer valid on the server.
  final SignalingSessionInvalidatedCallback onSessionInvalidated;

  @override
  final Callkeep callkeep;
  final CallkeepConnections callkeepConnections;

  @override
  final SDPMunger? sdpMunger;
  @override
  final SdpSanitizer? sdpSanitizer;
  final WebrtcOptionsBuilder? webRtcOptionsBuilder;
  @override
  final IceFilter? iceFilter;
  @override
  final UserMediaBuilder userMediaBuilder;
  final PeerConnectionPolicyApplier? peerConnectionPolicyApplier;
  final ContactNameResolver contactNameResolver;
  @override
  final CallErrorReporter callErrorReporter;
  final bool sipPresenceEnabled;
  final VoidCallback? onCallEnded;
  final OnDiagnosticReportRequested onDiagnosticReportRequested;

  final PlatformBridge platform;

  StreamSubscription<PlatformEvent>? _platformSub;
  StreamSubscription<List<ConnectivityResult>>? _connectivityChangedSubscription;

  late final SignalingModule _signalingModule;
  late final CallSessionManager _callSession;
  late final TransferCoordinatorImpl _transfer;

  late final CallHistoryRecorder _callHistoryRecorder;
  late final PresenceSyncService _presenceSyncService;
  final AudioDeviceManager _audioDeviceManager = AudioDeviceManager();

  late final WebtritCallkeepSound _callkeepSound;

  CallBloc({
    required this.platform,
    required SignalingModule signalingModule,
    required this.callLogsRepository,
    required this.callPullRepository,
    required this.linesStateRepository,
    required this.presenceInfoRepository,
    required this.presenceSettingsRepository,
    required this.onSessionInvalidated,
    required this.userRepository,
    required this.submitNotification,
    required this.callkeep,
    required this.callkeepConnections,
    required this.userMediaBuilder,
    required this.contactNameResolver,
    required this.callErrorReporter,
    required this.sipPresenceEnabled,
    required this.onDiagnosticReportRequested,
    this.sdpMunger,
    this.sdpSanitizer,
    this.webRtcOptionsBuilder,
    this.iceFilter,
    this.peerConnectionPolicyApplier,
    required CallSessionManager callSession,
    required TransferCoordinatorImpl transfer,
    this.onCallEnded,
    WebtritCallkeepSound? callkeepSound,
  }) : super(const CallState()) {
    _callkeepSound = callkeepSound ?? WebtritCallkeepSound();
    _signalingModule = signalingModule.._delegate = this;
    _callSession = callSession.._delegate = this;
    _transfer = transfer.._delegate = this;
    _callHistoryRecorder = CallHistoryRecorder(repository: callLogsRepository);
    _presenceSyncService = sipPresenceEnabled
        ? LivePresenceSyncService(
            settingsRepository: presenceSettingsRepository,
            signalingClientProvider: () => _signalingModule.signalingClient,
            isReady: () => state.callServiceState.status == CallStatus.ready,
          )
        : const PresenceSyncService.disabled();

    on<CallStarted>(_onCallStarted, transformer: sequential());
    on<_AppLifecycleStateChanged>(_onAppLifecycleStateChanged, transformer: sequential());
    on<_ConnectivityResultChanged>(_onConnectivityResultChanged, transformer: sequential());
    on<_NavigatorMediaDevicesChange>(_onNavigatorMediaDevicesChange, transformer: debounce());
    on<_RegistrationChange>(_onRegistrationChange, transformer: droppable());
    on<_ResetStateEvent>(_onResetStateEvent, transformer: droppable());
    on<_SignalingClientEvent>(
      (e, emit) => switch (e) {
        _SignalingClientEventConnectInitiated() => _signalingModule.performConnect(emit.call, () => emit.isDone),
        _SignalingClientEventDisconnectInitiated() => _signalingModule.performDisconnect(emit.call, () => emit.isDone),
        _SignalingClientEventDisconnected() => _signalingModule.handleDisconnected(
          e.code,
          e.reason,
          emit.call,
          () => emit.isDone,
        ),
      },
      transformer: restartable(),
    );
    on<_HandshakeSignalingEventState>((e, emit) => _onHandshakeSignalingEventState(e, emit), transformer: sequential());
    on<_CallSignalingEvent>((e, emit) => _onCallSignalingEvent(e, emit), transformer: sequential());
    on<_CallPushEventIncoming>(_onCallPushEventIncoming, transformer: sequential());
    on<CallControlEvent>(
      _onCallControlEvent,
      transformer: (events, mapper) => StreamGroup.merge([
        droppable<CallControlEvent>().call(events.where((e) => e is _CallControlEventStarted), mapper),
        sequential<CallControlEvent>().call(events.where((e) => e is! _CallControlEventStarted), mapper),
      ]),
    );
    on<_CallPerformEvent>((e, emit) => _callSession.onCallPerformEvent(e, emit), transformer: sequential());
    on<_PeerConnectionEvent>((e, emit) => _callSession.onPeerConnectionEvent(e, emit), transformer: sequential());
    on<CallScreenEvent>(_onCallScreenEvent, transformer: sequential());
    on<CallConfigEvent>(_onConfigEvent, transformer: sequential());

    _platformSub = platform.events.listen(_onPlatformEvent);

    attachMediaDeviceObserver();

    WidgetsBinding.instance.addObserver(this);

    // Start presence sync at construction time so subscription negotiation
    // begins as early as possible. The underlying signalingClientProvider
    // returns null until the first successful connect, which the service
    // handles gracefully. The connectivity subscription is established
    // later in _onCallStarted, so presence sync may no-op until then.
    _presenceSyncService.start();
  }

  @override
  Future<void> close() async {
    // Cancel connectivity subscription first to prevent _ConnectivityResultChanged
    // events from reaching the event loop (and triggering reconnect/disconnect)
    // between platform disposal and super.close().
    await _connectivityChangedSubscription?.cancel();

    // Stop receiving native platform callbacks and fail any pending perform-event
    // futures so that CallKit/ConnectionService does not hang on teardown.
    await _platformSub?.cancel();
    platform.dispose();

    WidgetsBinding.instance.removeObserver(this);

    detachMediaDeviceObserver();

    _presenceSyncService.stop();

    await _signalingModule.dispose();

    await _callkeepSound.stopRingbackSound();

    await _callSession.peerConnectionManager.dispose();

    await super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    _logger.warning('onError', error, stackTrace);
    // TODO: analise error and finalize necessary active call
  }

  @visibleForTesting
  void attachMediaDeviceObserver() {
    navigator.mediaDevices.ondevicechange = (event) {
      add(const _NavigatorMediaDevicesChange());
    };
  }

  @visibleForTesting
  void detachMediaDeviceObserver() {
    navigator.mediaDevices.ondevicechange = null;
  }

  @override
  void onChange(Change<CallState> change) {
    super.onChange(change);
    _syncCallkeepSignalingStatus(change);
    _handleBackgroundConnectivity(change);
    _syncPeerConnections(change);
    _logProcessingStatusTransitions(change);
    _handleRegistrationChange(change);
    _syncLinesState(change);
    _handleSignalingSessionError(
      previous: change.currentState.callServiceState,
      current: change.nextState.callServiceState,
    );
    _handleCallEndedCallback(change);
    _handleCallLifecycleTransitions(
      previousCalls: change.currentState.activeCalls,
      currentCalls: change.nextState.activeCalls,
    );
  }

  void _syncCallkeepSignalingStatus(Change<CallState> change) {
    callkeepConnections.updateActivitySignalingStatus(
      change.nextState.callServiceState.signalingClientStatus.toCallkeepSignalingStatus(),
    );
  }

  // TODO: add detailed explanation of the following code and why it is necessary to initialize signaling client in background
  void _handleBackgroundConnectivity(Change<CallState> change) {
    if (change.currentState.isActive == change.nextState.isActive) return;

    final appLifecycleState = change.nextState.currentAppLifecycleState;
    final appInactive =
        appLifecycleState == AppLifecycleState.paused ||
        appLifecycleState == AppLifecycleState.detached ||
        appLifecycleState == AppLifecycleState.inactive;
    final hasActiveCalls = change.nextState.isActive;
    final connected = _signalingModule.signalingClient != null;

    if (appInactive) {
      if (hasActiveCalls && !connected) {
        _signalingModule.reconnect(delay: kSignalingClientFastReconnectDelay, force: true);
      }
      if (!hasActiveCalls && connected) {
        _signalingModule.disconnect();
      }
    }
  }

  void _syncPeerConnections(Change<CallState> change) {
    final currentActiveCallUuids = Set.from(change.currentState.activeCalls.map((e) => e.callId));
    final nextActiveCallUuids = Set.from(change.nextState.activeCalls.map((e) => e.callId));

    for (final removeUuid in currentActiveCallUuids.difference(nextActiveCallUuids)) {
      // Disposal is intentionally not awaited to avoid blocking the Bloc processing loop.
      // The PeerConnectionManager implements an internal "disposal barrier" (via _pendingDisposals)
      // which guarantees that any subsequent createPeerConnection() for this CallId will
      // automatically wait for this disposal to finish before proceeding.
      _callSession.peerConnectionManager.disposePeerConnection(removeUuid).catchError((error, stackTrace) {
        _logger.warning('Error disposing peer connection for $removeUuid', error, stackTrace);
      });
    }

    for (final addUuid in nextActiveCallUuids.difference(currentActiveCallUuids)) {
      _callSession.peerConnectionManager.add(addUuid);
    }
  }

  void _logProcessingStatusTransitions(Change<CallState> change) {
    final currentProcessingStatuses = Set.from(
      change.currentState.activeCalls.map((e) => '${e.line}:${e.processingStatus.name}'),
    ).join(', ');
    final nextProcessingStatuses = Set.from(
      change.nextState.activeCalls.map((e) => '${e.line}:${e.processingStatus.name}'),
    ).join(', ');
    if (currentProcessingStatuses != nextProcessingStatuses) {
      _logger.info(() => 'status transitions: $currentProcessingStatuses -> $nextProcessingStatuses');
    }
  }

  /// RegistrationStatus can be null if the signaling state was not yet fully
  /// initialized. This scenario is particularly relevant when a call is
  /// triggered before the app is fully active, such as via
  /// [CallkeepDelegate.continueStartCallIntent] (e.g. from phone recents).
  void _handleRegistrationChange(Change<CallState> change) {
    final newRegistration = change.nextState.callServiceState.registration;
    final previousRegistration = change.currentState.callServiceState.registration;

    if (newRegistration == previousRegistration || newRegistration == null) return;

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

  void _syncLinesState(Change<CallState> change) {
    final linesCount = change.nextState.linesCount;
    final activeCalls = change.nextState.activeCalls;
    final List<LineState> mainLinesState = [];
    for (var i = 0; i < linesCount; i++) {
      final inUse = activeCalls.any((e) => e.line == i);
      mainLinesState.add(inUse ? LineState.inUse : LineState.idle);
    }
    final guestLineInUse = activeCalls.any((e) => e.line == null);
    final guestLineState = guestLineInUse ? LineState.inUse : LineState.idle;

    linesStateRepository.setState(LinesState(mainLines: mainLinesState, guestLine: guestLineState));
  }

  void _handleCallEndedCallback(Change<CallState> change) {
    if (change.nextState.activeCalls.length < change.currentState.activeCalls.length) {
      onCallEnded?.call();
    }
  }

  void _handleCallLifecycleTransitions({
    required List<ActiveCall> previousCalls,
    required List<ActiveCall> currentCalls,
  }) {
    if (previousCalls.isEmpty && currentCalls.isNotEmpty) {
      _audioDeviceManager.onCallStarted(currentCalls.length);
    } else if (previousCalls.isNotEmpty && currentCalls.isEmpty) {
      _audioDeviceManager.onCallEnded(currentCalls.length);
    }
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
    } on Error {
      rethrow;
    } catch (e, st) {
      _logger.warning('Unexpected error during account info refresh', e, st);
    }
  }

  // SignalingModuleDelegate implementation

  @override
  CallState get currentState => state;

  @override
  bool get isModuleClosed => isClosed;

  @override
  void requestConnect() => add(const _SignalingClientEvent.connectInitiated());

  @override
  void requestDisconnect() => add(const _SignalingClientEvent.disconnectInitiated());

  @override
  void notifyDisconnected(int? code, String? reason) => add(_SignalingClientEvent.disconnected(code, reason));

  @override
  void onStateHandshake(StateHandshake stateHandshake) {
    add(
      _HandshakeSignalingEventState(registration: stateHandshake.registration, linesCount: stateHandshake.lines.length),
    );
    unawaited(
      _assignUserActiveCalls(stateHandshake.userActiveCalls).catchError((e, s) {
        _logger.severe('onStateHandshake _assignUserActiveCalls error', e, s);
      }),
    );
    stateHandshake.contactsPresenceInfo.forEach((number, data) {
      unawaited(
        _assignNumberPresence(number, data).catchError((e, s) {
          _logger.severe('onStateHandshake _assignNumberPresence error', e, s);
        }),
      );
    });
    unawaited(
      _processHandshakeAsync(stateHandshake).catchError((e, s) {
        _logger.severe('onStateHandshake _processHandshakeAsync error', e, s);
      }),
    );
  }

  @override
  void onSignalingEvent(Event event) => _onSignalingEventMapper(event);

  @override
  void dispatchRegistrationChange(RegistrationStatus status, {int? code, String? reason}) =>
      add(_CallSignalingEvent.registration(status, code: code, reason: reason));

  @override
  void dispatchCompleteCall(String callId) => add(_ResetStateEvent.completeCall(callId));

  @override
  void showNotification(Notification notification) => submitNotification(notification);

  // _CallSessionDelegate implementation

  @override
  Stream<CallState> get stateStream => stream;

  @override
  bool get isSessionClosed => isClosed;

  @override
  void addCallSessionEvent(CallEvent event) => add(event);

  @override
  SignalingModule get signalingModule => _signalingModule;

  @override
  CallHistoryRecorder get callHistoryRecorder => _callHistoryRecorder;

  @override
  WebtritCallkeepSound get callkeepSound => _callkeepSound;

  // _TransferCoordinatorDelegate implementation

  @override
  void addTransferCallEvent(CallEvent event) => add(event);

  // Helpers used by signaling_module.dart (part of the same library).

  Future<void> _playRingbackSound() => _callkeepSound.playRingbackSound();

  Future<void> _stopRingbackSound() => _callkeepSound.stopRingbackSound();

  void _addToRecents(ActiveCall activeCall) {
    _callHistoryRecorder.record((
      direction: activeCall.direction,
      number: activeCall.handle.value,
      video: activeCall.video,
      username: activeCall.displayName,
      createdTime: activeCall.createdTime,
      acceptedTime: activeCall.acceptedTime,
      hungUpTime: activeCall.hungUpTime,
    ));
  }

  // PlatformBridge stream subscription handler — translates public PlatformEvent
  // types into private library-internal BLoC events.

  void _onPlatformEvent(PlatformEvent event) {
    switch (event) {
      case StartCallIntentPlatformEvent():
        unawaited(_processContinueStartCallIntent(event));
      case PushIncomingCallPlatformEvent():
        add(
          _CallPushEventIncoming(
            callId: event.callId,
            handle: event.handle,
            displayName: event.displayName,
            video: event.video,
            error: event.error,
          ),
        );
      case StartCallPerformEvent():
        final perform = _CallPerformEvent.started(
          event.callId,
          handle: event.handle,
          displayName: event.displayName,
          video: event.video,
        );
        unawaited(perform.future.then(event.complete));
        add(perform);
      case AnswerCallPerformEvent():
        final perform = _CallPerformEvent.answered(event.callId);
        unawaited(perform.future.then(event.complete));
        add(perform);
      case EndCallPerformEvent():
        final perform = _CallPerformEvent.ended(event.callId);
        unawaited(perform.future.then(event.complete));
        add(perform);
      case SetHeldPerformEvent():
        final perform = _CallPerformEvent.setHeld(event.callId, event.onHold);
        unawaited(perform.future.then(event.complete));
        add(perform);
      case SetMutedPerformEvent():
        final perform = _CallPerformEvent.setMuted(event.callId, event.muted);
        unawaited(perform.future.then(event.complete));
        add(perform);
      case SendDtmfPerformEvent():
        final perform = _CallPerformEvent.sentDTMF(event.callId, event.key);
        unawaited(perform.future.then(event.complete));
        add(perform);
      case AudioDeviceSetPerformEvent():
        final perform = _CallPerformEvent.audioDeviceSet(event.callId, CallAudioDevice.fromCallkeep(event.device));
        unawaited(perform.future.then(event.complete));
        add(perform);
      case AudioDevicesUpdatePerformEvent():
        final perform = _CallPerformEvent.audioDevicesUpdate(
          event.callId,
          event.devices.map(CallAudioDevice.fromCallkeep).toList(),
        );
        unawaited(perform.future.then(event.complete));
        add(perform);
    }
  }

  Future<void> _processContinueStartCallIntent(StartCallIntentPlatformEvent event) async {
    _logger.fine(
      () => StringBuffer()
        ..write('_processContinueStartCallIntent - Attempting to start call')
        ..write(' handle: ${event.handle}')
        ..write(' displayName: ${event.displayName}')
        ..write(' video: ${event.video}')
        ..write(' isHandshakeActive: ${state.isHandshakeEstablished}')
        ..write(' isSignalingActive: ${state.isSignalingEstablished}'),
    );

    try {
      final resolvedState = await stream
          .firstWhere((s) => s.isHandshakeEstablished && s.isSignalingEstablished)
          .timeout(kSignalingClientConnectionTimeout);

      if (isClosed) return;

      _logger.fine(
        () => StringBuffer()
          ..write('_processContinueStartCallIntent - Signaling and handshake are now active for')
          ..write(' handle: ${event.handle}')
          ..write(' displayName: ${event.displayName}')
          ..write(' video: ${event.video}')
          ..write(' isHandshakeActive: ${resolvedState.isHandshakeEstablished}')
          ..write(' isSignalingActive: ${resolvedState.isSignalingEstablished}'),
      );

      add(
        CallControlEvent.started(
          generic: event.handle.isGeneric ? event.handle.value : null,
          number: event.handle.isNumber ? event.handle.value : null,
          email: event.handle.isEmail ? event.handle.value : null,
          displayName: event.displayName,
          video: event.video,
        ),
      );
    } on TimeoutException {
      if (isClosed) return;

      _logger.warning(
        () => StringBuffer()
          ..write('_processContinueStartCallIntent - Failed to start call')
          ..write(' handle: ${event.handle}')
          ..write(' (Signaling/handshake connection timed out after ${kSignalingClientConnectionTimeout.inSeconds}s)')
          ..write(' isHandshakeActive: ${state.isHandshakeEstablished}')
          ..write(' isSignalingActive: ${state.isSignalingEstablished}'),
      );

      submitNotification(const SignalingConnectFailedNotification());
    } catch (e, s) {
      if (isClosed) return;

      _logger.severe(
        () => StringBuffer()
          ..write('_processContinueStartCallIntent - An unexpected error occurred')
          ..write(' handle: ${event.handle}'),
        e,
        s,
      );

      submitNotification(ErrorMessageNotification(e.toString()));
    }
  }

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

    _signalingModule.reconnect(delay: Duration.zero);

    WebRTC.initialize(options: webRtcOptionsBuilder?.build());
  }

  Future<void> _onAppLifecycleStateChanged(_AppLifecycleStateChanged event, Emitter<CallState> emit) async {
    final appLifecycleState = event.state;
    _logger.fine('_onAppLifecycleStateChanged: $appLifecycleState');

    emit(state.copyWith(currentAppLifecycleState: appLifecycleState));

    if (appLifecycleState == AppLifecycleState.paused || appLifecycleState == AppLifecycleState.detached) {
      if (state.isActive == false) _signalingModule.disconnect();
    } else if (appLifecycleState == AppLifecycleState.resumed) {
      _signalingModule.reconnect();
    }
  }

  Future<void> _onConnectivityResultChanged(_ConnectivityResultChanged event, Emitter<CallState> emit) async {
    final connectivityResult = event.result;
    _logger.fine('_onConnectivityResultChanged: $connectivityResult');
    if (connectivityResult == ConnectivityResult.none) {
      _signalingModule.disconnect();
    } else {
      _signalingModule.reconnect();
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
      // Skip outgoing calls not yet accepted — they are waiting for performStartCall
      // to run, which will check registration and emit the appropriate notification.
      // This mirrors the guard in _processHandshakeAsync that preserves the same calls.
      if (element.direction == CallDirection.outgoing && element.acceptedTime == null && element.hungUpTime == null) {
        continue;
      }
      add(_ResetStateEvent.completeCall(element.callId));
    }
  }

  Future<void> __onResetStateEventCompleteCall(_ResetStateEventCompleteCall event, Emitter<CallState> emit) async {
    _logger.warning('__onResetStateEventCompleteCall: ${event.callId}');

    try {
      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(processingStatus: CallProcessingStatus.disconnecting);
        }),
      );

      await state.performOnActiveCall(event.callId, (activeCall) async {
        // Retrieve PC via manager and close it
        await _callSession.peerConnectionManager.disposePeerConnection(activeCall.callId);

        await callkeep.reportEndCall(
          activeCall.callId,
          activeCall.displayName ?? activeCall.handle.value,
          CallkeepEndCallReason.remoteEnded,
        );
        await activeCall.localStream?.dispose();
      });
      emit(state.copyWithPopActiveCall(event.callId));
    } on Error {
      rethrow;
    } catch (e, s) {
      _logger.warning('__onResetStateEventCompleteCall', e, s);
    }
  }

  // processing call push events

  Future<void> _onCallPushEventIncoming(_CallPushEventIncoming event, Emitter<CallState> emit) async {
    final eventError = event.error;
    if (eventError != null) {
      _logger.warning('_onCallPushEventIncoming event.error: $eventError');
      // TODO: implement correct incoming call hangup (take into account that _signalingClient is disconnected)
      return;
    }

    final contactName = await contactNameResolver.resolveWithNumber(event.handle.value);
    final displayName = contactName ?? event.displayName;

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

  // processing call control events

  Future<void> _onCallControlEvent(CallControlEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallControlEventStarted() => __onCallControlEventStarted(event, emit),
      _CallControlEventAnswered() => __onCallControlEventAnswered(event, emit),
      _CallControlEventEnded() => __onCallControlEventEnded(event, emit),
      _CallControlEventSetHeld() => __onCallControlEventSetHeld(event, emit),
      _CallControlEventSetMuted() => __onCallControlEventSetMuted(event, emit),
      _CallControlEventSentDTMF() => __onCallControlEventSentDTMF(event, emit),
      _CallControlEventCameraSwitched() => _callSession.onCameraSwitched(event, emit),
      _CallControlEventCameraEnabled() => _callSession.onCameraEnabled(event, emit),
      _CallControlEventAudioDeviceSet() => _onCallControlEventAudioDeviceSet(event, emit),
      _CallControlEventFailureApproved() => _onCallControlEventFailureApproved(event, emit),
      _CallControlEventBlindTransferInitiated() => _transfer.onBlindTransferInitiated(event.callId, emit),
      _CallControlEventAttendedTransferInitiated() => _transfer.onAttendedTransferInitiated(event.callId, emit),
      _CallControlEventBlindTransferSubmitted() => _transfer.onBlindTransferSubmitted(event.number, emit),
      _CallControlEventAttendedTransferSubmitted() => _transfer.onAttendedTransferSubmitted(
        event.referorCall,
        event.replaceCall,
        emit,
      ),
      _CallControlEventAttendedRequestApproved() => _transfer.onAttendedRequestApproved(
        event.referId,
        event.referTo,
        emit,
      ),
      _CallControlEventAttendedRequestDeclined() => _transfer.onAttendedRequestDeclined(
        event.callId,
        event.referId,
        emit,
      ),
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
      _logger.info('__onCallControlEventAnswered: skipping due stale status: ${call.processingStatus}');
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
        add(CallControlEvent.audioDeviceSet(currentCall.callId, state.availableAudioDevices.getSpeaker));
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
        _callSession.peerConnectionManager.updateConfig(monitorCheckInterval: interval);
    }
  }

  // WidgetsBindingObserver

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _logger.finer('didChangeAppLifecycleState: $state');
    add(_AppLifecycleStateChanged(state));
  }

  // Processing handshake signaling events

  Future<void> _onHandshakeSignalingEventState(_HandshakeSignalingEventState event, Emitter<CallState> emit) async {
    emit(state.copyWith(linesCount: event.linesCount));

    add(_RegistrationChange(registration: event.registration));
  }

  // Processing call signaling events

  Future<void> _onCallSignalingEvent(_CallSignalingEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallSignalingEventIncoming() => __onCallSignalingEventIncoming(event, emit),
      _CallSignalingEventRinging() => __onCallSignalingEventRinging(event, emit),
      _CallSignalingEventProgress() => __onCallSignalingEventProgress(event, emit),
      _CallSignalingEventAccepted() => __onCallSignalingEventAccepted(event, emit),
      _CallSignalingEventHangup() => __onCallSignalingEventHangup(event, emit),
      _CallSignalingEventUpdating() => __onCallSignalingEventUpdating(event, emit),
      _CallSignalingEventUpdated() => __onCallSignalingEventUpdated(event, emit),
      _CallSignalingEventTransfer() => __onCallSignalingEventTransfer(event, emit),
      _CallSignalingEventTransferring() => __onCallSignalingEventTransfering(event, emit),
      _CallSignalingEventNotifyDialog() => __onCallSignalingEventNotifyDialog(event, emit),
      _CallSignalingEventNotifyRefer() => __onCallSignalingEventNotifyRefer(event, emit),
      _CallSignalingEventNotifyPresence() => __onCallSignalingEventNotifyPresence(event, emit),
      _CallSignalingEventNotifyUnknown() => __onCallSignalingEventNotifyUnknown(event, emit),
      _CallSignalingEventRegistration() => __onCallSignalingEventRegistration(event, emit),
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
      _logger.warning('__onCallSignalingEventIncoming reportNewIncomingCall error: $error');
      // TODO: implement correct incoming call hangup (take into account that _signalingModule.signalingClient could be disconnected)
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
      final peerConnection = await _callSession.peerConnectionManager.retrieve(event.callId);
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
    }

    emit(state.copyWithMappedActiveCall(event.callId, (_) => call!));

    final peerConnection = await _callSession.peerConnectionManager.retrieve(event.callId);
    if (jsep != null && peerConnection != null) {
      final remoteDescription = jsep.toDescription();
      sdpSanitizer?.apply(remoteDescription);
      await peerConnection.setRemoteDescription(remoteDescription);
    }
  }

  Future<void> __onCallSignalingEventHangup(_CallSignalingEventHangup event, Emitter<CallState> emit) async {
    final code = SignalingResponseCode.values.byCode(event.code);
    _logger.fine('__onCallSignalingEventHangup code: ${code?.name} ${code?.code} ${code?.type.name}');

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
        break;
      default:
        final signalingHangupException = SignalingHangupFailure(code);
        final defaultErrorNotification = DefaultErrorNotification(signalingHangupException);
        submitNotification(defaultErrorNotification);
    }

    try {
      await _stopRingbackSound();

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
        await _callSession.peerConnectionManager.disposePeerConnection(event.callId);

        await call.localStream?.dispose();

        emit(state.copyWithPopActiveCall(event.callId));

        await callkeep.reportEndCall(event.callId, call.displayName ?? call.handle.value, endReason);
      }
    } on Error {
      rethrow;
    } catch (e, s) {
      _logger.warning('__onCallSignalingEventHangup', e, s);
    }
  }

  Future<void> __onCallSignalingEventUpdating(_CallSignalingEventUpdating event, Emitter<CallState> emit) async {
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
          final peerConnection = await _callSession.peerConnectionManager.retrieve(event.callId);
          if (peerConnection == null) {
            _logger.warning('__onCallSignalingEventUpdating: peerConnection is null - most likely some state issue');
          } else {
            await peerConnectionPolicyApplier?.apply(peerConnection, hasRemoteVideo: jsep.hasVideo);
            await peerConnection.setRemoteDescription(remoteDescription);
            final localDescription = await peerConnection.createAnswer({});
            sdpMunger?.apply(localDescription);

            // According to RFC 8829 5.6 (https://datatracker.ietf.org/doc/html/rfc8829#section-5.6),
            // localDescription should be set before sending the answer to transition into stable state.
            await peerConnection.setLocalDescription(localDescription);

            await _signalingModule.signalingClient?.execute(
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
    } on Error {
      rethrow;
    } catch (e, s) {
      callErrorReporter.handle(e, s, '__onCallSignalingEventUpdating && jsep error:');

      _callSession.peerConnectionManager.completeError(event.callId, e);
      add(_ResetStateEvent.completeCall(event.callId));
    }
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

  Future<void> __onCallSignalingEventNotifyDialog(
    _CallSignalingEventNotifyDialog event,
    Emitter<CallState> emit,
  ) async {
    _logger.fine('_CallSignalingEventNotifyDialogs: $event');
    await _assignUserActiveCalls(event.userActiveCalls);
  }

  Future<void> __onCallSignalingEventNotifyPresence(
    _CallSignalingEventNotifyPresence event,
    Emitter<CallState> emit,
  ) async {
    _logger.fine('_CallSignalingEventNotifyPresence: $event');
    await _assignNumberPresence(event.number, event.presenceInfo);
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

  // TODO(Vlad): extract mapper, find better naming
  Future<void> _assignUserActiveCalls(List<UserActiveCall> userActiveCalls) async {
    final pullableCalls = userActiveCalls
        .map(
          (call) => PullableCall(
            id: call.id,
            state: PullableCallState.values.byName(call.state.name),
            callId: call.callId,
            localTag: call.localTag,
            remoteTag: call.remoteTag,
            remoteNumber: call.remoteNumber,
            remoteDisplayName: call.remoteDisplayName,
            direction: PullableCallDirection.values.byName(call.direction.name),
          ),
        )
        .toList();

    List<PullableCall> pullableCallsToSet = [];

    for (final pullableCall in pullableCalls) {
      // Skip calls that are already active
      if (state.activeCalls.any((call) => call.callId == pullableCall.callId)) continue;

      // Resolve contact name for the call's remote number
      final contactName = await contactNameResolver.resolveWithNumber(pullableCall.remoteNumber);
      pullableCallsToSet.add(pullableCall.copyWith(remoteDisplayName: contactName));
    }

    callPullRepository.setPullableCalls(pullableCallsToSet);
  }

  Future<void> _assignNumberPresence(String number, List<SignalingPresenceInfo> data) async {
    final presenceInfo = data.map(SignalingPresenceInfoMapper.fromSignaling).toList();
    presenceInfoRepository.setNumberPresence(number, presenceInfo);
  }

  Future<void> _processHandshakeAsync(StateHandshake stateHandshake) async {
    try {
      // Hang up all active calls that are not associated with any line
      // or guest line, indicating that they are no longer valid.
      //
      // This is needed to drop or retain calls after reconnecting to the signaling server
      activeCallsLoop:
      for (final activeCall in state.activeCalls) {
        // Ignore active calls that are already associated with a line or guest line
        //
        // If you have troubles with line position mismatch replace this with
        // following code that deal with it: https://gist.github.com/digiboridev/f7f1020731e8f247b5891983433bd159
        for (final line in [...stateHandshake.lines, stateHandshake.guestLine]) {
          if (line != null && line.callId == activeCall.callId) {
            continue activeCallsLoop;
          }
        }

        // Handles an outgoing active call that has not yet started, typically initiated
        // by the `continueStartCallIntent` callback of `CallkeepDelegate`.
        //
        // TODO: Implement a dedicated flag to confirm successful execution of
        // OutgoingCallRequest, ensuring reliable outgoing active call state tracking.
        if (activeCall.direction == CallDirection.outgoing &&
            activeCall.acceptedTime == null &&
            activeCall.hungUpTime == null) {
          continue activeCallsLoop;
        }

        _callSession.peerConnectionManager.conditionalCompleteError(
          activeCall.callId,
          'Active call Request Terminated',
        );

        add(
          _CallSignalingEvent.hangup(
            line: activeCall.line,
            callId: activeCall.callId,
            code: 487,
            reason: 'Request Terminated',
          ),
        );
      }

      final lines = [...stateHandshake.lines, stateHandshake.guestLine].whereType<Line>();
      final localConnections = await callkeepConnections.getConnections();

      for (final activeLine in lines) {
        // Get the first call event from the call logs, if any
        final callEvent = activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent).firstOrNull;

        if (callEvent != null) {
          // Obtain the corresponding Callkeep connection for the line.
          // Callkeep maintains connection states even if the app's lifecycle has ended.
          final connection = await callkeepConnections.getConnection(callEvent.callId);

          // Check if the Callkeep connection exists and its state is `stateDisconnected`.
          // Indicates that the call has been terminated by the user or system (e.g., due to connectivity issues).
          // Synchronize the signaling state with the local state for such scenarios.
          if (connection?.state == CallkeepConnectionState.stateDisconnected) {
            // Handle outgoing or accepted calls. If the event is `AcceptedEvent` or `ProceedingEvent`,
            // initiate a hang-up request to align the signaling state.
            if (callEvent is AcceptedEvent || callEvent is ProceedingEvent) {
              // Handle outgoing or accepted calls. If the event is `AcceptedEvent` or `ProceedingEvent`,
              // initiate a hang-up request to align the signaling state.
              final hangupRequest = HangupRequest(
                transaction: WebtritSignalingClient.generateTransactionId(),
                line: callEvent.line,
                callId: callEvent.callId,
              );
              final hangupFuture = _signalingModule.signalingClient?.execute(hangupRequest);
              await hangupFuture?.catchError((e, s) {
                callErrorReporter.handle(e, s, '__onCallPerformEventEnded hangupRequest error');
              });

              continue;
            } else if (callEvent is IncomingCallEvent) {
              // Handle incoming calls. If the event is `IncomingCallEvent`, send a decline request to update the signaling state accordingly.
              final declineRequest = DeclineRequest(
                transaction: WebtritSignalingClient.generateTransactionId(),
                line: callEvent.line,
                callId: callEvent.callId,
              );
              final declineFuture = _signalingModule.signalingClient?.execute(declineRequest);
              await declineFuture?.catchError((e, s) {
                callErrorReporter.handle(e, s, '__onCallPerformEventEnded declineRequest error');
              });
              continue;
            }
          }
        }

        if (activeLine.callLogs.length == 1) {
          final singleCallLog = activeLine.callLogs.first;
          if (singleCallLog is CallEventLog && singleCallLog.callEvent is IncomingCallEvent) {
            _onSignalingEventMapper(singleCallLog.callEvent as IncomingCallEvent);
          }
        }
      }

      // Synchronize the signaling state with the local state for calls.
      // If a local connection exists that is not present in the signaling state, end the call to ensure consistency between the local and signaling states.
      for (var connection in localConnections) {
        if (!lines.map((e) => e.callId).contains(connection.callId)) {
          await callkeep.endCall(connection.callId);
        }
      }
    } on Error {
      rethrow;
    } catch (e, s) {
      _logger.severe('_processHandshakeAsync error', e, s);
    }
  }

  void _onSignalingEventMapper(Event event) {
    if (event is IncomingCallEvent) {
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
      add(_CallSignalingEvent.hangup(line: event.line, callId: event.callId, code: event.code, reason: event.reason));
    } else if (event is UpdatingCallEvent) {
      add(
        _CallSignalingEvent.updating(
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
        DialogNotifyEvent event => _CallSignalingEvent.notifyDialog(
          line: event.line,
          callId: event.callId,
          notify: event.notify,
          subscriptionState: event.subscriptionState,
          userActiveCalls: event.userActiveCalls,
        ),
        ReferNotifyEvent event => _CallSignalingEvent.notifyRefer(
          line: event.line,
          callId: event.callId,
          notify: event.notify,
          subscriptionState: event.subscriptionState,
          state: event.state,
        ),
        PresenceNotifyEvent event => _CallSignalingEvent.notifyPresence(
          line: event.line,
          callId: event.callId,
          notify: event.notify,
          subscriptionState: event.subscriptionState,
          number: event.number,
          presenceInfo: event.presenceInfo,
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
      add(
        _CallSignalingEvent.registration(
          RegistrationStatus.registration_failed,
          code: event.code,
          reason: event.reason,
        ),
      );
    } else if (event is UnregisteringEvent) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.unregistering));
    } else if (event is UnregisteredEvent) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.unregistered));
    } else if (event is TransferringEvent) {
      add(_CallSignalingEvent.transferring(line: event.line, callId: event.callId));
    } else {
      _logger.warning('unhandled signaling event $event');
    }
  }
}
