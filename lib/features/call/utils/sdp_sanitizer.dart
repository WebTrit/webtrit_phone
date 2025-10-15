import 'package:logging/logging.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/features/call/utils/utils.dart';

final _logger = Logger('SdpSanitizer');

abstract class SdpSanitizer {
  void apply(RTCSessionDescription description);
}

class RemoteSdpSanitizer implements SdpSanitizer {
  @override
  void apply(RTCSessionDescription description) {
    final originalSdp = description.sdp;
    if (originalSdp == null) return;

    final builder = SDPModBuilder(sdp: originalSdp);
    builder.removeG729a();
    final sanitizedSdp = builder.sdp;

    if (sanitizedSdp != originalSdp) {
      _logger.info('Sdp sanitazer applied');
      description.sdp = sanitizedSdp;
    }
  }
}
