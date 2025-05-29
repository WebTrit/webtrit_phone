import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

sealed class AppRemotePush {
  AppRemotePush(this.id, {this.title, this.body});

  String id;
  String? title;
  String? body;

  factory AppRemotePush.fromFCM(RemoteMessage message) {
    // TODO: add a discriminator on the backend side to avoid implicit content recognition
    final data = message.data;
    if (data.containsKey(CallDataConst.callId)) {
      return PendingCallPush.fromFCM(message);
    }
    if (data.containsKey('chat_id')) {
      return ChatsMessagePush.fromFCM(message);
    }
    if (data.containsKey('sms_conversation_id')) {
      return SmsMessagePush.fromFCM(message);
    }
    if (data.containsKey('system_notification_id')) {
      return SystemNotificationPush.fromFCM(message);
    }
    return UnknownPush.fromFCM(message);
  }
}

final class PendingCallPush extends AppRemotePush {
  PendingCallPush(super.id, this.call);
  final PendingCall call;

  factory PendingCallPush.fromFCM(RemoteMessage message) {
    return PendingCallPush(
      message.messageId!,
      // TODO: refactor callkeep PendingCall structure and CallHandle serialization to avoid mess with handleValue
      PendingCall.fromMap({...message.data, 'number': message.data[CallDataConst.handleValue]}),
    );
  }

  @override
  String toString() {
    return 'PendingCallPush{id: $id, title: $title, body: $body, call: $call}';
  }
}

abstract class MessagePush extends AppRemotePush {
  MessagePush(super.id, this.messageId, this.conversationId, {super.title, super.body});
  final int messageId;
  final int conversationId;
}

final class ChatsMessagePush extends MessagePush {
  ChatsMessagePush(super.id, super.messageId, super.conversationId, {super.title, super.body});

  factory ChatsMessagePush.fromFCM(RemoteMessage message) {
    return ChatsMessagePush(
      message.messageId!,
      int.parse(message.data['chat_message_id']),
      int.parse(message.data['chat_id']),
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }

  @override
  String toString() {
    return 'ChatsPush{id: $id, title: $title, body: $body}';
  }
}

final class SmsMessagePush extends MessagePush {
  SmsMessagePush(super.id, super.messageId, super.conversationId, {super.title, super.body});

  factory SmsMessagePush.fromFCM(RemoteMessage message) {
    return SmsMessagePush(
      message.messageId!,
      int.parse(message.data['chat_message_id']),
      int.parse(message.data['sms_conversation_id']),
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }

  @override
  String toString() {
    return 'SmsPush{id: $id, title: $title, body: $body}';
  }
}

final class SystemNotificationPush extends AppRemotePush {
  SystemNotificationPush(super.id, this.systemNotificationId, {super.title, super.body});
  final int systemNotificationId;

  factory SystemNotificationPush.fromFCM(RemoteMessage message) {
    return SystemNotificationPush(
      message.messageId ?? '_',
      int.parse(message.data['system_notification_id']),
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }

  @override
  String toString() {
    return 'SystemNotificationPush{id: $id, title: $title, body: $body}';
  }
}

final class UnknownPush extends AppRemotePush {
  UnknownPush(super.id, {super.title, super.body});

  factory UnknownPush.fromFCM(RemoteMessage message) {
    return UnknownPush(
      message.messageId ?? '_',
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }

  @override
  String toString() {
    return 'UnknownPush{id: $id, title: $title, body: $body}';
  }
}
