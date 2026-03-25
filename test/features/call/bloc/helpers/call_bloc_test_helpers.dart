import 'dart:async';

import 'package:mocktail/mocktail.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/features/call/utils/utils.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

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
TestCallBloc buildTestBloc({
  MockCallkeep? callkeep,
  MockCallkeepConnections? callkeepConnections,
  MockPeerConnectionManager? peerConnectionManager,
  MockPresenceSettingsRepository? presenceSettingsRepository,
  SignalingClientFactory signalingClientFactory = _pendingSignalingFactory,
  bool sipPresenceEnabled = false,
}) {
  final mockCallkeep = callkeep ?? MockCallkeep();
  final mockConnections = callkeepConnections ?? MockCallkeepConnections();
  final mockPcm = peerConnectionManager ?? MockPeerConnectionManager();
  final mockPresenceSettings = presenceSettingsRepository ?? MockPresenceSettingsRepository();

  final mockLinesState = MockLinesStateRepository();
  final mockSound = MockWebtritCallkeepSound();

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

  final capturedNotifications = <Notification>[];

  return TestCallBloc(
    coreUrl: 'https://example.com',
    tenantId: 'test-tenant',
    token: 'test-token',
    trustedCertificates: TrustedCertificates.empty,
    callLogsRepository: MockCallLogsRepository(),
    callPullRepository: MockCallPullRepository(),
    linesStateRepository: mockLinesState,
    presenceInfoRepository: MockPresenceInfoRepository(),
    presenceSettingsRepository: mockPresenceSettings,
    onSessionInvalidated: () {},
    userRepository: MockUserRepository(),
    submitNotification: capturedNotifications.add,
    callkeep: mockCallkeep,
    callkeepConnections: mockConnections,
    userMediaBuilder: MockUserMediaBuilder(),
    contactNameResolver: MockContactNameResolver(),
    callErrorReporter: MockCallErrorReporter(),
    sipPresenceEnabled: sipPresenceEnabled,
    onDiagnosticReportRequested: (_, _) {},
    peerConnectionManager: mockPcm,
    signalingClientFactory: signalingClientFactory,
    callkeepSound: mockSound,
  );
}
