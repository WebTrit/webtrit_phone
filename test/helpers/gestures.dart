import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

/// A press in progress: the finger is down and the test decides how it ends.
///
/// Gesture tests read as the sequence a finger actually performs - press,
/// hold, slide off, lift - rather than as raw pointer events. The distances
/// and timings that decide the outcome are named here once, so a test says
/// what it exercises instead of spelling out an offset whose significance
/// the reader has to recognise.
class Press {
  Press._(this._tester, this._gesture);

  final WidgetTester _tester;
  final TestGesture _gesture;

  /// Keeps the finger down for [duration] of test time.
  Future<void> hold(Duration duration) => _tester.pump(duration);

  /// Slides the finger clear of the widget it landed on.
  ///
  /// Going past the touch slop is the whole point: that is where the
  /// framework stops treating the press as a tap on that widget and cancels
  /// the recognizers waiting on it.
  Future<void> slideOff() async {
    await _gesture.moveBy(const Offset(kTouchSlop * 3, 0));
    await _tester.pump();
  }

  /// Lifts the finger, ending the press the ordinary way.
  Future<void> lift() async {
    await _gesture.up();
    await _tester.pumpAndSettle();
  }

  /// Ends the press the way the platform does when it takes the gesture over -
  /// a shade pulled down, a call arriving. No release ever arrives, so a
  /// widget that only listens for one has to cope with this on its own.
  Future<void> takenOverByPlatform() async {
    await _gesture.cancel();
    await _tester.pumpAndSettle();
  }
}

extension PressGestures on WidgetTester {
  /// Puts a finger down on [finder] and hands back the press in progress.
  ///
  /// Pass [pointer] to keep two presses apart when a test needs them to
  /// overlap on the same widget.
  Future<Press> pressOn(Finder finder, {int? pointer}) async {
    final gesture = await startGesture(getCenter(finder), pointer: pointer);
    return Press._(this, gesture);
  }
}
