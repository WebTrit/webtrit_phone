import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/models/models.dart';

extension IncomingCallTypeMapper on IncomingCallType {
  CallkeepIncomingType toCalkeep() {
    switch (this) {
      case IncomingCallType.pushNotification:
        return CallkeepIncomingType.pushNotification;
      case IncomingCallType.socket:
        return CallkeepIncomingType.socket;
    }
  }
}
