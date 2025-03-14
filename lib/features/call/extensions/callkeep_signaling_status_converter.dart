import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import '../models/signaling_client_status.dart';

extension CallkeepSignalingStatusConverter on CallkeepSignalingStatus {
  SignalingClientStatus toSignalingClientStatus() {
    switch (this) {
      case CallkeepSignalingStatus.disconnecting:
        return SignalingClientStatus.disconnecting;
      case CallkeepSignalingStatus.disconnect:
        return SignalingClientStatus.disconnect;
      case CallkeepSignalingStatus.connecting:
        return SignalingClientStatus.connecting;
      case CallkeepSignalingStatus.connect:
        return SignalingClientStatus.connect;
      case CallkeepSignalingStatus.failure:
        return SignalingClientStatus.failure;
    }
  }
}

extension SignalingClientStatusConverter on SignalingClientStatus {
  CallkeepSignalingStatus toCallkeepSignalingStatus() {
    switch (this) {
      case SignalingClientStatus.disconnecting:
        return CallkeepSignalingStatus.disconnecting;
      case SignalingClientStatus.disconnect:
        return CallkeepSignalingStatus.disconnect;
      case SignalingClientStatus.connecting:
        return CallkeepSignalingStatus.connecting;
      case SignalingClientStatus.connect:
        return CallkeepSignalingStatus.connect;
      case SignalingClientStatus.failure:
        return CallkeepSignalingStatus.failure;
    }
  }
}
