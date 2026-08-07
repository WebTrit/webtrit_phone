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

OutgoingRingbackController _controller(_Sound sound) =>
    OutgoingRingbackController(play: sound.play, stop: sound.stop, startDelay: _kDelay);

void main() {
  group('OutgoingRingbackController', () {
    test('does not start the tone before the wait is over', () {
      fakeAsync((async) {
        final sound = _Sound();
        _controller(sound).ringing('call-1', stillWanted: () => true);

        async.elapse(_kDelay - const Duration(milliseconds: 1));
        expect(sound.played, 0);

        async.elapse(const Duration(milliseconds: 1));
        expect(sound.played, 1);
      });
    });

    test('starts nothing when the call no longer wants it', () {
      fakeAsync((async) {
        final sound = _Sound();
        _controller(sound).ringing('call-1', stillWanted: () => false);

        async.elapse(_kDelay * 2);
        expect(sound.played, 0);
      });
    });

    test('startNow cuts the wait short when the network rules out its audio', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound);
        controller.ringing('call-1', stillWanted: () => true);

        async.elapse(const Duration(milliseconds: 40));
        controller.startNow('call-1', stillWanted: () => true);
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
        _controller(sound).startNow('call-1', stillWanted: () => false);

        async.elapse(_kDelay * 2);
        expect(sound.played, 0);
      });
    });

    test('startNow of one call leaves the wait of another untouched', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound);
        controller.ringing('call-1', stillWanted: () => true);
        controller.startNow('call-2', stillWanted: () => true);
        expect(sound.played, 1);

        async.elapse(_kDelay);
        expect(sound.played, 2, reason: 'call-1 keeps its own delayed start');
      });
    });

    test('a stop during the wait drops the pending start', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound);
        controller.ringing('call-1', stillWanted: () => true);

        async.elapse(const Duration(milliseconds: 300));
        controller.stop('call-1');

        async.elapse(_kDelay * 2);
        expect(sound.played, 0);
        expect(sound.stopped, 1);
      });
    });

    test('a repeated ringing answer keeps the original deadline', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound);
        controller.ringing('call-1', stillWanted: () => true);
        async.elapse(const Duration(milliseconds: 500));
        controller.ringing('call-1', stillWanted: () => true);
        controller.ringing('call-1', stillWanted: () => true);

        async.elapse(const Duration(milliseconds: 500));
        expect(sound.played, 1, reason: 'the tone must fire at the FIRST deadline, not be pushed out');

        async.elapse(_kDelay * 2);
        expect(sound.played, 1);
      });
    });

    test('the tone survives another call stopping', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound);
        controller.startNow('call-1', stillWanted: () => true);
        expect(sound.played, 1);

        // A held call on another line ends - the ringing line keeps its tone.
        controller.stop('call-2');
        expect(sound.stopped, 0);

        controller.stop('call-1');
        expect(sound.stopped, 1);
      });
    });

    test('the tone goes silent only when its last owner stops', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound);
        controller.startNow('call-1', stillWanted: () => true);
        controller.startNow('call-2', stillWanted: () => true);

        controller.stop('call-1');
        expect(sound.stopped, 0);

        controller.stop('call-2');
        expect(sound.stopped, 1);
      });
    });

    test('a failing player is logged away, not thrown', () {
      fakeAsync((async) {
        final sound = _Sound()..playThrows = true;
        final controller = _controller(sound);
        controller.startNow('call-1', stillWanted: () => true);
        async.elapse(Duration.zero);
        expect(sound.played, 1);

        sound.playThrows = false;
        controller.startNow('call-1', stillWanted: () => true);
        async.elapse(Duration.zero);
        expect(sound.played, 2, reason: 'a later start must still work');
      });
    });

    test('one call does not cancel the wait of another', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound);
        controller.ringing('call-1', stillWanted: () => true);
        controller.ringing('call-2', stillWanted: () => true);

        controller.stop('call-1');
        async.elapse(_kDelay * 2);

        expect(sound.played, 1);
      });
    });

    test('stopAll silences everything and drops pending starts', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound);
        controller.ringing('call-1', stillWanted: () => true);
        controller.ringing('call-2', stillWanted: () => true);

        controller.stopAll();
        async.elapse(_kDelay * 2);

        expect(sound.played, 0);
        expect(sound.stopped, 1);
      });
    });

    test('dispose leaves no timer behind', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound);
        controller.ringing('call-1', stillWanted: () => true);

        controller.dispose();
        async.elapse(_kDelay * 2);

        expect(sound.played, 0);
      });
    });
  });
}
