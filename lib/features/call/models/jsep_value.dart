import 'package:flutter_webrtc/flutter_webrtc.dart';

class JsepValue {
  static JsepValue? fromMap(Map<String, dynamic>? jsep) {
    return jsep == null ? null : JsepValue(jsep);
  }

  factory JsepValue(Map<String, dynamic> jsep) {
    return JsepValue._(jsep['type'], jsep['sdp']);
  }

  JsepValue._(this.type, this.sdp);

  final String? type;
  final String? sdp;

  bool get hasAudio {
    final sdp = this.sdp;
    if (sdp == null) {
      return false;
    } else {
      return sdp.contains('m=audio') && !sdp.contains('m=audio 0');
    }
  }

  bool get hasVideo {
    final sdp = this.sdp;
    if (sdp == null) {
      return false;
    } else {
      return sdp.contains('m=video') && !sdp.contains('m=video 0');
    }
  }

  RTCSessionDescription toDescription() => RTCSessionDescription(sdp, type);
}
