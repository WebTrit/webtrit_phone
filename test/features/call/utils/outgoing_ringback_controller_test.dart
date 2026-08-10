import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/call.dart';

const _kDelay = Duration(seconds: 1);

class _Sound {
  int played = 0;
  int stopped = 0;
  bool playThrows = false;

  Future<void> play() async {
    played++;
    if (playThrows) throw StateError('audio focus denied');
  }

  Future<void> stop() async => stopped++;
}

/// Calls the test declares as still wanting the tone. Everything else - a call
/// that was answered, ended, picked up network audio or vanished - is not.
class _Wanted {
  _Wanted(Iterable<String> ids) : _ids = {...ids};

  final Set<String> _ids;

  bool call(String callId) => _ids.contains(callId);

  void drop(String callId) => _ids.remove(callId);
}

OutgoingRingbackController _controller(_Sound sound, _Wanted wanted) =>
    OutgoingRingbackController(play: sound.play, stop: sound.stop, isWanted: wanted.call, startDelay: _kDelay);

void main() {
  group('OutgoingRingbackController', () {
    test('does not start the tone before the wait is over', () {
      fakeAsync((async) {
        final sound = _Sound();
        _controller(sound, _Wanted(['call-1'])).ringing('call-1');

        async.elapse(_kDelay - const Duration(milliseconds: 1));
        expect(sound.played, 0);

        async.elapse(const Duration(milliseconds: 1));
        expect(sound.played, 1);
      });
    });

    test('starts nothing when the call no longer wants it', () {
      fakeAsync((async) {
        final sound = _Sound();
        _controller(sound, _Wanted([])).ringing('call-1');

        async.elapse(_kDelay * 2);
        expect(sound.played, 0);
      });
    });

    test('startNow cuts the wait short when the network rules out its audio', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound, _Wanted(['call-1']));
        controller.ringing('call-1');

        async.elapse(const Duration(milliseconds: 40));
        controller.startNow('call-1');
        expect(sound.played, 1);

        async.elapse(_kDelay * 2);
        expect(sound.played, 1, reason: 'no delayed start may be left pending');
      });
    });

    test('startNow still respects the call state (trailing plain answer)', () {
      fakeAsync((async) {
        final sound = _Sound();
        // The network already streams its own audio - a late plain alerting
        // answer must not bring the local tone back.
        _controller(sound, _Wanted([])).startNow('call-1');

        async.elapse(_kDelay * 2);
        expect(sound.played, 0);
      });
    });

    test('a repeated ringing answer keeps the original deadline', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound, _Wanted(['call-1']));
        controller.ringing('call-1');
        async.elapse(const Duration(milliseconds: 500));
        controller.ringing('call-1');
        controller.ringing('call-1');

        async.elapse(const Duration(milliseconds: 500));
        expect(sound.played, 1, reason: 'the tone must fire at the FIRST deadline, not be pushed out');

        async.elapse(_kDelay * 2);
        expect(sound.played, 1);
      });
    });

    test('a ringing answer while the tone already plays does not restart it', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound, _Wanted(['call-1']));
        controller.startNow('call-1');
        expect(sound.played, 1);

        // A forking switch keeps re-alerting long after the tone started.
        controller.ringing('call-1');
        async.elapse(_kDelay * 2);
        controller.startNow('call-1');

        expect(sound.played, 1, reason: 'the tone must not be restarted from its first beep');
      });
    });

    test('holdPending drops the wait without touching the tone', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound, _Wanted(['call-1']));
        controller.ringing('call-1');

        controller.holdPending('call-1');
        async.elapse(_kDelay * 2);
        expect(sound.played, 0);
        expect(sound.stopped, 0, reason: 'holdPending must not silence anything');

        // Wiring the network audio failed - the wait is armed again.
        controller.ringing('call-1');
        async.elapse(_kDelay);
        expect(sound.played, 1);
      });
    });

    test('a stop during the wait drops the pending start', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound, _Wanted(['call-1']));
        controller.ringing('call-1');

        async.elapse(const Duration(milliseconds: 300));
        controller.stop('call-1');

        async.elapse(_kDelay * 2);
        expect(sound.played, 0);
        expect(sound.stopped, 1);
      });
    });

    test('the tone survives another call stopping', () {
      fakeAsync((async) {
        final sound = _Sound();
        final wanted = _Wanted(['call-1']);
        final controller = _controller(sound, wanted);
        controller.startNow('call-1');
        expect(sound.played, 1);

        // A held call on another line ends - the ringing line keeps its tone.
        controller.stop('call-2');
        expect(sound.stopped, 0);

        wanted.drop('call-1');
        controller.stop('call-1');
        expect(sound.stopped, 1);
      });
    });

    test('the tone goes silent only when its last owner stops', () {
      fakeAsync((async) {
        final sound = _Sound();
        final wanted = _Wanted(['call-1', 'call-2']);
        final controller = _controller(sound, wanted);
        controller.startNow('call-1');
        controller.startNow('call-2');

        wanted.drop('call-1');
        controller.stop('call-1');
        expect(sound.stopped, 0);

        wanted.drop('call-2');
        controller.stop('call-2');
        expect(sound.stopped, 1);
      });
    });

    test('an owner that vanished without its own stop cannot keep the tone alive', () {
      fakeAsync((async) {
        final sound = _Sound();
        final wanted = _Wanted(['call-1', 'call-2']);
        final controller = _controller(sound, wanted);
        controller.startNow('call-1');
        controller.startNow('call-2');

        // call-2 is torn down through a path that never reaches the controller
        // (a dropped teardown event, a call popped from state elsewhere).
        wanted.drop('call-2');
        wanted.drop('call-1');
        controller.stop('call-1');

        expect(sound.stopped, 1, reason: 'the stale owner must be pruned, not keep the tone playing');
      });
    });

    test('a failing player is logged away, not thrown', () {
      fakeAsync((async) {
        final sound = _Sound()..playThrows = true;
        final wanted = _Wanted(['call-1']);
        final controller = _controller(sound, wanted);
        controller.startNow('call-1');
        async.elapse(Duration.zero);
        expect(sound.played, 1);

        sound.playThrows = false;
        controller.stop('call-1');
        controller.startNow('call-1');
        async.elapse(Duration.zero);
        expect(sound.played, 2, reason: 'a later start must still work');
      });
    });

    test('stopAll silences everything and drops pending starts', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound, _Wanted(['call-1', 'call-2']));
        controller.ringing('call-1');
        controller.ringing('call-2');

        controller.stopAll();
        async.elapse(_kDelay * 2);

        expect(sound.played, 0);
        expect(sound.stopped, 1);
      });
    });

    test('dispose leaves no timer behind', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound, _Wanted(['call-1']));
        controller.ringing('call-1');

        controller.dispose();
        async.elapse(_kDelay * 2);

        expect(sound.played, 0);
      });
    });
  });
}
