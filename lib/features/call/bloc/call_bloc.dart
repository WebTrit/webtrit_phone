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

part 'call_observers.dart';
part 'call_lifecycle.dart';
part 'call_control.dart';

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
    with WidgetsBindingObserver, _PlatformBridgeMixin
    implements SignalingModuleDelegate {
  @override
  final String coreUrl;
  @override
  final String tenantId;
  @override
  final String token;
  @override
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

  late final SignalingModule _signalingModule;

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
    _signalingModule = SignalingModule(delegate: this, signalingClientFactory: signalingClientFactory);
    _peerConnectionManager = peerConnectionManager;
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
    on<_CallPerformEvent>((e, emit) => _onCallPerformEvent(e, emit), transformer: sequential());
    on<_PeerConnectionEvent>((e, emit) => _onPeerConnectionEvent(e, emit), transformer: sequential());
    on<CallScreenEvent>(_onCallScreenEvent, transformer: sequential());
    on<CallConfigEvent>(_onConfigEvent, transformer: sequential());

    attachMediaDeviceObserver();

    WidgetsBinding.instance.addObserver(this);

    callkeep.setDelegate(this);

    // Start presence sync at construction time so subscription negotiation
    // begins as early as possible. The underlying signalingClientProvider
    // returns null until the first successful connect, which the service
    // handles gracefully. The connectivity subscription is established
    // later in _onCallStarted, so presence sync may no-op until then.
    _presenceSyncService.start();
  }

  @override
  Future<void> close() async {
    callkeep.setDelegate(null);

    // Cancel connectivity subscription first to prevent _ConnectivityResultChanged
    // events from reaching the event loop (and triggering reconnect/disconnect)
    // between draining perform events and super.close().
    await _connectivityChangedSubscription?.cancel();

    // Fail any perform-event futures that the native side is still awaiting.
    // Without this, CallKit/ConnectionService can hang indefinitely if close()
    // is called while a performStartCall/performAnswerCall/performEndCall is
    // in-flight but not yet processed by the BLoC event loop.
    _drainPendingPerformEvents();

    WidgetsBinding.instance.removeObserver(this);

    detachMediaDeviceObserver();

    _presenceSyncService.stop();

    await _signalingModule.dispose();

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

  // WidgetsBindingObserver

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _logger.finer('didChangeAppLifecycleState: $state');
    add(_AppLifecycleStateChanged(state));
  }
}
