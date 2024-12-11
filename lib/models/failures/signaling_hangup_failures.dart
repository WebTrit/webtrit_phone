import 'package:webtrit_signaling/webtrit_signaling.dart';

class SignalingHangupFailure implements Exception {
  SignalingHangupFailure(this.code);

  final SignalingResponseCode code;
}
