import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

enum FCMType { notification, call }

class FCMHandler {
  FCMHandler(this.message);

  final RemoteMessage message;

  FCMType getMessageType() {
    return message.notification == null && !message.contentAvailable && message.data.isNotEmpty && Platform.isAndroid
        ? FCMType.call
        : FCMType.notification;
  }

  PendingCall? getPendingCall() {
    final callId = message.data[CallDataConst.callId];
    final handle = message.data[CallDataConst.handleValue];
    final displayName = message.data[CallDataConst.displayName] ?? '';
    final hasVideo = _parseString(message.data[CallDataConst.hasVideo]);

    return PendingCall(id: callId, handle: handle, displayName: displayName, hasVideo: hasVideo);
  }

  bool _parseString(String value, {bool defaultValue = false}) {
    if (value.trim().toLowerCase() == 'true') {
      return true;
    } else if (value.trim().toLowerCase() == 'false') {
      return false;
    }
    return defaultValue;
  }
}
