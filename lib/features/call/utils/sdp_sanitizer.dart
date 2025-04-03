// ignore_for_file: avoid_function_literals_in_foreach_calls

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
    if (originalSdp == null) {
      _logger.fine('Remote SDP is null, skipping clean');
      return;
    }

    _logger.fine('Original remote SDP: $originalSdp');

    final builder = SDPModBuilder(sdp: originalSdp)..clean();
    final cleanedSdp = builder.sdp;

    if (cleanedSdp != originalSdp) {
      _logger.info('Clean SDP: $cleanedSdp');
      description.sdp = cleanedSdp;
    } else {
      _logger.fine('Remote SDP is already clean. No changes made.');
    }
  }
}
