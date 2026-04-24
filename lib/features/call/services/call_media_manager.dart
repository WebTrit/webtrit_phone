import 'dart:io';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import '../models/models.dart';

final _logger = Logger('CallMediaManager');

/// Single point of control for all audio and video-triggered routing decisions.
///
/// Encapsulates [webtrit_callkeep] and [flutter_webrtc] audio APIs so that
/// [CallBloc] has no direct dependency on either plugin's audio surface.
///
/// Responsibilities:
/// - Platform-specific device routing (Android via Telecom, iOS via AVAudioSession)
/// - iOS audio session lifecycle ([didActivateAudioSession], [didDeactivateAudioSession])
/// - iOS manual audio management setup ([AppleNativeAudioManagement])
/// - Video-triggered routing: speaker on video enable, voice mode restore on disable
/// - Cleanup after call sessions end
///
/// [CallBloc] retains ownership of [CallState.audioDevice] and
/// [CallState.availableAudioDevices] — this class does not emit state.
/// It is a pure side-effect coordinator.
class CallMediaManager {
  CallMediaManager({required Callkeep callkeep}) : _callkeep = callkeep {
    _configure();
  }

  final Callkeep _callkeep;

  // Audio device priority for voice calls on Android.
  // AudioSwitch selects the first available device from this list on activate().
  // Earpiece before Speakerphone ensures voice calls start on earpiece.
  // Video calls override this via onVideoEnabled() after stream setup.
  static const _voiceCallOutputOrder = [
    AndroidAudioOutputDevice.bluetooth,
    AndroidAudioOutputDevice.wiredHeadset,
    AndroidAudioOutputDevice.earpiece,
    AndroidAudioOutputDevice.speakerphone,
  ];

  void _configure() {
    if (Platform.isAndroid) {
      AndroidNativeAudioManagement.setAndroidAudioConfiguration(
        AndroidAudioConfiguration(preferredOutputOrder: _voiceCallOutputOrder),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Call session lifecycle
  // ---------------------------------------------------------------------------

  /// Called for every individual call start event from signaling.
  ///
  /// On iOS: activates manual audio management so the app controls
  /// AVAudioSession activation instead of WebRTC doing it automatically.
  void onCallStarted() {
    if (Platform.isIOS) {
      AppleNativeAudioManagement.setUseManualAudio(true);
    }
  }

  /// Called when the first active call appears (0 → 1 transition).
  ///
  /// On iOS: resets sticky speaker state inherited from a previous session.
  void onFirstCallStarted() {
    _logger.info('onFirstCallStarted');
    if (Platform.isIOS) Helper.setSpeakerphoneOn(false);
  }

  /// Called when the last active call ends (N → 0 transition).
  ///
  /// iOS: releases AVAudioSession from voice chat mode.
  /// Android: clears the communication device, switching audio back from
  /// SCO (call profile) to A2DP (media profile). Without this, apps like
  /// YouTube or music players continue using degraded call-quality audio.
  void onLastCallEnded() {
    _logger.info('onLastCallEnded');
    if (Platform.isIOS) Helper.setSpeakerphoneOn(false);
    if (Platform.isAndroid) Helper.clearAndroidCommunicationDevice();
  }

  // ---------------------------------------------------------------------------
  // iOS audio session (WebtritCallkeepDelegate callbacks)
  // ---------------------------------------------------------------------------

  /// Called by [WebtritCallkeepDelegate.didActivateAudioSession].
  ///
  /// Signals to WebRTC that the AVAudioSession is active and audio I/O
  /// can begin. No-op on Android.
  void didActivateAudioSession() {
    if (!Platform.isIOS) return;
    _logger.fine('didActivateAudioSession');
    () async {
      await AppleNativeAudioManagement.audioSessionDidActivate();
      await AppleNativeAudioManagement.setIsAudioEnabled(true);
    }();
  }

  /// Called by [WebtritCallkeepDelegate.didDeactivateAudioSession].
  ///
  /// Signals to WebRTC that the AVAudioSession is about to deactivate.
  /// No-op on Android.
  void didDeactivateAudioSession() {
    if (!Platform.isIOS) return;
    _logger.fine('didDeactivateAudioSession');
    () async {
      await AppleNativeAudioManagement.setIsAudioEnabled(false);
      await AppleNativeAudioManagement.audioSessionDidDeactivate();
    }();
  }

  // ---------------------------------------------------------------------------
  // Device selection
  // ---------------------------------------------------------------------------

  /// Routes audio to [device] for the given [callId].
  ///
  /// Android: delegates to Telecom via [WebtritCallkeep.setAudioDevice].
  /// iOS: uses [Helper.setSpeakerphoneOn] and [Helper.selectAudioInput].
  Future<void> setDevice(String callId, CallAudioDevice device) async {
    _logger.info('setDevice: ${device.type} (id=${device.id}) for call $callId');
    if (Platform.isAndroid) {
      // AudioSwitch owns hardware routing — must be called first.
      // callkeep's setAudioDevice uses directRouteAudioDevice (setSpeakerphoneOn/setCommunicationDevice)
      // which bypasses AudioSwitch and can be overridden by it. Calling AudioSwitch directly
      // ensures the hardware route sticks.
      Helper.setSpeakerphoneOn(device.type == CallAudioDeviceType.speaker);
      _callkeep.setAudioDevice(callId, device.toCallkeep());
    } else if (Platform.isIOS) {
      if (device.type == CallAudioDeviceType.speaker) {
        Helper.setSpeakerphoneOn(true);
      } else {
        Helper.setSpeakerphoneOn(false);
        final deviceId = device.id;
        if (deviceId != null) Helper.selectAudioInput(deviceId);
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Video-triggered audio routing
  // ---------------------------------------------------------------------------

  /// Called when video is enabled (camera turned on during a call).
  ///
  /// Android: explicitly routes audio to speakerphone, mirroring iOS behavior
  /// where WebRTC automatically switches to speaker via AVAudioSession
  /// VideoChat mode when a video track is added.
  /// iOS: no-op — the mode switch is handled by WebRTC internally.
  Future<void> onVideoEnabled(String callId) async {
    _logger.info('onVideoEnabled: $callId');
    if (Platform.isAndroid) {
      await setDevice(callId, const CallAudioDevice(type: CallAudioDeviceType.speaker));
    }
    // iOS: WebRTC sets AVAudioSessionModeVideoChat automatically when a video
    // track is added, which routes audio to the speaker.
  }

  /// Called when video is disabled (camera turned off during a call).
  ///
  /// Reverts audio routing back to voice mode on both platforms.
  /// Skipped when the user has explicitly chosen speaker ([speakerActive])
  /// so their preference is preserved after turning the camera off.
  ///
  /// iOS: resets the shared [RTCAudioSessionConfiguration] singleton from
  /// VideoChat → VoiceChat before calling [Helper.setSpeakerphoneOn(false)].
  /// Without this reset, [setSpeakerphoneOn(false)] re-applies VideoChat mode
  /// and keeps audio on speaker regardless of port override.
  ///
  /// Android: routes audio back to earpiece via Telecom.
  Future<void> onVideoDisabled(String callId, {required bool speakerActive}) async {
    _logger.info('onVideoDisabled: $callId speakerActive=$speakerActive');
    if (speakerActive) return;
    if (Platform.isIOS) {
      await Helper.setAppleAudioConfiguration(AppleAudioConfiguration(appleAudioMode: AppleAudioMode.voiceChat));
      await Helper.setSpeakerphoneOn(false);
    }
    if (Platform.isAndroid) {
      await setDevice(callId, const CallAudioDevice(type: CallAudioDeviceType.earpiece));
    }
  }
}
