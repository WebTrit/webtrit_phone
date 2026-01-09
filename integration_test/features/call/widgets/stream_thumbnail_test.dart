import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/widgets/widgets.dart';

class MockMediaStream extends Mock implements MediaStream {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel methodChannel = MethodChannel('FlutterWebRTC.Method');

  // EventChannel for the specific texture.
  // The name MUST match 'FlutterWebRTC/Texture<ID>' where ID is what we return in createVideoRenderer.
  const String eventChannelName = 'FlutterWebRTC/Texture1';
  const MethodChannel eventChannel = MethodChannel(eventChannelName);

  setUpAll(() {
    // Mock the main MethodChannel
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(methodChannel, (
      MethodCall methodCall,
    ) async {
      switch (methodCall.method) {
        case 'createVideoRenderer':
          // Return textureId: 1. This dictates the EventChannel name above.
          return {'textureId': 1};
        case 'videoRendererSetSrcObject':
        case 'videoRendererDispose':
        case 'streamDispose':
          return null;
        default:
          return null;
      }
    });

    // Mock the EventChannel to prevent MissingPluginException on 'listen'
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(eventChannel, (
      MethodCall methodCall,
    ) async {
      switch (methodCall.method) {
        case 'listen':
          return null;
        case 'cancel':
          return null;
        default:
          return null;
      }
    });
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(methodChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(eventChannel, null);
  });

  group('StreamThumbnail Widget Tests', () {
    late MockMediaStream mockStream;

    setUp(() {
      mockStream = MockMediaStream();
      // Stub 'id' (required by renderer)
      when(() => mockStream.id).thenReturn('mock_stream_id');
      // Stub 'ownerTag' (required by renderer)
      when(() => mockStream.ownerTag).thenReturn('mock_owner_tag');
      // Stub track getters
      when(() => mockStream.getVideoTracks()).thenReturn([]);
      when(() => mockStream.getAudioTracks()).thenReturn([]);
    });

    testWidgets('initializes and renders with default Portrait size (90x120)', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: StreamThumbnail(stream: mockStream)),
        ),
      );

      // Allow async renderer initialization to complete
      await tester.pumpAndSettle();

      // Verify the widget is in the tree
      expect(find.byType(StreamThumbnail), findsOneWidget);
      expect(find.byType(RTCVideoView), findsOneWidget);

      // Verify Sizing logic (defaults to portrait 90x120)
      final sizerFinder = find.byType(SizedBox);
      final sizer = tester.widget<SizedBox>(sizerFinder.first);

      expect(sizer.width, 90.0);
      expect(sizer.height, 120.0);
    });

    testWidgets('shows placeholder when builder is provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StreamThumbnail(stream: mockStream, placeholderBuilder: (context) => const Text('Placeholder')),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Placeholder'), findsOneWidget);
    });

    testWidgets('shows overlay when builder is provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StreamThumbnail(stream: mockStream, overlayBuilder: (context) => const Text('Overlay')),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Overlay'), findsOneWidget);
    });

    testWidgets('handles stream updates without crashing', (tester) async {
      final mockStream2 = MockMediaStream();
      when(() => mockStream2.id).thenReturn('mock_stream_id_2');
      when(() => mockStream2.ownerTag).thenReturn('mock_owner_tag_2');
      when(() => mockStream2.getVideoTracks()).thenReturn([]);
      when(() => mockStream2.getAudioTracks()).thenReturn([]);

      // Pump with first stream
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: StreamThumbnail(stream: mockStream)),
        ),
      );
      await tester.pumpAndSettle();

      // Re-pump with different stream
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: StreamThumbnail(stream: mockStream2)),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(StreamThumbnail), findsOneWidget);
    });

    testWidgets('passes objectFit and mirror properties to RTCVideoView', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StreamThumbnail(
              stream: mockStream,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
              mirror: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final rtcViewFinder = find.byType(RTCVideoView);
      final rtcView = tester.widget<RTCVideoView>(rtcViewFinder);

      expect(rtcView.objectFit, RTCVideoViewObjectFit.RTCVideoViewObjectFitContain);
      expect(rtcView.mirror, true);
    });
  });
}
