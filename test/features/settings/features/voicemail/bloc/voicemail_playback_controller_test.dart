import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/settings/features/voicemail/bloc/voicemail_playback_controller.dart';

class _MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(AudioSource.uri(Uri.parse('file:///fallback')));
    registerFallbackValue(Duration.zero);
  });

  late _MockAudioPlayer player;
  late StreamController<PlayerState> playerStateController;
  late VoicemailPlaybackController controller;

  setUp(() {
    player = _MockAudioPlayer();
    playerStateController = StreamController<PlayerState>.broadcast(sync: true);

    when(() => player.playerStateStream).thenAnswer((_) => playerStateController.stream);
    when(() => player.playing).thenReturn(false);
    when(() => player.stop()).thenAnswer((_) async {});
    when(() => player.dispose()).thenAnswer((_) async {});
    when(() => player.seek(any())).thenAnswer((_) async {});

    controller = VoicemailPlaybackController(player: player, setupAudioSession: () async {});
  });

  tearDown(() async {
    controller.dispose();
    await playerStateController.close();
  });

  final uri = Uri.parse('file:///test/audio.mp3');

  VoicemailPlaybackController build() => VoicemailPlaybackController(player: player, setupAudioSession: () async {});

  group('VoicemailPlaybackController', () {
    group('initial state', () {
      test('activeId is null, isLoading is false, error is null', () {
        expect(controller.activeId, isNull);
        expect(controller.isLoading, isFalse);
        expect(controller.error, isNull);
      });
    });

    group('play() -- new track', () {
      test('sets activeId immediately before any await', () {
        when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
        when(() => player.play()).thenAnswer((_) async {});

        unawaited(controller.play(id: 'track1', uri: uri, isLocal: true));

        expect(controller.activeId, 'track1');
      });

      test('does not set isLoading immediately (optimistic UI)', () {
        when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
        when(() => player.play()).thenAnswer((_) async {});

        unawaited(controller.play(id: 'track1', uri: uri, isLocal: true));

        expect(controller.isLoading, isFalse);
      });

      test('sets isLoading after debounce threshold when source is slow', () {
        fakeAsync((async) {
          final completer = Completer<Duration?>();
          when(() => player.setAudioSource(any())).thenAnswer((_) => completer.future);
          when(() => player.play()).thenAnswer((_) async {});

          unawaited(controller.play(id: 'track1', uri: uri, isLocal: true));
          async.flushMicrotasks();

          expect(controller.isLoading, isFalse);
          async.elapse(const Duration(milliseconds: 200));
          expect(controller.isLoading, isTrue);

          completer.complete(null);
        });
      });

      test('never sets isLoading when source resolves before debounce threshold', () {
        fakeAsync((async) {
          when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
          when(() => player.play()).thenAnswer((_) async {});

          unawaited(controller.play(id: 'track1', uri: uri, isLocal: true));
          async.flushMicrotasks();

          async.elapse(const Duration(milliseconds: 300));

          expect(controller.isLoading, isFalse);
        });
      });

      test('calls setAudioSource and play on the player', () async {
        when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
        when(() => player.play()).thenAnswer((_) async {});

        await controller.play(id: 'track1', uri: uri, isLocal: true);

        verify(() => player.setAudioSource(any())).called(1);
        verify(() => player.play()).called(1);
      });

      test('notifies listeners when activeId changes', () {
        when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
        when(() => player.play()).thenAnswer((_) async {});

        var notified = false;
        controller.addListener(() => notified = true);
        unawaited(controller.play(id: 'track1', uri: uri, isLocal: true));

        expect(notified, isTrue);
      });

      test('clears previous error when switching to a new track', () async {
        when(() => player.setAudioSource(any())).thenThrow(Exception('load error'));
        await controller.play(id: 'track1', uri: uri, isLocal: true);
        expect(controller.error, isNotNull);

        when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
        when(() => player.play()).thenAnswer((_) async {});
        unawaited(controller.play(id: 'track2', uri: uri, isLocal: true));

        expect(controller.error, isNull);
      });
    });

    group('play() -- same id', () {
      test('resumes player when same id is tapped while player is stopped', () async {
        when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
        when(() => player.play()).thenAnswer((_) async {});

        await controller.play(id: 'track1', uri: uri, isLocal: true);
        verify(() => player.play()).called(1);

        when(() => player.playing).thenReturn(false);
        await controller.play(id: 'track1', uri: uri, isLocal: true);

        verify(() => player.play()).called(1); // one more resume call
        verify(() => player.setAudioSource(any())).called(1); // loaded only once
      });

      test('does nothing when same id is tapped while already playing', () async {
        when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
        when(() => player.play()).thenAnswer((_) async {});

        await controller.play(id: 'track1', uri: uri, isLocal: true);
        clearInteractions(player);

        when(() => player.playing).thenReturn(true);
        await controller.play(id: 'track1', uri: uri, isLocal: true);

        verifyNever(() => player.setAudioSource(any()));
        verifyNever(() => player.play());
      });

      test('retries setAudioSource when same id is tapped after an error', () async {
        when(() => player.setAudioSource(any())).thenThrow(Exception('load error'));
        await controller.play(id: 'track1', uri: uri, isLocal: true);
        expect(controller.error, isNotNull);

        when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
        when(() => player.play()).thenAnswer((_) async {});

        await controller.play(id: 'track1', uri: uri, isLocal: true);

        expect(controller.error, isNull);
        verify(() => player.setAudioSource(any())).called(2);
      });
    });

    group('race condition guard', () {
      test('stale async chain does not update state after a newer play() starts', () {
        fakeAsync((async) {
          final completerA = Completer<Duration?>();
          var callCount = 0;
          when(() => player.setAudioSource(any())).thenAnswer((_) {
            callCount++;
            return callCount == 1 ? completerA.future : Future.value(null);
          });
          when(() => player.play()).thenAnswer((_) async {});

          // Start track A -- its setAudioSource hangs
          unawaited(controller.play(id: 'trackA', uri: uri, isLocal: true));
          async.flushMicrotasks();

          // Start track B before A completes
          unawaited(controller.play(id: 'trackB', uri: uri, isLocal: true));
          async.flushMicrotasks();

          expect(controller.activeId, 'trackB');

          // Now A's setAudioSource completes -- state must remain on B
          completerA.complete(null);
          async.flushMicrotasks();

          expect(controller.activeId, 'trackB');
          expect(controller.error, isNull);
        });
      });

      test('debounce loading timer does not fire for stale generation', () {
        fakeAsync((async) {
          final completerA = Completer<Duration?>();
          var callCount = 0;
          when(() => player.setAudioSource(any())).thenAnswer((_) {
            callCount++;
            return callCount == 1 ? completerA.future : Future.value(null);
          });
          when(() => player.play()).thenAnswer((_) async {});

          unawaited(controller.play(id: 'trackA', uri: uri, isLocal: true));
          async.flushMicrotasks();

          // Switch to B before the 200ms debounce fires
          unawaited(controller.play(id: 'trackB', uri: uri, isLocal: true));
          async.flushMicrotasks();

          // Advance past debounce -- A's timer was cancelled, B's fires but
          // B's source already resolved (callCount==2 returns immediately)
          async.elapse(const Duration(milliseconds: 300));

          expect(controller.isLoading, isFalse);

          completerA.complete(null);
        });
      });
    });

    group('error handling', () {
      test('sets error and clears isLoading when setAudioSource throws', () async {
        final exception = Exception('load error');
        when(() => player.setAudioSource(any())).thenThrow(exception);

        await controller.play(id: 'track1', uri: uri, isLocal: true);

        expect(controller.error, exception);
        expect(controller.isLoading, isFalse);
        expect(controller.activeId, 'track1');
      });

      test('stops player on setAudioSource error', () async {
        when(() => player.setAudioSource(any())).thenThrow(Exception('load error'));

        await controller.play(id: 'track1', uri: uri, isLocal: true);

        verify(() => player.stop()).called(1);
      });
    });

    group('stop()', () {
      test('clears activeId, error and isLoading, stops the player and notifies', () async {
        when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
        when(() => player.play()).thenAnswer((_) async {});
        await controller.play(id: 'track1', uri: uri, isLocal: true);
        expect(controller.activeId, 'track1');

        var notified = false;
        controller.addListener(() => notified = true);
        await controller.stop();

        expect(controller.activeId, isNull);
        expect(controller.error, isNull);
        expect(controller.isLoading, isFalse);
        expect(notified, isTrue);
        verify(() => player.stop()).called(1);
      });

      test('invalidates an in-flight play() chain', () {
        fakeAsync((async) {
          final completer = Completer<Duration?>();
          when(() => player.setAudioSource(any())).thenAnswer((_) => completer.future);
          when(() => player.play()).thenAnswer((_) async {});

          unawaited(controller.play(id: 'track1', uri: uri, isLocal: true));
          async.flushMicrotasks();

          unawaited(controller.stop());
          async.flushMicrotasks();
          expect(controller.activeId, isNull);

          // The stale chain resolves -- it must not resurrect the track or start playback.
          completer.complete(null);
          async.flushMicrotasks();

          expect(controller.activeId, isNull);
          verifyNever(() => player.play());
        });
      });

      test('cancels a pending loading debounce', () {
        fakeAsync((async) {
          final completer = Completer<Duration?>();
          when(() => player.setAudioSource(any())).thenAnswer((_) => completer.future);

          unawaited(controller.play(id: 'track1', uri: uri, isLocal: true));
          async.flushMicrotasks();

          unawaited(controller.stop());
          async.elapse(const Duration(milliseconds: 300));

          expect(controller.isLoading, isFalse);

          completer.complete(null);
        });
      });
    });

    group('pause / resume / seek', () {
      test('pause() delegates to player.pause()', () async {
        when(() => player.pause()).thenAnswer((_) async {});
        await controller.pause();
        verify(() => player.pause()).called(1);
      });

      test('resume() delegates to player.play()', () async {
        when(() => player.play()).thenAnswer((_) async {});
        await controller.resume();
        verify(() => player.play()).called(1);
      });

      test('seek() delegates to player.seek()', () {
        controller.seek(const Duration(seconds: 10));
        verify(() => player.seek(const Duration(seconds: 10))).called(1);
      });
    });

    group('app lifecycle', () {
      test('stops player when app is paused', () {
        controller.didChangeAppLifecycleState(AppLifecycleState.paused);
        verify(() => player.stop()).called(1);
      });

      test('does not stop player on other lifecycle states', () {
        controller.didChangeAppLifecycleState(AppLifecycleState.resumed);
        controller.didChangeAppLifecycleState(AppLifecycleState.inactive);
        verifyNever(() => player.stop());
      });
    });

    group('playback completion', () {
      test('resets player to start when track finishes', () async {
        playerStateController.add(PlayerState(false, ProcessingState.completed));
        await Future<void>.delayed(Duration.zero);

        verify(() => player.stop()).called(1);
        verify(() => player.seek(Duration.zero)).called(1);
      });
    });

    group('dispose', () {
      test('pending loading debounce does not fire after dispose', () {
        fakeAsync((async) {
          final c = build();
          final completer = Completer<Duration?>();
          when(() => player.setAudioSource(any())).thenAnswer((_) => completer.future);

          unawaited(c.play(id: 'track1', uri: uri, isLocal: true));
          async.flushMicrotasks();

          c.dispose();

          async.elapse(const Duration(milliseconds: 300));
          expect(c.isLoading, isFalse);

          completer.complete(null);
        });
      });

      test('disposes and stops player on dispose', () async {
        final c = build();
        c.dispose();
        await Future<void>.delayed(Duration.zero);

        verify(() => player.stop()).called(1);
        verify(() => player.dispose()).called(1);
      });
    });

    group('resolveCacheFile -- path traversal', () {
      const base = '/var/cache/voicemail';
      final remote = Uri.parse('https://example.com/vm/audio.mp3');

      test('returns null when cacheBasePath is null', () {
        expect(controller.resolveCacheFile(cacheBasePath: null, uri: remote, cacheKey: 'k'), isNull);
      });

      test('keeps a plain cacheKey under cacheBasePath', () {
        final file = controller.resolveCacheFile(cacheBasePath: base, uri: remote, cacheKey: 'vm-42');
        expect(file!.path, '$base/vm-42');
      });

      test('strips path separators from cacheKey', () {
        final file = controller.resolveCacheFile(cacheBasePath: base, uri: remote, cacheKey: '../../etc/passwd');
        expect(file!.path, '$base/.._.._etc_passwd');
      });

      test('rejects a cacheKey of ".." (would escape via path.join)', () {
        expect(controller.resolveCacheFile(cacheBasePath: base, uri: remote, cacheKey: '..'), isNull);
      });

      test('rejects a cacheKey of "."', () {
        expect(controller.resolveCacheFile(cacheBasePath: base, uri: remote, cacheKey: '.'), isNull);
      });

      test('falls back to sanitized uri path segments when cacheKey is null', () {
        final file = controller.resolveCacheFile(cacheBasePath: base, uri: remote, cacheKey: null);
        expect(file!.path, '$base/vm_audio.mp3');
      });
    });
  });
}
