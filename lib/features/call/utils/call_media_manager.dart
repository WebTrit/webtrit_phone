import 'dart:async';
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
/// - Video-triggered routing: speaker on video enable, voice mode restore on disable
/// - Speaker toggle with cross-OEM compatibility ([setSpeaker])
/// - Android communication device cleanup after calls ([clearCommunicationDevice])
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

  // Sets Android audio output priority and enables iOS manual AVAudioSession
  // management so CallKit controls activation instead of WebRTC doing it automatically.
  void _configure() {
    if (Platform.isAndroid) {
      // manageAudioFocus: false — Telecom owns audio focus for VoIP calls.
      // Dual ownership with AudioSwitch leaves volume stuck in call mode on older MIUI (WT-1429).
      AndroidNativeAudioManagement.setAndroidAudioConfiguration(
        AndroidAudioConfiguration(preferredOutputOrder: _voiceCallOutputOrder, manageAudioFocus: false),
      );
    }
    if (Platform.isIOS) AppleNativeAudioManagement.setUseManualAudio(true);
  }

  // ---------------------------------------------------------------------------
  // Call session lifecycle
  // ---------------------------------------------------------------------------

  /// Clears the Android communication device after the last call ends (N → 0).
  ///
  /// Without this, Bluetooth stays in SCO (call profile, mono/low-quality) instead
  /// of switching back to A2DP (media profile), causing degraded audio in
  /// YouTube, music players, etc. until the app is restarted.
  void clearCommunicationDevice() {
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
    unawaited(() async {
      try {
        await AppleNativeAudioManagement.audioSessionDidActivate();
        await AppleNativeAudioManagement.setIsAudioEnabled(true);
      } catch (e, st) {
        _logger.warning('didActivateAudioSession failed', e, st);
      }
    }());
  }

  /// Called by [WebtritCallkeepDelegate.didDeactivateAudioSession].
  ///
  /// Signals to WebRTC that the AVAudioSession is about to deactivate.
  /// No-op on Android.
  void didDeactivateAudioSession() {
    if (!Platform.isIOS) return;
    _logger.fine('didDeactivateAudioSession');
    unawaited(() async {
      try {
        await AppleNativeAudioManagement.setIsAudioEnabled(false);
        await AppleNativeAudioManagement.audioSessionDidDeactivate();
      } catch (e, st) {
        _logger.warning('didDeactivateAudioSession failed', e, st);
      }
    }());
  }

  // ---------------------------------------------------------------------------
  // Device selection
  // ---------------------------------------------------------------------------

  /// Routes audio to [device] for the given [callId].
  ///
  /// Android: calls both [Helper.setSpeakerphoneOn] (AudioSwitch/AOSP) and
  /// [WebtritCallkeep.setAudioDevice] (Telecom/MIUI) with the actual device ID
  /// for cross-OEM compatibility.
  /// iOS: uses [Helper.setSpeakerphoneOn] and [Helper.selectAudioInput].
  Future<void> setDevice(String callId, CallAudioDevice device) async {
    _logger.info('setDevice: ${device.type} (id=${device.id}) for call $callId');
    if (Platform.isAndroid) {
      await Helper.setSpeakerphoneOn(device.type == CallAudioDeviceType.speaker);
      await _callkeep.setAudioDevice(callId, device.toCallkeep());
    } else if (Platform.isIOS) {
      if (device.type == CallAudioDeviceType.speaker) {
        await setSpeaker(enabled: true);
      } else {
        await setSpeaker(enabled: false);
        final deviceId = device.id;
        if (deviceId != null) await Helper.selectAudioInput(deviceId);
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Speaker helpers
  // ---------------------------------------------------------------------------

  /// Resets speaker state on the WebRTC layer (AudioSwitch / AVAudioSession).
  ///
  /// Android: used for global resets at call start/end when no Telecom connection exists.
  /// For routing during a live call use [setDevice] (user-triggered) or the
  /// video helpers [onVideoEnabled] / [onVideoDisabled] — they supply the actual
  /// device ID required by Telecom on Android.
  ///
  /// iOS: also called by [setDevice] during a live call — iOS has no Telecom layer,
  /// so [Helper.setSpeakerphoneOn] is the only routing API needed.
  Future<void> setSpeaker({required bool enabled}) async {
    await Helper.setSpeakerphoneOn(enabled);
  }

  // ---------------------------------------------------------------------------
  // Video-triggered audio routing
  // ---------------------------------------------------------------------------

  /// Called when video is enabled (camera turned on during a call).
  ///
  /// Must be called after [getUserMedia] completes — AudioSwitch (AudioSwitchManager)
  /// calls activate() inside getUserAudio(), so any routing request before that is a no-op.
  ///
  /// Android: Telecom (uid 1000) holds the active audio route and overrides AudioSwitch
  /// when both compete. Both APIs must be called:
  /// - [Helper.setSpeakerphoneOn] updates AudioSwitch state.
  /// - [WebtritCallkeep.setAudioDevice] updates the Telecom route so it stops overriding.
  /// [speakerDevice] is the speaker entry from [CallState.availableAudioDevices];
  /// when null the Telecom call is skipped (AudioSwitch only).
  ///
  /// iOS: [setUseManualAudio] is enabled so WebRTC does not auto-switch the session mode.
  /// The mode must be set explicitly to VideoChat before enabling speaker.
  Future<void> onVideoEnabled(String callId, {CallAudioDevice? speakerDevice}) async {
    _logger.info('onVideoEnabled: $callId');
    if (Platform.isAndroid) {
      await Helper.setSpeakerphoneOn(true);
      if (speakerDevice != null) await _callkeep.setAudioDevice(callId, speakerDevice.toCallkeep());
    } else if (Platform.isIOS) {
      await Helper.setAppleAudioConfiguration(AppleAudioConfiguration(appleAudioMode: AppleAudioMode.videoChat));
      await Helper.setSpeakerphoneOn(true);
    }
  }

  /// Called when video is disabled (camera turned off during a call).
  ///
  /// Reverts audio routing back to voice mode. Skipped when the user has
  /// explicitly chosen speaker ([speakerActive]).
  ///
  /// Android: mirrors [onVideoEnabled] — both AudioSwitch and Telecom are updated.
  /// [earpieceDevice] is the earpiece entry from [CallState.availableAudioDevices];
  /// when null the Telecom call is skipped.
  ///
  /// iOS: resets the shared [RTCAudioSessionConfiguration] singleton from
  /// VideoChat → VoiceChat before calling [Helper.setSpeakerphoneOn(false)].
  /// Without this reset, [setSpeakerphoneOn(false)] re-applies VideoChat mode
  /// and keeps audio on speaker regardless of port override.
  Future<void> onVideoDisabled(String callId, {required bool speakerActive, CallAudioDevice? earpieceDevice}) async {
    _logger.info('onVideoDisabled: $callId speakerActive=$speakerActive');
    if (speakerActive) return;
    if (Platform.isIOS) {
      await Helper.setAppleAudioConfiguration(AppleAudioConfiguration(appleAudioMode: AppleAudioMode.voiceChat));
      await Helper.setSpeakerphoneOn(false);
      return;
    }
    await Helper.setSpeakerphoneOn(false);
    if (earpieceDevice != null) {
      await _callkeep.setAudioDevice(callId, earpieceDevice.toCallkeep());
    } else {
      _logger.warning(
        'onVideoDisabled: earpiece device not available — Telecom route not updated, audio may stay on speaker',
      );
    }
  }
}
