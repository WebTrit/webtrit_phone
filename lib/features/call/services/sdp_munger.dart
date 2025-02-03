// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:logging/logging.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/features/call/utils/utils.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';

final _logger = Logger('SDPMunger');

/// Modifies the SDP of a [RTCSessionDescription] object.
/// Used to change outgoing SDP before sending it to the server to change some specific parameters of negotiation.
abstract class SDPMunger {
  void modify(RTCSessionDescription description);
}

/// Forces the video codec to be used in the SDP.
/// If the codec is not supported by the client, the SDP will not be changed.
class ForceVideoCodec implements SDPMunger {
  ForceVideoCodec(this.codecName);
  String codecName;

  @override
  void modify(RTCSessionDescription description) {
    WebrtcSdpUtils.forceVideoCodecIfSupports(description, codecName);
  }
}

/// Forces the audio codec to be used in the SDP.
/// If the codec is not supported by the client, the SDP will not be changed.
class ForceAudioCodec implements SDPMunger {
  ForceAudioCodec(this.codecName);
  String codecName;

  @override
  void modify(RTCSessionDescription description) {
    WebrtcSdpUtils.forceAudioCodecIfSupports(description, codecName);
  }
}

/// A chain of [SDPMunger] objects. It will apply all the mungers in the order they were added.
class SdpMungerChain implements SDPMunger {
  SdpMungerChain(this._mungers);
  final List<SDPMunger> _mungers;

  @override
  void modify(RTCSessionDescription description) => _mungers.forEach((m) => m.modify(description));
}

@Deprecated('Use ModifyWithEncodingSettings instead')

/// Forces the audio and video codecs to be used in the SDP based on user preferences.
///
/// The codec preferences are stored in the [AppPreferences].
/// If the codec is not set in the preferences, the SDP will not be changed.
class ForceCodecsByUserPrefs implements SDPMunger {
  ForceCodecsByUserPrefs(this._prefs);

  final AppPreferences _prefs;

  @override
  void modify(RTCSessionDescription description) {
    var audio = _prefs.getPreferedAudioCodec();
    if (audio != null) {
      WebrtcSdpUtils.forceAudioCodecIfSupports(description, audio.name);
    }
    var video = _prefs.getPreferedVideoCodec();
    if (video != null) {
      WebrtcSdpUtils.forceVideoCodecIfSupports(description, video.name);
    }
  }
}

class ModifyWithEncodingSettings implements SDPMunger {
  ModifyWithEncodingSettings(this._prefs);

  final AppPreferences _prefs;

  @override
  void modify(RTCSessionDescription description) {
    final settings = _prefs.getEncodingSettings();
    _logger.info('Endoding settings: $settings');

    final sdp = description.sdp;
    if (sdp == null) return;

    bool modified = false;

    final sdpMod = SDPModBuilder(sdp: sdp);
    if (settings.audioBitrate != null || settings.videoBitrate != null) {
      _logger.info('Setting bitrate audio:${settings.audioBitrate} video:${settings.videoBitrate}');
      sdpMod.setBitrate(settings.audioBitrate, settings.videoBitrate);
      modified = true;
    }

    if (settings.ptime != null || settings.maxptime != null) {
      _logger.info('Setting audio ptime:${settings.ptime} maxptime:${settings.maxptime}');
      sdpMod.setPtime(settings.ptime, settings.maxptime);
      modified = true;
    }

    if (settings.opusStereo != null || settings.opusBandwidthLimit != null) {
      _logger.info('Setting opus params, stereo:${settings.opusStereo} bandwidth:${settings.opusBandwidthLimit}');
      sdpMod.setOpusParams(settings.opusStereo, settings.opusBandwidthLimit);
      modified = true;
    }

    if (settings.audioProfiles != null) {
      final profiles = settings.audioProfiles!;
      final toRemove = profiles.where((p) => p.enabled == false).map((e) => e.option).toList();
      final toReorder = profiles.where((p) => p.enabled == true).map((e) => e.option).toList();

      _logger.info('Audio profiles to remove: $toRemove');
      _logger.info('Audio profiles to reorder: $toReorder');

      toRemove.forEach((p) => sdpMod.removeProfile(p));
      sdpMod.reorderProfiles(toReorder, RTPCodecKind.audio);
      modified = true;
    }

    if (settings.videoProfiles != null) {
      final profiles = settings.videoProfiles!;
      final toRemove = profiles.where((p) => p.enabled == false).map((e) => e.option).toList();
      final toReorder = profiles.where((p) => p.enabled == true).map((e) => e.option).toList();

      _logger.info('Video profiles to remove: $toRemove');
      _logger.info('Video profiles to reorder: $toReorder');

      toRemove.forEach((p) => sdpMod.removeProfile(p));
      sdpMod.reorderProfiles(toReorder, RTPCodecKind.video);
      modified = true;
    }

    if (modified) {
      _logger.info('Modified SDP result: ${sdpMod.data}');
      final moddedSdp = sdpMod.sdp;
      description.sdp = moddedSdp;
    }
  }
}
