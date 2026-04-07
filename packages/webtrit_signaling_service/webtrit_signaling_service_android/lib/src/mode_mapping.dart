import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'messages.g.dart';

/// Converts a [SignalingServiceMode] to its Pigeon counterpart [PSignalingServiceMode].
///
/// Exhaustive -- adding a new value to [SignalingServiceMode] without updating this
/// function produces a compile-time error.
PSignalingServiceMode signalingModeToNative(SignalingServiceMode mode) {
  switch (mode) {
    case SignalingServiceMode.persistent:
      return PSignalingServiceMode.persistent;
    case SignalingServiceMode.pushBound:
      return PSignalingServiceMode.pushBound;
  }
}
