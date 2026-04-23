import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/utils/user_media_builder.dart';

class MockMediaStream extends Mock implements MediaStream {}

class MockMediaStreamTrack extends Mock implements MediaStreamTrack {}

class FakeMediaStreamTrack extends Fake implements MediaStreamTrack {}

class _TestMediaStreamFactory {
  int _counter = 0;

  final streams = <MockMediaStream>[];

  MockMediaStream create() {
    _counter++;
    final stream = MockMediaStream();

    final audioTracks = <MediaStreamTrack>[];
    final videoTracks = <MediaStreamTrack>[];

    when(() => stream.id).thenReturn('local-stream-$_counter');
    when(() => stream.getAudioTracks()).thenAnswer((_) => audioTracks);
    when(() => stream.getVideoTracks()).thenAnswer((_) => videoTracks);
    when(() => stream.addTrack(any())).thenAnswer((invocation) async {
      final track = invocation.positionalArguments.first as MediaStreamTrack;
      if (track.kind == 'audio') {
        audioTracks.add(track);
      } else if (track.kind == 'video') {
        videoTracks.add(track);
      }
    });
    when(() => stream.removeTrack(any())).thenAnswer((_) async {});
    when(() => stream.dispose()).thenAnswer((_) async {});

    streams.add(stream);
    return stream;
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeMediaStreamTrack());
  });

  late _TestMediaStreamFactory localStreamFactory;
  late MockMediaStream audioSourceStream;
  late MockMediaStream videoSourceStream;
  late MockMediaStreamTrack audioTrack;
  late MockMediaStreamTrack videoTrack;
  late List<Map<String, dynamic>> capturedConstraints;
  late Future<MediaStream> Function(Map<String, dynamic>) fakeGetUserMedia;
  late Future<MediaStream> Function(String label) fakeCreateLocalStream;

  setUp(() {
    localStreamFactory = _TestMediaStreamFactory();
    audioSourceStream = MockMediaStream();
    videoSourceStream = MockMediaStream();
    audioTrack = MockMediaStreamTrack();
    videoTrack = MockMediaStreamTrack();
    capturedConstraints = [];

    when(() => audioTrack.id).thenReturn('audio-track-1');
    when(() => audioTrack.kind).thenReturn('audio');
    when(() => audioTrack.stop()).thenAnswer((_) async {});

    when(() => videoTrack.id).thenReturn('video-track-1');
    when(() => videoTrack.kind).thenReturn('video');
    when(() => videoTrack.stop()).thenAnswer((_) async {});

    when(() => audioSourceStream.getAudioTracks()).thenReturn([audioTrack]);
    when(() => audioSourceStream.getVideoTracks()).thenReturn([]);
    when(() => audioSourceStream.dispose()).thenAnswer((_) async {});

    when(() => videoSourceStream.getAudioTracks()).thenReturn([]);
    when(() => videoSourceStream.getVideoTracks()).thenReturn([videoTrack]);
    when(() => videoSourceStream.dispose()).thenAnswer((_) async {});

    fakeGetUserMedia = (constraints) async {
      capturedConstraints.add(Map<String, dynamic>.from(constraints));
      final hasAudio = constraints['audio'] != false;
      final hasVideo = constraints['video'] != false;

      if (hasAudio && !hasVideo) return audioSourceStream;
      if (!hasAudio && hasVideo) return videoSourceStream;

      throw Exception('Unsupported constraints in test: $constraints');
    };

    fakeCreateLocalStream = (_) async => localStreamFactory.create();
  });

  DefaultUserMediaBuilder builder({Future<bool> Function()? isCameraPermissionGranted}) => DefaultUserMediaBuilder(
    isCameraPermissionGranted: isCameraPermissionGranted,
    getUserMedia: fakeGetUserMedia,
    createLocalStream: fakeCreateLocalStream,
  );

  group('DefaultUserMediaBuilder — pooling', () {
    test('reuses pooled audio track for multiple streams', () async {
      final subject = builder();
      await subject.build(video: false);
      await subject.build(video: false);

      final audioRequests = capturedConstraints.where((it) => it['audio'] != false && it['video'] == false).length;
      expect(audioRequests, 1);
    });

    test('reuses pooled video track for multiple streams', () async {
      final subject = builder();
      await subject.build(video: true);
      await subject.build(video: true);

      final videoRequests = capturedConstraints.where((it) => it['audio'] == false && it['video'] != false).length;
      expect(videoRequests, 1);
    });

    test('disposes pooled source tracks only after releasing the last borrower', () async {
      final subject = builder();
      final stream1 = await subject.build(video: true);
      final stream2 = await subject.build(video: true);

      await subject.release(stream1);

      verifyNever(() => audioTrack.stop());
      verifyNever(() => videoTrack.stop());
      verifyNever(() => audioSourceStream.dispose());
      verifyNever(() => videoSourceStream.dispose());

      await subject.release(stream2);

      verify(() => audioTrack.stop()).called(1);
      verify(() => videoTrack.stop()).called(1);
      verify(() => audioSourceStream.dispose()).called(1);
      verify(() => videoSourceStream.dispose()).called(1);
    });

    test('detaches pooled tracks from stream before dispose when another borrower exists', () async {
      final subject = builder();
      final stream1 = await subject.build(video: true);
      final stream2 = await subject.build(video: true);

      // Releasing stream1 while stream2 still holds refs — tracks must be
      // detached from stream1 so streamDispose does not evict them from the
      // native localTracks registry.
      await subject.release(stream1);

      final localStream1 = localStreamFactory.streams[0];
      verify(() => localStream1.removeTrack(audioTrack)).called(1);
      verify(() => localStream1.removeTrack(videoTrack)).called(1);

      // Releasing the last borrower — detach is skipped (tracks are stopped anyway).
      await subject.release(stream2);

      final localStream2 = localStreamFactory.streams[1];
      verifyNever(() => localStream2.removeTrack(any()));
    });

    test('serializes release and subsequent build pool mutations', () async {
      final disposeGate = Completer<void>();
      final events = <String>[];
      var streamIndex = 0;
      var getUserMediaCalls = 0;

      Future<MediaStream> createBlockingLocalStream(String _) async {
        streamIndex++;
        final currentIndex = streamIndex;
        final stream = MockMediaStream();
        final audioTracks = <MediaStreamTrack>[];
        final videoTracks = <MediaStreamTrack>[];

        when(() => stream.id).thenReturn('local-stream-$currentIndex');
        when(() => stream.getAudioTracks()).thenAnswer((_) => audioTracks);
        when(() => stream.getVideoTracks()).thenAnswer((_) => videoTracks);
        when(() => stream.addTrack(any())).thenAnswer((invocation) async {
          final track = invocation.positionalArguments.first as MediaStreamTrack;
          if (track.kind == 'audio') {
            audioTracks.add(track);
          } else if (track.kind == 'video') {
            videoTracks.add(track);
          }
        });
        when(() => stream.removeTrack(any())).thenAnswer((_) async {});
        when(() => stream.dispose()).thenAnswer((_) async {
          if (currentIndex != 1) return;
          events.add('release_dispose_start');
          await disposeGate.future;
          events.add('release_dispose_end');
        });

        return stream;
      }

      final subject = DefaultUserMediaBuilder(
        getUserMedia: (constraints) async {
          getUserMediaCalls++;
          events.add('gum_$getUserMediaCalls');

          final hasAudio = constraints['audio'] != false;
          final hasVideo = constraints['video'] != false;

          if (hasAudio && !hasVideo) return audioSourceStream;
          if (!hasAudio && hasVideo) return videoSourceStream;

          throw Exception('Unsupported constraints in test: $constraints');
        },
        createLocalStream: createBlockingLocalStream,
      );

      final firstStream = await subject.build(video: false);
      expect(getUserMediaCalls, 1);

      final releaseFuture = subject.release(firstStream);
      await Future<void>.delayed(Duration.zero);
      expect(events, contains('release_dispose_start'));

      final secondBuildFuture = subject.build(video: false);
      await Future<void>.delayed(Duration.zero);
      expect(getUserMediaCalls, 1);

      disposeGate.complete();

      final secondStream = await secondBuildFuture;
      await releaseFuture;

      expect(secondStream, isA<MediaStream>());
      expect(getUserMediaCalls, 2);

      final releaseDisposeEndIndex = events.indexOf('release_dispose_end');
      final secondGetUserMediaIndex = events.indexOf('gum_2');

      expect(releaseDisposeEndIndex, greaterThan(-1));
      expect(secondGetUserMediaIndex, greaterThan(releaseDisposeEndIndex));
    });
  });

  group('DefaultUserMediaBuilder — dynamic video acquisition', () {
    test('ensureVideoTrack acquires only missing video track', () async {
      final subject = builder();
      final localStream = await subject.build(video: false);

      expect(localStream.getVideoTracks(), isEmpty);

      final ensuredTrack = await subject.ensureVideoTrack(localStream, frontCamera: true);
      expect(ensuredTrack, isNotNull);
      expect(localStream.getVideoTracks(), hasLength(1));

      final audioRequests = capturedConstraints.where((it) => it['audio'] != false && it['video'] == false).length;
      final videoRequests = capturedConstraints.where((it) => it['audio'] == false && it['video'] != false).length;

      expect(audioRequests, 1);
      expect(videoRequests, 1);
    });
  });

  group('DefaultUserMediaBuilder — allowAudioFallback', () {
    test('does not call camera permission check when allowAudioFallback is false', () async {
      var permissionCalled = false;
      await builder(
        isCameraPermissionGranted: () async {
          permissionCalled = true;
          return false;
        },
      ).build(video: true);

      expect(permissionCalled, isFalse);
    });

    test('calls isCameraPermissionGranted exactly once when fallback enabled', () async {
      var callCount = 0;
      await builder(
        isCameraPermissionGranted: () async {
          callCount++;
          return true;
        },
      ).build(video: true, allowAudioFallback: true);

      expect(callCount, 1);
    });

    test('falls back to audio-only when camera permission is denied', () async {
      await builder(isCameraPermissionGranted: () async => false).build(video: true, allowAudioFallback: true);

      final videoRequests = capturedConstraints.where((it) => it['audio'] == false && it['video'] != false).length;
      expect(videoRequests, 0);
    });

    test('retries in audio-only mode when video acquisition fails', () async {
      final attempts = <String>[];
      final subject = DefaultUserMediaBuilder(
        isCameraPermissionGranted: () async => true,
        createLocalStream: fakeCreateLocalStream,
        getUserMedia: (constraints) async {
          final hasAudio = constraints['audio'] != false;
          final hasVideo = constraints['video'] != false;
          attempts.add('audio:$hasAudio,video:$hasVideo');

          if (hasAudio && !hasVideo) return audioSourceStream;
          if (!hasAudio && hasVideo) throw Exception('NotAllowedError');

          throw Exception('Unsupported constraints in test: $constraints');
        },
      );

      final result = await subject.build(video: true, allowAudioFallback: true);

      expect(result, isA<MediaStream>());
      expect(attempts, ['audio:true,video:false', 'audio:false,video:true', 'audio:true,video:false']);
    });
  });

  group('DefaultUserMediaBuilder — error handling', () {
    test('does not retry when allowAudioFallback is false', () async {
      var callCount = 0;
      final subject = DefaultUserMediaBuilder(
        createLocalStream: fakeCreateLocalStream,
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
        createLocalStream: fakeCreateLocalStream,
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
        createLocalStream: fakeCreateLocalStream,
        getUserMedia: (_) async => throw Exception('no mic'),
      );

      await expectLater(subject.build(video: true, allowAudioFallback: true), throwsA(isA<UserMediaError>()));
    });

    test('wraps getUserMedia exception in UserMediaError', () async {
      final subject = DefaultUserMediaBuilder(
        createLocalStream: fakeCreateLocalStream,
        getUserMedia: (_) async => throw Exception('device not found'),
      );

      await expectLater(subject.build(video: false), throwsA(isA<UserMediaError>()));
    });

    test('UserMediaError message contains original error', () async {
      final subject = DefaultUserMediaBuilder(
        createLocalStream: fakeCreateLocalStream,
        getUserMedia: (_) async => throw Exception('device not found'),
      );

      UserMediaError? captured;
      await subject.build(video: false).catchError((Object e) {
        captured = e as UserMediaError;
        return localStreamFactory.create();
      });
      expect(captured?.message, contains('device not found'));
    });
  });
}
