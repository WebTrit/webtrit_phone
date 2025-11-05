import 'dart:async';
import 'dart:ui';

class MultiTapTrigger {
  MultiTapTrigger({required this.onTriggered, this.requiredTapCount = 5, this.timeout = const Duration(seconds: 2)});

  final int requiredTapCount;
  final Duration timeout;
  final VoidCallback onTriggered;

  int _tapCounter = 0;
  Timer? _resetTimer;

  void tap() {
    _resetTimer?.cancel();

    _tapCounter++;
    if (_tapCounter >= requiredTapCount) {
      _tapCounter = 0;
      onTriggered();
    } else {
      _resetTimer = Timer(timeout, () {
        _tapCounter = 0;
      });
    }
  }

  void dispose() {
    _resetTimer?.cancel();
  }
}
