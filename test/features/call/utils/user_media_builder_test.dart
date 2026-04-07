import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/utils/user_media_builder.dart';

class MockMediaStream extends Mock implements MediaStream {}

void main() {
  late MockMediaStream mockStream;
  late Map<String, dynamic> capturedConstraints;
  late Future<MediaStream> Function(Map<String, dynamic>) fakeGetUserMedia;

  setUp(() {
    mockStream = MockMediaStream();
    capturedConstraints = {};

    fakeGetUserMedia = (constraints) async {
      capturedConstraints = constraints;
      return mockStream;
    };
  });

  DefaultUserMediaBuilder builder({Future<bool> Function()? isCameraPermissionGranted}) =>
      DefaultUserMediaBuilder(isCameraPermissionGranted: isCameraPermissionGranted, getUserMedia: fakeGetUserMedia);

  group('DefaultUserMediaBuilder — audio/video constraints', () {
    test('passes video: false to getUserMedia when video is false', () async {
      await builder().build(video: false);
      expect(capturedConstraints['video'], isFalse);
    });

    test('passes video map to getUserMedia when video is true', () async {
      await builder().build(video: true);
      expect(capturedConstraints['video'], isA<Map>());
    });

    test('passes audio constraints to getUserMedia', () async {
      await builder().build(video: false);
      expect(capturedConstraints['audio'], isNotNull);
    });
  });

  group('DefaultUserMediaBuilder — allowAudioFallback: false (default)', () {
    test('does not call isCameraPermissionGranted when allowAudioFallback is false', () async {
      var permissionCalled = false;
      await builder(
        isCameraPermissionGranted: () async {
          permissionCalled = true;
          return false;
        },
      ).build(video: true);

      expect(permissionCalled, isFalse);
      expect(capturedConstraints['video'], isA<Map>());
    });

    test('passes video: true regardless of camera permission when allowAudioFallback is false', () async {
      await builder(isCameraPermissionGranted: () async => false).build(video: true);
      expect(capturedConstraints['video'], isA<Map>());
    });
  });

  group('DefaultUserMediaBuilder — allowAudioFallback: true', () {
    test('passes video: true when camera permission is granted', () async {
      await builder(isCameraPermissionGranted: () async => true).build(video: true, allowAudioFallback: true);

      expect(capturedConstraints['video'], isA<Map>());
    });

    test('passes video: false when camera permission is denied', () async {
      await builder(isCameraPermissionGranted: () async => false).build(video: true, allowAudioFallback: true);

      expect(capturedConstraints['video'], isFalse);
    });

    test('passes video: false when video is false regardless of camera permission', () async {
      await builder(isCameraPermissionGranted: () async => true).build(video: false, allowAudioFallback: true);

      expect(capturedConstraints['video'], isFalse);
    });

    test('passes video: true when isCameraPermissionGranted is null', () async {
      await builder().build(video: true, allowAudioFallback: true);
      expect(capturedConstraints['video'], isA<Map>());
    });

    test('calls isCameraPermissionGranted exactly once per build call', () async {
      var callCount = 0;
      await builder(
        isCameraPermissionGranted: () async {
          callCount++;
          return true;
        },
      ).build(video: true, allowAudioFallback: true);

      expect(callCount, 1);
    });
  });

  group('DefaultUserMediaBuilder — allowAudioFallback: true, getUserMedia retry', () {
    test('retries with video: false when getUserMedia fails on first video attempt', () async {
      final capturedAttempts = <bool>[];
      final subject = DefaultUserMediaBuilder(
        isCameraPermissionGranted: () async => true,
        getUserMedia: (constraints) async {
          final hasVideo = constraints['video'] != false;
          capturedAttempts.add(hasVideo);
          if (hasVideo) throw Exception('NotAllowedError');
          return mockStream;
        },
      );

      final result = await subject.build(video: true, allowAudioFallback: true);

      expect(capturedAttempts, [true, false]);
      expect(result, mockStream);
    });

    test('does not retry when allowAudioFallback is false', () async {
      var callCount = 0;
      final subject = DefaultUserMediaBuilder(
        getUserMedia: (_) async {
          callCount++;
          throw Exception('NotAllowedError');
        },
      );

      await expectLater(subject.build(video: true), throwsA(isA<UserMediaError>()));
      expect(callCount, 1);
    });

    test('does not retry when video was already false', () async {
      var callCount = 0;
      final subject = DefaultUserMediaBuilder(
        getUserMedia: (_) async {
          callCount++;
          throw Exception('device error');
        },
      );

      await expectLater(subject.build(video: false, allowAudioFallback: true), throwsA(isA<UserMediaError>()));
      expect(callCount, 1);
    });

    test('throws UserMediaError when retry also fails', () async {
      final subject = DefaultUserMediaBuilder(
        isCameraPermissionGranted: () async => true,
        getUserMedia: (_) async => throw Exception('no mic'),
      );

      await expectLater(subject.build(video: true, allowAudioFallback: true), throwsA(isA<UserMediaError>()));
    });
  });

  group('DefaultUserMediaBuilder — error handling', () {
    test('wraps getUserMedia exception in UserMediaError', () async {
      final subject = DefaultUserMediaBuilder(getUserMedia: (_) async => throw Exception('device not found'));

      await expectLater(subject.build(video: false), throwsA(isA<UserMediaError>()));
    });

    test('UserMediaError message contains original error', () async {
      final subject = DefaultUserMediaBuilder(getUserMedia: (_) async => throw Exception('device not found'));

      UserMediaError? captured;
      await subject.build(video: false).catchError((Object e) {
        captured = e as UserMediaError;
        return mockStream as MediaStream;
      });
      expect(captured?.message, contains('device not found'));
    });
  });
}
