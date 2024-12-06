import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart' as sdp_transform;

class WebrtcSdpUtils {
  static bool _sameCodec(dynamic codecData, String codecName) {
    return (codecData['codec'] as String).toLowerCase() == codecName.toLowerCase();
  }

  /// Specify the audio codec if it is supported by the client.
  /// by excluding other codecs from the SDP, so the client can force the server to use the specified codec.
  ///
  /// [audio] codec name, e.g. `opus`, `g722`, `ilbc`, `pcmu`, `pcma`.
  ///
  /// if the codec is not supported by the client, the SDP will not be changed.
  static forceAudioCodecIfSupports(RTCSessionDescription description, String audio) {
    var capSel = _CodecCapabilitySelector(description.sdp!);

    var acaps = capSel.getCapabilities('audio');
    if (acaps != null) {
      final supported = acaps.codecs.any((data) => _sameCodec(data, audio));
      if (supported) {
        acaps.codecs = acaps.codecs.where((data) => _sameCodec(data, audio)).toList();
        acaps.setCodecPreferences('audio', acaps.codecs);
        capSel.setCapabilities(acaps);
      }
    }

    description.sdp = capSel.sdp();
  }

  /// Specify the video codec if it is supported by the client.
  /// by excluding other codecs from the SDP, so the client can force the server to use the specified codec.
  ///
  /// [video] codec name, e.g. `av1`, `h264`, `h265`, `vp8`, `vp9`.
  ///
  /// if the codec is not supported by the client, the SDP will not be changed.
  static forceVideoCodecIfSupports(RTCSessionDescription description, String video) {
    var capSel = _CodecCapabilitySelector(description.sdp!);

    bool sameCodec(dynamic codecData, String codecName) {
      return (codecData['codec'] as String).toLowerCase() == codecName.toLowerCase();
    }

    var vcaps = capSel.getCapabilities('video');
    if (vcaps != null) {
      final supported = vcaps.codecs.any((data) => sameCodec(data, video));
      if (supported) {
        vcaps.codecs = vcaps.codecs.where((data) => sameCodec(data, video)).toList();
        vcaps.setCodecPreferences('video', vcaps.codecs);
        capSel.setCapabilities(vcaps);
      }
    }

    description.sdp = capSel.sdp();
  }
}

class _CodecCapabilitySelector {
  _CodecCapabilitySelector(String sdp) {
    _sdp = sdp;
    _session = sdp_transform.parse(_sdp);
  }
  late String _sdp;
  late Map<String, dynamic> _session;
  Map<String, dynamic> get session => _session;
  String sdp() => sdp_transform.write(_session, null);

  _CodecCapability? getCapabilities(String kind) {
    var mline = _mline(kind);
    if (mline == null) {
      return null;
    }
    var rtcpFb = mline['rtcpFb'] ?? <dynamic>[];
    var fmtp = mline['fmtp'] ?? <dynamic>[];
    var payloads = (mline['payloads'] as String).split(' ');
    var codecs = mline['rtp'] ?? <dynamic>[];
    return _CodecCapability(kind, payloads, codecs, fmtp, rtcpFb);
  }

  bool setCapabilities(_CodecCapability? caps) {
    if (caps == null) {
      return false;
    }
    var mline = _mline(caps.kind);
    if (mline == null) {
      return false;
    }
    mline['payloads'] = caps.payloads.join(' ');
    mline['rtp'] = caps.codecs;
    mline['fmtp'] = caps.fmtp;
    mline['rtcpFb'] = caps.rtcpFb;
    return true;
  }

  Map<String, dynamic>? _mline(String kind) {
    var mlist = _session['media'] as List<dynamic>;
    return mlist.firstWhere((element) => element['type'] == kind, orElse: () => null);
  }
}

class _CodecCapability {
  _CodecCapability(this.kind, this.payloads, this.codecs, this.fmtp, this.rtcpFb) {
    for (var element in codecs) {
      element['orign_payload'] = element['payload'];
    }
  }
  String kind;
  List<dynamic> rtcpFb;
  List<dynamic> fmtp;
  List<String> payloads;
  List<dynamic> codecs;
  bool setCodecPreferences(String kind, List<dynamic>? newCodecs) {
    if (newCodecs == null) {
      return false;
    }
    var newRtcpFb = <dynamic>[];
    var newFmtp = <dynamic>[];
    var newPayloads = <String>[];
    for (var element in newCodecs) {
      var orignPayload = element['orign_payload'] as int;
      var payload = element['payload'] as int;
      // change payload type
      if (payload != orignPayload) {
        newRtcpFb.addAll(rtcpFb.where((e) {
          if (e['payload'] == orignPayload) {
            e['payload'] = payload;
            return true;
          }
          return false;
        }).toList());
        newFmtp.addAll(fmtp.where((e) {
          if (e['payload'] == orignPayload) {
            e['payload'] = payload;
            return true;
          }
          return false;
        }).toList());
        if (payloads.contains('$orignPayload')) {
          newPayloads.add('$payload');
        }
      } else {
        newRtcpFb.addAll(rtcpFb.where((e) => e['payload'] == payload).toList());
        newFmtp.addAll(fmtp.where((e) => e['payload'] == payload).toList());
        newPayloads.addAll(payloads.where((e) => e == '$payload').toList());
      }
    }
    rtcpFb = newRtcpFb;
    fmtp = newFmtp;
    payloads = newPayloads;
    codecs = newCodecs;
    return true;
  }
}
