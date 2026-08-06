import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/call.dart';

const _kDelay = Duration(seconds: 1);

class _Sound {
  int played = 0;
  int stopped = 0;

  Future<void> play() async => played++;

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

    test('a repeated ringing answer does not queue a second start', () {
      fakeAsync((async) {
        final sound = _Sound();
        final controller = _controller(sound);
        controller.ringing('call-1', stillWanted: () => true);
        async.elapse(const Duration(milliseconds: 500));
        controller.ringing('call-1', stillWanted: () => true);

        async.elapse(_kDelay * 2);
        expect(sound.played, 1);
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
