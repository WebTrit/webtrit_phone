import 'dart:async';

import 'package:flutter/widgets.dart' hide Notification;
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/features/call/utils/utils.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'fake_signaling_client.dart';

// ---------------------------------------------------------------------------
// Shared test scenario helpers
// ---------------------------------------------------------------------------

/// Brings the bloc online by simulating an app resume and waiting for the
/// signaling client to connect.
void bringOnline(FakeAsync async, TestCallBloc bloc, FakeSignalingClientFactory factory) {
  bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
  async.flushMicrotasks();
  async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
  async.flushMicrotasks();
  expect(bloc.state.callServiceState.signalingClientStatus, SignalingClientStatus.connect);
}

/// Brings the bloc online and delivers a minimal [StateHandshake].
void bringOnlineWithHandshake(
  FakeAsync async,
  TestCallBloc bloc,
  FakeSignalingClientFactory factory, {
  RegistrationStatus registrationStatus = RegistrationStatus.registered,
  int linesCount = 1,
}) {
  bringOnline(async, bloc, factory);
  factory.client!.simulateHandshake(
    minimalStateHandshake(registrationStatus: registrationStatus, linesCount: linesCount),
  );
  async.flushMicrotasks();
  expect(bloc.state.callServiceState.registration?.status, registrationStatus);
}

/// Simulates an [IncomingCallEvent] and drains the pending 0-duration timer
/// that [__onCallSignalingEventIncoming] defers at its end.
///
/// Without this drain, the BLoC's sequential event queue stays blocked while
/// the incoming-call handler awaits [Future.delayed(Duration.zero)], causing
/// any subsequent events to pile up unprocessed.
void simulateIncoming(
  FakeAsync async,
  FakeSignalingClientFactory factory, {
  int line = 0,
  String callId = 'call-1',
  String callee = 'bob',
  String caller = '123',
  Map<String, dynamic>? jsep,
}) {
  factory.client!.simulateEvent(
    IncomingCallEvent(line: line, callId: callId, callee: callee, caller: caller, jsep: jsep),
  );
  async.flushMicrotasks();
  async.elapse(Duration.zero);
  async.flushMicrotasks();
}

// ---------------------------------------------------------------------------
// Mock declarations
// ---------------------------------------------------------------------------

class MockCallLogsRepository extends Mock implements CallLogsRepository {}

class MockCallPullRepository extends Mock implements CallPullRepository {}

class MockUserRepository extends Mock implements UserRepository {}

class MockLinesStateRepository extends Mock implements LinesStateRepository {}

class MockPresenceInfoRepository extends Mock implements PresenceInfoRepository {}

class MockPresenceSettingsRepository extends Mock implements PresenceSettingsRepository {}

class MockCallkeep extends Mock implements Callkeep {}

class MockCallkeepConnections extends Mock implements CallkeepConnections {}

class MockUserMediaBuilder extends Mock implements UserMediaBuilder {}

class MockContactNameResolver extends Mock implements ContactNameResolver {}

class MockCallErrorReporter extends Mock implements CallErrorReporter {}

class MockPeerConnectionManager extends Mock implements PeerConnectionManagerProtocol {}

class MockWebtritCallkeepSound extends Mock implements WebtritCallkeepSound {}

class MockRTCPeerConnection extends Mock implements RTCPeerConnection {}

class MockMediaStream extends Mock implements MediaStream {}

class MockRTCRtpSender extends Mock implements RTCRtpSender {}

/// A no-op [CallLogsRepository] that silently drops all `add` calls.
///
/// Avoids mocktail `any()` matcher issues with Dart record types.
class _NoOpCallLogsRepository extends Fake implements CallLogsRepository {
  @override
  Future<void> add(NewCall call) async {}
}

// ---------------------------------------------------------------------------
// Test subclass that disables platform-specific side effects
// ---------------------------------------------------------------------------

/// A [CallBloc] subclass that stubs out WebRTC and WidgetsBinding side effects
/// so tests do not depend on native platform code.
class TestCallBloc extends CallBloc {
  TestCallBloc({
    required super.coreUrl,
    required super.tenantId,
    required super.token,
    required super.trustedCertificates,
    required super.callLogsRepository,
    required super.callPullRepository,
    required super.linesStateRepository,
    required super.presenceInfoRepository,
    required super.presenceSettingsRepository,
    required super.onSessionInvalidated,
    required super.userRepository,
    required super.submitNotification,
    required super.callkeep,
    required super.callkeepConnections,
    required super.userMediaBuilder,
    required super.contactNameResolver,
    required super.callErrorReporter,
    required super.sipPresenceEnabled,
    required super.onDiagnosticReportRequested,
    required super.peerConnectionManager,
    super.signalingClientFactory,
    super.onCallEnded,
    super.callkeepSound,
  });

  /// Overridden to prevent calling `navigator.mediaDevices.ondevicechange`
  /// in unit tests (no WebRTC engine available).
  @override
  void attachMediaDeviceObserver() {}

  /// Overridden to prevent calling `navigator.mediaDevices.ondevicechange`
  /// in unit tests.
  @override
  void detachMediaDeviceObserver() {}
}

// ---------------------------------------------------------------------------
// Builder helper
// ---------------------------------------------------------------------------

/// A factory that never resolves, so the bloc stays in `connecting` state.
/// Used when no specific signaling factory is needed for a test.
Future<WebtritSignalingClient> _pendingSignalingFactory({
  required Uri url,
  required String tenantId,
  required String token,
  required Duration connectionTimeout,
  required TrustedCertificates certs,
  required bool force,
}) => Completer<WebtritSignalingClient>().future;

/// Builds a [TestCallBloc] with all dependencies mocked.
///
/// Callers can override individual fields as needed for specific test scenarios.
/// Required stubs for construction side effects are automatically configured.
///
/// Pass [capturedNotifications] to collect submitted [Notification]s for assertions.
/// Pass [contactNameResolver] or [callLogsRepository] to supply pre-configured mocks.
/// Pass [userMediaBuilder] to inject a pre-configured WebRTC media mock.
TestCallBloc buildTestBloc({
  MockCallkeep? callkeep,
  MockCallkeepConnections? callkeepConnections,
  MockPeerConnectionManager? peerConnectionManager,
  MockPresenceSettingsRepository? presenceSettingsRepository,
  MockContactNameResolver? contactNameResolver,
  MockCallLogsRepository? callLogsRepository,
  MockUserMediaBuilder? userMediaBuilder,
  SignalingClientFactory signalingClientFactory = _pendingSignalingFactory,
  bool sipPresenceEnabled = false,
  List<Notification>? capturedNotifications,
}) {
  final mockCallkeep = callkeep ?? MockCallkeep();
  final mockConnections = callkeepConnections ?? MockCallkeepConnections();
  final mockPcm = peerConnectionManager ?? MockPeerConnectionManager();
  final mockPresenceSettings = presenceSettingsRepository ?? MockPresenceSettingsRepository();
  final mockContactNameResolver = contactNameResolver ?? MockContactNameResolver();
  final mockUserMedia = userMediaBuilder ?? MockUserMediaBuilder();
  // Use a no-op fake by default to avoid mocktail `any()` issues with the
  // `NewCall` Dart record typedef.
  final CallLogsRepository mockCallLogs = callLogsRepository ?? _NoOpCallLogsRepository();

  final mockLinesState = MockLinesStateRepository();
  final mockSound = MockWebtritCallkeepSound();
  final mockUserRepository = MockUserRepository();

  // Stub the construction-time and change-time side effects.
  when(() => mockCallkeep.setDelegate(any())).thenReturn(null);
  when(() => mockConnections.updateActivitySignalingStatus(any())).thenAnswer((_) async {});
  when(() => mockConnections.getConnections()).thenAnswer((_) async => []);
  when(() => mockPresenceSettings.resetLastSettingsSync()).thenReturn(null);
  when(() => mockLinesState.setState(any())).thenReturn(null);
  when(() => mockSound.stopRingbackSound()).thenAnswer((_) async {});
  when(() => mockSound.playRingbackSound()).thenAnswer((_) async {});
  when(() => mockPcm.dispose()).thenAnswer((_) async {});
  when(() => mockPcm.disposePeerConnection(any())).thenAnswer((_) async {});
  when(() => mockPcm.add(any())).thenReturn(null);
  when(() => mockPcm.retrieve(any())).thenAnswer((_) async => null);
  when(() => mockContactNameResolver.resolveWithNumber(any())).thenAnswer((_) async => null);
  when(() => mockUserRepository.getRemoteInfo()).thenAnswer((_) async => null);

  final notifications = capturedNotifications ?? <Notification>[];

  return TestCallBloc(
    coreUrl: 'https://example.com',
    tenantId: 'test-tenant',
    token: 'test-token',
    trustedCertificates: TrustedCertificates.empty,
    callLogsRepository: mockCallLogs,
    callPullRepository: MockCallPullRepository(),
    linesStateRepository: mockLinesState,
    presenceInfoRepository: MockPresenceInfoRepository(),
    presenceSettingsRepository: mockPresenceSettings,
    onSessionInvalidated: () {},
    userRepository: mockUserRepository,
    submitNotification: notifications.add,
    callkeep: mockCallkeep,
    callkeepConnections: mockConnections,
    userMediaBuilder: mockUserMedia,
    contactNameResolver: mockContactNameResolver,
    callErrorReporter: MockCallErrorReporter(),
    sipPresenceEnabled: sipPresenceEnabled,
    onDiagnosticReportRequested: (_, _) {},
    peerConnectionManager: mockPcm,
    signalingClientFactory: signalingClientFactory,
    callkeepSound: mockSound,
  );
}
