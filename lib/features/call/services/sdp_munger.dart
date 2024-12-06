// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/features/call/utils/utils.dart';

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
