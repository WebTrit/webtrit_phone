import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/features/call/utils/utils.dart';

class MockRTCPeerConnection extends Mock implements RTCPeerConnection {}

class MockRtpTrafficMonitorDelegate extends Mock implements RtpTrafficMonitorDelegate {}

void main() {
  late MockRTCPeerConnection mockPeerConnection;

  setUp(() {
    mockPeerConnection = MockRTCPeerConnection();

    when(() => mockPeerConnection.getStats()).thenAnswer((_) async => []);
    when(() => mockPeerConnection.connectionState).thenReturn(RTCPeerConnectionState.RTCPeerConnectionStateConnected);
  });

  test('does not start timer and never calls getStats when checkInterval is zero', () async {
    final monitor = RtpTrafficMonitor(peerConnection: mockPeerConnection, checkInterval: Duration(seconds: 0));

    monitor.start();

    await Future.delayed(const Duration(milliseconds: 10));

    verifyNever(() => mockPeerConnection.getStats());

    verifyNever(() => mockPeerConnection.connectionState);

    monitor.stop();
  });

  test('does not start timer and never calls getStats when checkInterval is negative', () async {
    final monitor = RtpTrafficMonitor(peerConnection: mockPeerConnection, checkInterval: const Duration(seconds: -5));

    monitor.start();

    await Future.delayed(const Duration(milliseconds: 50));

    verifyNever(() => mockPeerConnection.getStats());

    monitor.stop();
  });

  test('starts timer and calls getStats periodically for positive interval', () async {
    final monitor = RtpTrafficMonitor(
      peerConnection: mockPeerConnection,
      checkInterval: const Duration(milliseconds: 10),
    );

    monitor.start();

    await Future.delayed(const Duration(milliseconds: 35));

    verify(() => mockPeerConnection.getStats()).called(greaterThanOrEqualTo(1));

    monitor.stop();
  });

  test('stops monitoring automatically if peer connection is closed', () async {
    when(() => mockPeerConnection.connectionState).thenReturn(RTCPeerConnectionState.RTCPeerConnectionStateClosed);

    final monitor = RtpTrafficMonitor(
      peerConnection: mockPeerConnection,
      checkInterval: const Duration(milliseconds: 10),
    );

    monitor.start();

    await Future.delayed(const Duration(milliseconds: 35));

    verify(() => mockPeerConnection.connectionState).called(greaterThanOrEqualTo(1));

    verifyNever(() => mockPeerConnection.getStats());

    monitor.stop();
  });
}
