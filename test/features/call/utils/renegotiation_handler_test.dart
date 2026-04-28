import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/utils/call_error_reporter.dart';
import 'package:webtrit_phone/features/call/utils/renegotiation_handler.dart';
import 'package:webtrit_phone/features/call/utils/sdp_munger.dart';

class MockRTCPeerConnection extends Mock implements RTCPeerConnection {}

class MockCallErrorReporter extends Mock implements CallErrorReporter {}

class MockSDPMunger extends Mock implements SDPMunger {}

void main() {
  late MockRTCPeerConnection mockPC;
  late MockCallErrorReporter mockErrorReporter;
  late MockSDPMunger mockMunger;
  late RenegotiationHandler handler;

  const kCallId = 'call-1';
  final kOffer = RTCSessionDescription('v=0\r\n', 'offer');

  setUpAll(() {
    registerFallbackValue(RTCSessionDescription('', ''));
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockPC = MockRTCPeerConnection();
    mockErrorReporter = MockCallErrorReporter();
    mockMunger = MockSDPMunger();
  });

  group('RenegotiationHandler — state guard (before offer)', () {
    test('skips entirely when state is have-remote-offer', () async {
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);
      when(() => mockPC.signalingState).thenReturn(RTCSignalingState.RTCSignalingStateHaveRemoteOffer);

      var executeCalled = false;
      await handler.handle(kCallId, mockPC, (_, _) async => executeCalled = true);

      verifyNever(() => mockPC.createOffer(any()));
      expect(executeCalled, isFalse);
    });

    test('skips entirely when state is have-local-offer', () async {
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);
      when(() => mockPC.signalingState).thenReturn(RTCSignalingState.RTCSignalingStateHaveLocalOffer);

      var executeCalled = false;
      await handler.handle(kCallId, mockPC, (_, _) async => executeCalled = true);

      verifyNever(() => mockPC.createOffer(any()));
      expect(executeCalled, isFalse);
    });

    test('skips entirely when state is closed', () async {
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);
      when(() => mockPC.signalingState).thenReturn(RTCSignalingState.RTCSignalingStateClosed);

      var executeCalled = false;
      await handler.handle(kCallId, mockPC, (_, _) async => executeCalled = true);

      verifyNever(() => mockPC.createOffer(any()));
      expect(executeCalled, isFalse);
    });

    test('proceeds when state is null (Dart-side cache uninitialized = new PC in native stable state)', () async {
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);
      // null signalingState: flutter_webrtc has not yet received a native
      // onSignalingStateChange callback. A new RTCPeerConnection starts in
      // native "stable", so null must be treated as stable to allow the
      // first offer after restoration.
      when(() => mockPC.signalingState).thenReturn(null);
      when(() => mockPC.createOffer(any())).thenAnswer((_) async => kOffer);
      when(() => mockPC.setLocalDescription(any())).thenAnswer((_) async {});

      var executeCalled = false;
      await handler.handle(kCallId, mockPC, (_, _) async => executeCalled = true);

      verify(() => mockPC.createOffer(any())).called(1);
      expect(executeCalled, isTrue);
    });
  });

  group('RenegotiationHandler — TOCTOU guard (after offer)', () {
    test('skips setLocalDescription when state changed to have-remote-offer after createOffer', () async {
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);

      var callCount = 0;
      when(() => mockPC.signalingState).thenAnswer(
        (_) => callCount++ == 0
            ? RTCSignalingState.RTCSignalingStateStable
            : RTCSignalingState.RTCSignalingStateHaveRemoteOffer,
      );
      when(() => mockPC.createOffer(any())).thenAnswer((_) async => kOffer);

      var executeCalled = false;
      await handler.handle(kCallId, mockPC, (_, _) async => executeCalled = true);

      verifyNever(() => mockPC.setLocalDescription(any()));
      expect(executeCalled, isFalse);
    });
  });

  group('RenegotiationHandler — happy path', () {
    setUp(() {
      var callCount = 0;
      when(
        () => mockPC.signalingState,
      ).thenAnswer((_) => callCount++ == 0 ? RTCSignalingState.RTCSignalingStateStable : null);
      when(() => mockPC.createOffer(any())).thenAnswer((_) async => kOffer);
      when(() => mockPC.setLocalDescription(any())).thenAnswer((_) async {});
    });

    test('calls setLocalDescription and execute when both states are stable', () async {
      when(() => mockPC.signalingState).thenReturn(RTCSignalingState.RTCSignalingStateStable);
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);

      RTCSessionDescription? capturedJsep;
      String? capturedCallId;

      await handler.handle(kCallId, mockPC, (callId, jsep) async {
        capturedCallId = callId;
        capturedJsep = jsep;
      });

      verify(() => mockPC.setLocalDescription(kOffer)).called(1);
      expect(capturedCallId, kCallId);
      expect(capturedJsep, kOffer);
    });

    test('applies sdpMunger before setLocalDescription', () async {
      when(() => mockPC.signalingState).thenReturn(RTCSignalingState.RTCSignalingStateStable);
      when(() => mockMunger.apply(any())).thenReturn(null);
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter, sdpMunger: mockMunger);

      await handler.handle(kCallId, mockPC, (_, _) async {});

      verify(() => mockMunger.apply(kOffer)).called(1);
      verify(() => mockPC.setLocalDescription(kOffer)).called(1);
    });

    test('does not call sdpMunger when it is null', () async {
      when(() => mockPC.signalingState).thenReturn(RTCSignalingState.RTCSignalingStateStable);
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);

      await handler.handle(kCallId, mockPC, (_, _) async {});

      verifyNever(() => mockMunger.apply(any()));
    });
  });

  group('RenegotiationHandler — execute error handling', () {
    setUp(() {
      when(() => mockErrorReporter.handle(any(), any(), any())).thenReturn(null);
    });

    test('reports error via callErrorReporter when execute throws', () async {
      when(() => mockPC.signalingState).thenReturn(RTCSignalingState.RTCSignalingStateStable);
      when(() => mockPC.createOffer(any())).thenAnswer((_) async => kOffer);
      when(() => mockPC.setLocalDescription(any())).thenAnswer((_) async {});
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);
      final exception = Exception('signaling error');

      await handler.handle(kCallId, mockPC, (_, _) async => throw exception);

      verify(() => mockErrorReporter.handle(exception, any(), any())).called(1);
    });

    test('reports error via callErrorReporter when createOffer throws', () async {
      when(() => mockPC.signalingState).thenReturn(RTCSignalingState.RTCSignalingStateStable);
      final exception = Exception('createOffer error');
      when(() => mockPC.createOffer(any())).thenThrow(exception);
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);

      await handler.handle(kCallId, mockPC, (_, _) async {});

      verify(() => mockErrorReporter.handle(exception, any(), any())).called(1);
    });

    test('reports error via callErrorReporter when setLocalDescription throws', () async {
      when(() => mockPC.signalingState).thenReturn(RTCSignalingState.RTCSignalingStateStable);
      when(() => mockPC.createOffer(any())).thenAnswer((_) async => kOffer);
      final exception = Exception('setLocalDescription error');
      when(() => mockPC.setLocalDescription(any())).thenThrow(exception);
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);

      await handler.handle(kCallId, mockPC, (_, _) async {});

      verify(() => mockErrorReporter.handle(exception, any(), any())).called(1);
    });

    test('does not rethrow when execute throws', () async {
      when(() => mockPC.signalingState).thenReturn(RTCSignalingState.RTCSignalingStateStable);
      when(() => mockPC.createOffer(any())).thenAnswer((_) async => kOffer);
      when(() => mockPC.setLocalDescription(any())).thenAnswer((_) async {});
      handler = RenegotiationHandler(callErrorReporter: mockErrorReporter);

      await expectLater(handler.handle(kCallId, mockPC, (_, _) async => throw Exception('error')), completes);
    });
  });
}
