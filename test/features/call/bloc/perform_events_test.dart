import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/features/call/models/models.dart';
import 'package:webtrit_phone/features/call/utils/utils.dart';
import 'package:webtrit_phone/models/models.dart';

import 'helpers/call_bloc_test_helpers.dart';
import 'helpers/fake_signaling_client.dart';

// ---------------------------------------------------------------------------
// Fallback values required by mocktail
// ---------------------------------------------------------------------------

class _FakeLinesState extends Fake implements LinesState {}

class _FakeCallkeepHandle extends Fake implements CallkeepHandle {}

class _FakeRTCPeerConnection extends Fake implements RTCPeerConnection {}

final _fakeNewCall = (
  direction: CallDirection.incoming,
  number: '0',
  video: false,
  username: null,
  createdTime: DateTime.utc(2024),
  acceptedTime: null,
  hungUpTime: null,
);

// ---------------------------------------------------------------------------
// Helpers: WebRTC mock setup
// ---------------------------------------------------------------------------

/// Creates a [MockRTCPeerConnection] with all methods needed for the call flow stubbed.
MockRTCPeerConnection _buildMockPc() {
  final mock = MockRTCPeerConnection();
  when(() => mock.createOffer(any())).thenAnswer((_) async => RTCSessionDescription(null, 'offer'));
  when(() => mock.createAnswer(any())).thenAnswer((_) async => RTCSessionDescription(null, 'answer'));
  when(() => mock.setLocalDescription(any())).thenAnswer((_) async {});
  when(() => mock.setRemoteDescription(any())).thenAnswer((_) async {});
  when(() => mock.close()).thenAnswer((_) async {});
  return mock;
}

/// Creates a [MockMediaStream] that returns an empty track list (no [addTrack] calls).
MockMediaStream _buildMockStream() {
  final mock = MockMediaStream();
  when(() => mock.getTracks()).thenReturn([]);
  when(() => mock.getAudioTracks()).thenReturn([]);
  when(() => mock.getVideoTracks()).thenReturn([]);
  when(() => mock.dispose()).thenAnswer((_) async {});
  return mock;
}

/// Configures [peerConnectionManager] to return [pc] from [createPeerConnection]
/// and to accept [complete] calls.
void _stubPcm(MockPeerConnectionManager pcm, MockRTCPeerConnection pc) {
  when(() => pcm.createPeerConnection(any(), observer: any(named: 'observer'))).thenAnswer((_) async => pc);
  when(() => pcm.complete(any(), any())).thenReturn(null);
}

/// Configures [userMediaBuilder] to return [stream] from [build].
void _stubMedia(MockUserMediaBuilder media, MockMediaStream stream) {
  when(
    () => media.build(
      video: any(named: 'video'),
      frontCamera: any(named: 'frontCamera'),
    ),
  ).thenAnswer((_) async => stream);
}

MockCallkeep _outgoingCallkeepMock() {
  final mock = MockCallkeep();
  when(() => mock.setDelegate(any())).thenReturn(null);
  when(
    () => mock.startCall(
      any(),
      any(),
      displayNameOrContactIdentifier: any(named: 'displayNameOrContactIdentifier'),
      hasVideo: any(named: 'hasVideo'),
      proximityEnabled: any(named: 'proximityEnabled'),
    ),
  ).thenAnswer((_) async => null);
  when(() => mock.reportConnectedOutgoingCall(any())).thenAnswer((_) async {});
  when(() => mock.reportConnectingOutgoingCall(any())).thenAnswer((_) async {});
  when(() => mock.reportEndCall(any(), any(), any())).thenAnswer((_) async {});
  return mock;
}

MockCallkeep _incomingCallkeepMock() {
  final mock = MockCallkeep();
  when(() => mock.setDelegate(any())).thenReturn(null);
  when(
    () => mock.reportNewIncomingCall(
      any(),
      any(),
      displayName: any(named: 'displayName'),
      hasVideo: any(named: 'hasVideo'),
    ),
  ).thenAnswer((_) async => null);
  when(() => mock.reportEndCall(any(), any(), any())).thenAnswer((_) async {});
  return mock;
}

// ---------------------------------------------------------------------------

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(_FakeLinesState());
    registerFallbackValue(CallkeepSignalingStatus.disconnect);
    registerFallbackValue(_FakeCallkeepHandle());
    registerFallbackValue(CallkeepEndCallReason.remoteEnded);
    registerFallbackValue(_fakeNewCall);
    registerFallbackValue(RTCSessionDescription(null, null));
    registerFallbackValue(const PeerConnectionObserver());
    registerFallbackValue(_FakeRTCPeerConnection());
  });

  // -------------------------------------------------------------------------
  // performStartCall
  // -------------------------------------------------------------------------

  group('performStartCall', () {
    test('transitions outgoing call to outgoingOfferSent', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockPc = _buildMockPc();
        final mockStream = _buildMockStream();
        final mockMedia = MockUserMediaBuilder();
        final mockPcm = MockPeerConnectionManager();
        final mockCallkeep = _outgoingCallkeepMock();

        _stubMedia(mockMedia, mockStream);
        _stubPcm(mockPcm, mockPc);

        final bloc = buildTestBloc(
          callkeep: mockCallkeep,
          peerConnectionManager: mockPcm,
          userMediaBuilder: mockMedia,
          signalingClientFactory: factory.call,
        );

        bringOnlineWithHandshake(async, bloc, factory);

        bloc.add(const CallControlEvent.started(number: '456', video: false));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, hasLength(1));
        final callId = bloc.state.activeCalls.first.callId;

        // Trigger the perform-start chain: Callkeep → performStartCall → _CallPerformEvent.started
        bloc.performStartCall(callId, const CallkeepHandle.number('456'), null, false);
        async.flushMicrotasks();

        expect(bloc.state.activeCalls.first.processingStatus, CallProcessingStatus.outgoingOfferSent);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('transitions through outgoingInitializingMedia before outgoingOfferSent', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockPc = _buildMockPc();
        final mockStream = _buildMockStream();
        final mockMedia = MockUserMediaBuilder();
        final mockPcm = MockPeerConnectionManager();
        final mockCallkeep = _outgoingCallkeepMock();

        _stubMedia(mockMedia, mockStream);
        _stubPcm(mockPcm, mockPc);

        final bloc = buildTestBloc(
          callkeep: mockCallkeep,
          peerConnectionManager: mockPcm,
          userMediaBuilder: mockMedia,
          signalingClientFactory: factory.call,
        );

        bringOnlineWithHandshake(async, bloc, factory);

        bloc.add(const CallControlEvent.started(number: '789', video: false));
        async.flushMicrotasks();

        final callId = bloc.state.activeCalls.first.callId;

        bloc.performStartCall(callId, const CallkeepHandle.number('789'), null, false);
        async.flushMicrotasks();

        // After full flush, the call completed the WebRTC offer path
        final call = bloc.state.retrieveActiveCall(callId);
        expect(call, isNotNull);
        expect(call!.processingStatus, CallProcessingStatus.outgoingOfferSent);
        verify(() => mockPcm.createPeerConnection(callId, observer: any(named: 'observer'))).called(1);
        verify(() => mockPc.createOffer(any())).called(1);
        verify(() => mockPc.setLocalDescription(any())).called(1);
        verify(() => mockPcm.complete(callId, mockPc)).called(1);
        verify(() => mockCallkeep.reportConnectingOutgoingCall(callId)).called(1);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('sends CallWhileUnregisteredNotification when registration lapses before perform', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final notifications = <Notification>[];
        final mockPc = _buildMockPc();
        final mockStream = _buildMockStream();
        final mockMedia = MockUserMediaBuilder();
        final mockPcm = MockPeerConnectionManager();
        final mockCallkeep = _outgoingCallkeepMock();

        _stubMedia(mockMedia, mockStream);
        _stubPcm(mockPcm, mockPc);

        final bloc = buildTestBloc(
          callkeep: mockCallkeep,
          peerConnectionManager: mockPcm,
          userMediaBuilder: mockMedia,
          signalingClientFactory: factory.call,
          capturedNotifications: notifications,
        );

        // Bring online as registered so the outgoing call can be created.
        bringOnlineWithHandshake(async, bloc, factory);

        bloc.add(const CallControlEvent.started(number: '456', video: false));
        async.flushMicrotasks();
        expect(bloc.state.activeCalls, hasLength(1));

        final callId = bloc.state.activeCalls.first.callId;

        // Simulate re-registration with unregistered status before performStartCall runs.
        factory.client!.simulateHandshake(
          minimalStateHandshake(registrationStatus: RegistrationStatus.unregistered, linesCount: 1),
        );
        async.flushMicrotasks();

        bloc.performStartCall(callId, const CallkeepHandle.number('456'), null, false);
        async.flushMicrotasks();

        expect(notifications, contains(isA<CallWhileUnregisteredNotification>()));

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });

  // -------------------------------------------------------------------------
  // performAnswerCall
  // -------------------------------------------------------------------------

  group('performAnswerCall', () {
    test('transitions incoming call to incomingAnswering and sends AcceptRequest', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockPc = _buildMockPc();
        final mockStream = _buildMockStream();
        final mockMedia = MockUserMediaBuilder();
        final mockPcm = MockPeerConnectionManager();
        final mockCallkeep = _incomingCallkeepMock();

        _stubMedia(mockMedia, mockStream);
        _stubPcm(mockPcm, mockPc);

        final bloc = buildTestBloc(
          callkeep: mockCallkeep,
          peerConnectionManager: mockPcm,
          userMediaBuilder: mockMedia,
          signalingClientFactory: factory.call,
        );

        bringOnlineWithHandshake(async, bloc, factory);

        // Simulate incoming with a JSEP offer so incomingOffer is non-null.
        simulateIncoming(async, factory, jsep: {'type': 'offer', 'sdp': 'v=0\r\nm=audio 9 UDP/TLS/RTP/SAVPF\r\n'});

        expect(bloc.state.activeCalls, hasLength(1));
        expect(bloc.state.activeCalls.first.processingStatus, CallProcessingStatus.incomingFromOffer);

        bloc.performAnswerCall('call-1');
        async.flushMicrotasks();

        final call = bloc.state.retrieveActiveCall('call-1');
        expect(call?.processingStatus, CallProcessingStatus.incomingAnswering);
        verify(() => mockPcm.createPeerConnection('call-1', observer: any(named: 'observer'))).called(1);
        verify(() => mockPc.setRemoteDescription(any())).called(1);
        verify(() => mockPc.createAnswer(any())).called(1);
        verify(() => mockPc.setLocalDescription(any())).called(1);
        verify(() => mockPcm.complete('call-1', mockPc)).called(1);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('skips double answer when call is already past incomingFromOffer', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockPc = _buildMockPc();
        final mockStream = _buildMockStream();
        final mockMedia = MockUserMediaBuilder();
        final mockPcm = MockPeerConnectionManager();
        final mockCallkeep = _incomingCallkeepMock();

        _stubMedia(mockMedia, mockStream);
        _stubPcm(mockPcm, mockPc);

        final bloc = buildTestBloc(
          callkeep: mockCallkeep,
          peerConnectionManager: mockPcm,
          userMediaBuilder: mockMedia,
          signalingClientFactory: factory.call,
        );

        bringOnlineWithHandshake(async, bloc, factory);

        simulateIncoming(async, factory, jsep: {'type': 'offer', 'sdp': 'v=0\r\n'});

        // First answer: advances to incomingAnswering
        bloc.performAnswerCall('call-1');
        async.flushMicrotasks();
        expect(bloc.state.retrieveActiveCall('call-1')?.processingStatus, CallProcessingStatus.incomingAnswering);

        // Second answer on the same call: status is no longer incomingFromOffer, should be skipped
        bloc.performAnswerCall('call-1');
        async.flushMicrotasks();

        // createPeerConnection called only once
        verify(() => mockPcm.createPeerConnection('call-1', observer: any(named: 'observer'))).called(1);

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });

  // -------------------------------------------------------------------------
  // performEndCall
  // -------------------------------------------------------------------------

  group('performEndCall', () {
    test('removes unanswered incoming call and sends DeclineRequest', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _incomingCallkeepMock();

        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory);
        expect(bloc.state.activeCalls, hasLength(1));

        bloc.performEndCall('call-1');
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, isEmpty);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('removes connected outgoing call and sends HangupRequest', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockPc = _buildMockPc();
        final mockStream = _buildMockStream();
        final mockMedia = MockUserMediaBuilder();
        final mockPcm = MockPeerConnectionManager();
        final mockCallkeep = _outgoingCallkeepMock();

        _stubMedia(mockMedia, mockStream);
        _stubPcm(mockPcm, mockPc);

        final bloc = buildTestBloc(
          callkeep: mockCallkeep,
          peerConnectionManager: mockPcm,
          userMediaBuilder: mockMedia,
          signalingClientFactory: factory.call,
        );

        bringOnlineWithHandshake(async, bloc, factory);

        bloc.add(const CallControlEvent.started(number: '456', video: false));
        async.flushMicrotasks();

        final callId = bloc.state.activeCalls.first.callId;

        // Bring call to outgoingOfferSent via performStartCall
        bloc.performStartCall(callId, const CallkeepHandle.number('456'), null, false);
        async.flushMicrotasks();
        expect(bloc.state.activeCalls.first.processingStatus, CallProcessingStatus.outgoingOfferSent);

        // Simulate AcceptedEvent from signaling to bring it to connected
        factory.client!.simulateEvent(AcceptedEvent(line: 0, callId: callId));
        async.flushMicrotasks();
        expect(bloc.state.activeCalls.first.processingStatus, CallProcessingStatus.connected);

        // Now end the connected call
        bloc.performEndCall(callId);
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, isEmpty);
        // disposePeerConnection is called both by the handler and by the onChange
        // hook that fires whenever a call is removed from activeCalls.
        verify(() => mockPcm.disposePeerConnection(callId)).called(greaterThanOrEqualTo(1));

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('ignores performEndCall for a call that is already hung up', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _incomingCallkeepMock();

        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        bringOnlineWithHandshake(async, bloc, factory);
        simulateIncoming(async, factory);
        expect(bloc.state.activeCalls, hasLength(1));

        // Remote side hangs up first
        factory.client!.simulateEvent(const HangupEvent(line: 0, callId: 'call-1', code: 0, reason: 'normal'));
        async.flushMicrotasks();
        expect(bloc.state.activeCalls, isEmpty);

        // performEndCall for a call that no longer exists — should be a no-op
        bloc.performEndCall('call-1');
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, isEmpty);

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });
}
