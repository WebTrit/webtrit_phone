import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/features/call/bridge/platform_bridge.dart';
import 'package:webtrit_phone/features/call/bridge/platform_event.dart';

// ---------------------------------------------------------------------------
// Fallback values required by mocktail
// ---------------------------------------------------------------------------

class _FakeCallkeepHandle extends Fake implements CallkeepHandle {}

class _FakeCallkeepAudioDevice extends Fake implements CallkeepAudioDevice {}

// ---------------------------------------------------------------------------
// Mock
// ---------------------------------------------------------------------------

class MockCallkeep extends Mock implements Callkeep {}

// ---------------------------------------------------------------------------

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeCallkeepHandle());
    registerFallbackValue(_FakeCallkeepAudioDevice());
    registerFallbackValue(<CallkeepAudioDevice>[]);
  });

  late MockCallkeep callkeep;
  late PlatformBridgeImpl bridge;

  setUp(() {
    callkeep = MockCallkeep();
    when(() => callkeep.setDelegate(any())).thenReturn(null);
    bridge = PlatformBridgeImpl(callkeep: callkeep);
  });

  // -------------------------------------------------------------------------
  // Construction
  // -------------------------------------------------------------------------

  group('construction', () {
    test('registers itself as callkeep delegate on creation', () {
      verify(() => callkeep.setDelegate(bridge)).called(1);
    });
  });

  // -------------------------------------------------------------------------
  // dispose
  // -------------------------------------------------------------------------

  group('dispose', () {
    test('de-registers delegate and closes stream', () async {
      bridge.dispose();

      verify(() => callkeep.setDelegate(null)).called(1);
      expect(bridge.events.isEmpty, completes);
    });

    test('completes pending perform events with false on dispose', () {
      fakeAsync((async) {
        bool? result;
        final future = bridge.performEndCall('call-1');
        unawaited(future.then((v) => result = v));

        bridge.dispose();
        async.flushMicrotasks();

        expect(result, isFalse);
      });
    });

    test('second dispose is a no-op', () {
      bridge.dispose();
      // A second dispose must not throw.
      expect(() => bridge.dispose(), returnsNormally);
    });
  });

  // -------------------------------------------------------------------------
  // continueStartCallIntent
  // -------------------------------------------------------------------------

  group('continueStartCallIntent', () {
    test('emits StartCallIntentPlatformEvent', () {
      fakeAsync((async) {
        PlatformEvent? received;
        bridge.events.listen((e) => received = e);

        bridge.continueStartCallIntent(const CallkeepHandle.number('100'), 'Alice', true);
        async.flushMicrotasks();

        expect(received, isA<StartCallIntentPlatformEvent>());
        final event = received! as StartCallIntentPlatformEvent;
        expect(event.handle, const CallkeepHandle.number('100'));
        expect(event.displayName, 'Alice');
        expect(event.video, isTrue);

        bridge.dispose();
      });
    });

    test('does not emit after dispose', () {
      fakeAsync((async) {
        final received = <PlatformEvent>[];
        bridge.events.listen(received.add);
        bridge.dispose();

        bridge.continueStartCallIntent(const CallkeepHandle.number('100'), null, false);
        async.flushMicrotasks();

        expect(received, isEmpty);
      });
    });
  });

  // -------------------------------------------------------------------------
  // didPushIncomingCall
  // -------------------------------------------------------------------------

  group('didPushIncomingCall', () {
    test('emits PushIncomingCallPlatformEvent with correct fields', () {
      fakeAsync((async) {
        PlatformEvent? received;
        bridge.events.listen((e) => received = e);

        bridge.didPushIncomingCall(const CallkeepHandle.number('200'), 'Bob', false, 'push-id', null);
        async.flushMicrotasks();

        expect(received, isA<PushIncomingCallPlatformEvent>());
        final event = received! as PushIncomingCallPlatformEvent;
        expect(event.callId, 'push-id');
        expect(event.handle, const CallkeepHandle.number('200'));
        expect(event.displayName, 'Bob');
        expect(event.video, isFalse);
        expect(event.error, isNull);

        bridge.dispose();
      });
    });
  });

  // -------------------------------------------------------------------------
  // perform* callbacks
  // -------------------------------------------------------------------------

  group('performStartCall', () {
    test('emits StartCallPerformEvent and returns future resolved by complete(true)', () {
      fakeAsync((async) {
        StartCallPerformEvent? emitted;
        bridge.events.listen((e) {
          if (e is StartCallPerformEvent) emitted = e;
        });

        bool? nativeResult;
        final future = bridge.performStartCall('call-1', const CallkeepHandle.number('300'), 'Carl', false);
        unawaited(future.then((v) => nativeResult = v));
        async.flushMicrotasks();

        expect(emitted, isNotNull);
        expect(emitted!.callId, 'call-1');

        emitted!.complete(true);
        async.flushMicrotasks();

        expect(nativeResult, isTrue);

        bridge.dispose();
      });
    });

    test('complete(false) resolves native future with false', () {
      fakeAsync((async) {
        StartCallPerformEvent? emitted;
        bridge.events.listen((e) {
          if (e is StartCallPerformEvent) emitted = e;
        });

        bool? nativeResult;
        final future = bridge.performStartCall('call-2', const CallkeepHandle.number('301'), null, true);
        unawaited(future.then((v) => nativeResult = v));
        async.flushMicrotasks();

        emitted!.complete(false);
        async.flushMicrotasks();

        expect(nativeResult, isFalse);

        bridge.dispose();
      });
    });

    test('complete is idempotent — second call is ignored', () {
      fakeAsync((async) {
        StartCallPerformEvent? emitted;
        bridge.events.listen((e) {
          if (e is StartCallPerformEvent) emitted = e;
        });

        final results = <bool>[];
        final future = bridge.performStartCall('call-3', const CallkeepHandle.number('302'), null, false);
        unawaited(future.then(results.add));
        async.flushMicrotasks();

        emitted!.complete(true);
        emitted!.complete(false); // second call must be ignored
        async.flushMicrotasks();

        expect(results, [true]);

        bridge.dispose();
      });
    });
  });

  group('performAnswerCall', () {
    test('emits AnswerCallPerformEvent', () {
      fakeAsync((async) {
        AnswerCallPerformEvent? emitted;
        bridge.events.listen((e) {
          if (e is AnswerCallPerformEvent) emitted = e;
        });

        bridge.performAnswerCall('call-a');
        async.flushMicrotasks();

        expect(emitted, isNotNull);
        expect(emitted!.callId, 'call-a');

        emitted!.complete(true);
        bridge.dispose();
      });
    });
  });

  group('performEndCall', () {
    test('emits EndCallPerformEvent', () {
      fakeAsync((async) {
        EndCallPerformEvent? emitted;
        bridge.events.listen((e) {
          if (e is EndCallPerformEvent) emitted = e;
        });

        bridge.performEndCall('call-e');
        async.flushMicrotasks();

        expect(emitted, isNotNull);
        expect(emitted!.callId, 'call-e');

        emitted!.complete(true);
        bridge.dispose();
      });
    });
  });

  group('performSetHeld', () {
    test('emits SetHeldPerformEvent with correct onHold value', () {
      fakeAsync((async) {
        SetHeldPerformEvent? emitted;
        bridge.events.listen((e) {
          if (e is SetHeldPerformEvent) emitted = e;
        });

        bridge.performSetHeld('call-h', true);
        async.flushMicrotasks();

        expect(emitted!.callId, 'call-h');
        expect(emitted!.onHold, isTrue);

        emitted!.complete(true);
        bridge.dispose();
      });
    });
  });

  group('performSetMuted', () {
    test('emits SetMutedPerformEvent with correct muted value', () {
      fakeAsync((async) {
        SetMutedPerformEvent? emitted;
        bridge.events.listen((e) {
          if (e is SetMutedPerformEvent) emitted = e;
        });

        bridge.performSetMuted('call-m', true);
        async.flushMicrotasks();

        expect(emitted!.callId, 'call-m');
        expect(emitted!.muted, isTrue);

        emitted!.complete(true);
        bridge.dispose();
      });
    });
  });

  group('performSendDTMF', () {
    test('emits SendDtmfPerformEvent with key', () {
      fakeAsync((async) {
        SendDtmfPerformEvent? emitted;
        bridge.events.listen((e) {
          if (e is SendDtmfPerformEvent) emitted = e;
        });

        bridge.performSendDTMF('call-d', '5');
        async.flushMicrotasks();

        expect(emitted!.callId, 'call-d');
        expect(emitted!.key, '5');

        emitted!.complete(true);
        bridge.dispose();
      });
    });
  });

  // -------------------------------------------------------------------------
  // Multiple pending performs
  // -------------------------------------------------------------------------

  group('multiple pending performs', () {
    test('each perform event resolves independently', () {
      fakeAsync((async) {
        final emitted = <PerformCallEvent>[];
        bridge.events.listen((e) {
          if (e is PerformCallEvent) emitted.add(e);
        });

        bool? result1, result2;
        unawaited(bridge.performEndCall('call-x').then((v) => result1 = v));
        unawaited(bridge.performEndCall('call-y').then((v) => result2 = v));
        async.flushMicrotasks();

        expect(emitted, hasLength(2));
        emitted[0].complete(true);
        emitted[1].complete(false);
        async.flushMicrotasks();

        expect(result1, isTrue);
        expect(result2, isFalse);

        bridge.dispose();
      });
    });

    test('dispose fails all remaining pending performs', () {
      fakeAsync((async) {
        final results = <bool>[];
        unawaited(bridge.performEndCall('call-p').then(results.add));
        unawaited(bridge.performAnswerCall('call-q').then(results.add));
        async.flushMicrotasks();

        bridge.dispose();
        async.flushMicrotasks();

        expect(results, [false, false]);
      });
    });
  });
}
