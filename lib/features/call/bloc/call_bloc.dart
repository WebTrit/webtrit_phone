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

import '../extensions/extensions.dart';
import '../models/models.dart';
import '../utils/utils.dart';

export 'package:webtrit_callkeep/webtrit_callkeep.dart' show CallkeepHandle, CallkeepHandleType;

part 'call_bloc.freezed.dart';

part 'call_event.dart';

part 'call_state.dart';

part 'platform_bridge.dart';

part 'signaling_module.dart';

part 'call_session.dart';

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

class CallBloc extends Bloc<CallEvent, CallState> with WidgetsBindingObserver, _PlatformBridgeMixin {
  final String coreUrl;
  final String tenantId;
  final String token;
  final TrustedCertificates trustedCertificates;

  final CallLogsRepository callLogsRepository;
  final CallPullRepository callPullRepository;
  final UserRepository userRepository;
  final LinesStateRepository linesStateRepository;
  final PresenceInfoRepository presenceInfoRepository;
  final PresenceSettingsRepository presenceSettingsRepository;
  @override
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
  final bool sipPresenceEnabled;
  final VoidCallback? onCallEnded;
  final OnDiagnosticReportRequested onDiagnosticReportRequested;

  StreamSubscription<List<ConnectivityResult>>? _connectivityChangedSubscription;

  late final SignalingClientFactory _signalingClientFactory;
  WebtritSignalingClient? _signalingClient;
  Timer? _signalingClientReconnectTimer;

  late final PeerConnectionManagerProtocol _peerConnectionManager;
  late final CallHistoryRecorder _callHistoryRecorder;
  late final PresenceSyncService _presenceSyncService;
  final AudioDeviceManager _audioDeviceManager = AudioDeviceManager();

  late final WebtritCallkeepSound _callkeepSound;

  CallBloc({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    required this.trustedCertificates,
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
    SignalingClientFactory signalingClientFactory = defaultSignalingClientFactory,
    required PeerConnectionManagerProtocol peerConnectionManager,
    this.onCallEnded,
    WebtritCallkeepSound? callkeepSound,
  }) : super(const CallState()) {
    _callkeepSound = callkeepSound ?? WebtritCallkeepSound();
    _signalingClientFactory = signalingClientFactory;
    _peerConnectionManager = peerConnectionManager;
    _callHistoryRecorder = CallHistoryRecorder(repository: callLogsRepository);
    _presenceSyncService = sipPresenceEnabled
        ? LivePresenceSyncService(
            settingsRepository: presenceSettingsRepository,
            signalingClientProvider: () => _signalingClient,
            isReady: () => state.callServiceState.status == CallStatus.ready,
          )
        : const PresenceSyncService.disabled();

    on<CallStarted>(_onCallStarted, transformer: sequential());
    on<_AppLifecycleStateChanged>(_onAppLifecycleStateChanged, transformer: sequential());
    on<_ConnectivityResultChanged>(_onConnectivityResultChanged, transformer: sequential());
    on<_NavigatorMediaDevicesChange>(_onNavigatorMediaDevicesChange, transformer: debounce());
    on<_RegistrationChange>(_onRegistrationChange, transformer: droppable());
    on<_ResetStateEvent>(_onResetStateEvent, transformer: droppable());
    on<_SignalingClientEvent>((e, emit) => _onSignalingClientEvent(e, emit), transformer: restartable());
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
    on<_CallPerformEvent>((e, emit) => _onCallPerformEvent(e, emit), transformer: sequential());
    on<_PeerConnectionEvent>((e, emit) => _onPeerConnectionEvent(e, emit), transformer: sequential());
    on<CallScreenEvent>(_onCallScreenEvent, transformer: sequential());
    on<CallConfigEvent>(_onConfigEvent, transformer: sequential());

    attachMediaDeviceObserver();

    WidgetsBinding.instance.addObserver(this);

    callkeep.setDelegate(this);

    _presenceSyncService.start();
  }

  @override
  Future<void> close() async {
    callkeep.setDelegate(null);

    // Fail any perform-event futures that the native side is still awaiting.
    // Without this, CallKit/ConnectionService can hang indefinitely if close()
    // is called while a performStartCall/performAnswerCall/performEndCall is
    // in-flight but not yet processed by the BLoC event loop.
    _drainPendingPerformEvents();

    WidgetsBinding.instance.removeObserver(this);

    detachMediaDeviceObserver();

    await _connectivityChangedSubscription?.cancel();

    _signalingClientReconnectTimer?.cancel();

    _presenceSyncService.stop();

    await _signalingClient?.disconnect();

    await _stopRingbackSound();

    await _peerConnectionManager.dispose();

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

    // Update the signaling status in Callkeep to ensure proper call handling when the app is minimized or in the background
    callkeepConnections.updateActivitySignalingStatus(
      change.nextState.callServiceState.signalingClientStatus.toCallkeepSignalingStatus(),
    );

    // TODO: add detailed explanation of the following code and why it is necessary to initialize signaling client in background
    if (change.currentState.isActive != change.nextState.isActive) {
      final appLifecycleState = change.nextState.currentAppLifecycleState;
      final appInactive =
          appLifecycleState == AppLifecycleState.paused ||
          appLifecycleState == AppLifecycleState.detached ||
          appLifecycleState == AppLifecycleState.inactive;
      final hasActiveCalls = change.nextState.isActive;
      final connected = _signalingClient != null;

      if (appInactive) {
        if (hasActiveCalls && !connected) {
          _reconnectInitiated(delay: kSignalingClientFastReconnectDelay, force: true);
        }
        if (!hasActiveCalls && connected) {
          _disconnectInitiated();
        }
      }
    }

    final currentActiveCallUuids = Set.from(change.currentState.activeCalls.map((e) => e.callId));
    final nextActiveCallUuids = Set.from(change.nextState.activeCalls.map((e) => e.callId));

    for (final removeUuid in currentActiveCallUuids.difference(nextActiveCallUuids)) {
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

  void _handleCallLifecycleTransitions({
    required List<ActiveCall> previousCalls,
    required List<ActiveCall> currentCalls,
  }) {
    _audioDeviceManager.handleCallListChange(wasEmpty: previousCalls.isEmpty, isEmpty: currentCalls.isEmpty);
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

    _reconnectInitiated(delay: Duration.zero);

    WebRTC.initialize(options: webRtcOptionsBuilder?.build());
  }

  Future<void> _onAppLifecycleStateChanged(_AppLifecycleStateChanged event, Emitter<CallState> emit) async {
    final appLifecycleState = event.state;
    _logger.fine('_onAppLifecycleStateChanged: $appLifecycleState');

    emit(state.copyWith(currentAppLifecycleState: appLifecycleState));

    if (appLifecycleState == AppLifecycleState.paused || appLifecycleState == AppLifecycleState.detached) {
      if (state.isActive == false) _disconnectInitiated();
    } else if (appLifecycleState == AppLifecycleState.resumed) {
      _reconnectInitiated();
    }
  }

  Future<void> _onConnectivityResultChanged(_ConnectivityResultChanged event, Emitter<CallState> emit) async {
    final connectivityResult = event.result;
    _logger.fine('_onConnectivityResultChanged: $connectivityResult');
    if (connectivityResult == ConnectivityResult.none) {
      _disconnectInitiated();
    } else {
      _reconnectInitiated();
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

    try {
      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(processingStatus: CallProcessingStatus.disconnecting);
        }),
      );

      await state.performOnActiveCall(event.callId, (activeCall) async {
        // Retrieve PC via manager and close it
        await _peerConnectionManager.disposePeerConnection(activeCall.callId);

        await callkeep.reportEndCall(
          activeCall.callId,
          activeCall.displayName ?? activeCall.handle.value,
          CallkeepEndCallReason.remoteEnded,
        );
        await activeCall.localStream?.dispose();
      });
      emit(state.copyWithPopActiveCall(event.callId));
    } catch (e) {
      _logger.warning('__onResetStateEventCompleteCall: $e');
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

    final peerConnection = await _peerConnectionManager.retrieve(event.callId);
    if (peerConnection == null) return;

    try {
      // Capture new audio and video pair together to avoid time sync issues
      // and avoid storing separate audio and video tracks to control them on mute, camera switch etc
      final newLocalStream = await userMediaBuilder.build(video: true, frontCamera: activeCall.frontCamera);

      final newAudioTrack = newLocalStream.getAudioTracks().firstOrNull;
      final newVideoTrack = newLocalStream.getVideoTracks().firstOrNull;

      final senders = await peerConnection.getSenders();
      final audioSender = senders.firstWhereOrNull((s) => s.track?.kind == 'audio');
      final videoSender = senders.firstWhereOrNull((s) => s.track?.kind == 'video');

      /// Replace audio/video tracks using existing senders to avoid adding new m= lines
      ///
      /// Alternatively, you can use (remove || stop) + add tracks flow
      /// but it has weak support on infrastructure level:
      /// - second audio m= line causes problems with call recordings and music on hold
      /// - second video m= line causes empty video stream
      ///
      /// So for best compatibility, use existing senders and control them via .enabled or .replaceTrack
      if (audioSender != null && newAudioTrack != null) {
        await audioSender.replaceTrack(newAudioTrack);
      } else if (newAudioTrack != null) {
        final audioSenderResult = await peerConnection.safeAddTrack(newAudioTrack, newLocalStream);
        _checkSenderResult(audioSenderResult, 'audio');
      }

      if (videoSender != null && newVideoTrack != null) {
        await videoSender.replaceTrack(newVideoTrack);
      } else if (newVideoTrack != null) {
        final videoSenderResult = await peerConnection.safeAddTrack(newVideoTrack, newLocalStream);
        _checkSenderResult(videoSenderResult, 'video');
      }

      emit(
        state.copyWithMappedActiveCall(event.callId, (call) => call.copyWith(localStream: newLocalStream, video: true)),
      );

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
        _peerConnectionManager.updateConfig(monitorCheckInterval: interval);
    }
  }

  // WidgetsBindingObserver

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _logger.finer('didChangeAppLifecycleState: $state');
    add(_AppLifecycleStateChanged(state));
  }
}
