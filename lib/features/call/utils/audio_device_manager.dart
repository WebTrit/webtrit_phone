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
  /// Called whenever the active call list changes.
  ///
  /// Pass the previous and current counts to detect first-call and last-call transitions.
  void handleCallListChange({required bool wasEmpty, required bool isEmpty}) {
    if (wasEmpty && !isEmpty) _onFirstCallStarted();
    if (!wasEmpty && isEmpty) _onLastCallEnded();
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
