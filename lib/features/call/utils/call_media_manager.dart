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
      _android.setAndroidAudioConfiguration(AndroidAudioConfiguration(preferredOutputOrder: _voiceCallOutputOrder));
    }
    if (Platform.isIOS) _apple.setUseManualAudio(true);
  }

  // ---------------------------------------------------------------------------
  // Call session lifecycle
  // ---------------------------------------------------------------------------

  void clearCommunicationDevice() => _helper.clearAndroidCommunicationDevice();

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
      if (device.type == CallAudioDeviceType.speaker) {
        setSpeaker(callId, enabled: true);
      } else {
        Helper.setSpeakerphoneOn(false);
        _callkeep.setAudioDevice(callId, device.toCallkeep());
      }
    } else if (Platform.isIOS) {
      if (device.type == CallAudioDeviceType.speaker) {
        setSpeaker(callId, enabled: true);
      } else {
        setSpeaker(callId, enabled: false);
        final deviceId = device.id;
        if (deviceId != null) Helper.selectAudioInput(deviceId);
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Speaker helpers
  // ---------------------------------------------------------------------------

  // On Android both plugins must be called for cross-OEM compatibility:
  // - Helper.setSpeakerphoneOn (AudioSwitch/flutter-webrtc): AOSP and devices
  //   where AudioSwitch owns hardware routing and overrides direct AudioManager calls.
  // - callkeep.setAudioDevice (Telecom): MIUI and OEMs that ignore direct
  //   AudioManager calls and only respond to Telecom routing.
  // On iOS Helper.setSpeakerphoneOn is sufficient — no Telecom layer involved.

  void setSpeaker(String? callId, {required bool enabled}) {
    Helper.setSpeakerphoneOn(enabled);
    if (Platform.isAndroid && callId != null) {
      _callkeep.setAudioDevice(
        callId,
        CallAudioDevice(type: enabled ? CallAudioDeviceType.speaker : CallAudioDeviceType.earpiece).toCallkeep(),
      );
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
    if (Platform.isAndroid) setSpeaker(callId, enabled: true);
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
    setSpeaker(callId, enabled: false);
  }
}
