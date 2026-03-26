import 'dart:io';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

final _logger = Logger('AudioDeviceManager');

/// Manages platform audio routing on first call start and last call end.
///
/// On iOS, forces earpiece output on the first call to prevent the "sticky speaker"
/// issue where the previous session's speaker state bleeds into the new call.
/// On the last call end, resets the audio route to media profile on both platforms.
class AudioDeviceManager {
  /// Called when a new call is added to the active list.
  ///
  /// [activeCallCount] is the total count after the addition.
  /// Handles the first-call transition when [activeCallCount] is 1.
  void onCallStarted(int activeCallCount) {
    if (activeCallCount == 1) _onFirstCallStarted();
  }

  /// Called when a call is removed from the active list.
  ///
  /// [activeCallCount] is the total count after the removal.
  /// Handles the last-call transition when [activeCallCount] is 0.
  void onCallEnded(int activeCallCount) {
    if (activeCallCount == 0) _onLastCallEnded();
  }

  void _onFirstCallStarted() {
    _logger.info('Lifecycle: First call started');
    if (Platform.isIOS) Helper.setSpeakerphoneOn(false);
  }

  void _onLastCallEnded() {
    _logger.info('Lifecycle: Last call ended');
    if (Platform.isIOS) Helper.setSpeakerphoneOn(false);
    if (Platform.isAndroid) Helper.clearAndroidCommunicationDevice();
  }
}
