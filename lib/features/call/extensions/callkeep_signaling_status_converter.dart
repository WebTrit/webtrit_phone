import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/models/models.dart';

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
