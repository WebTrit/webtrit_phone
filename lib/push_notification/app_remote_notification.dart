import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

sealed class AppRemoteNotification {
  AppRemoteNotification(this.id, {this.title, this.body});

  String id;
  String? title;
  String? body;

  factory AppRemoteNotification.fromFCM(RemoteMessage message) {
    // TODO: add a discriminator on the backend side to avoid implicit content recognition
    final data = message.data;
    if (data.containsKey(CallDataConst.callId)) {
      return PendingCallNotification.fromFCM(message);
    }
    if (data.containsKey('chat_id')) {
      return ChatsNotification.fromFCM(message);
    }
    if (data.containsKey('sms_conversation_id')) {
      return SmsNotification.fromFCM(message);
    }
    return UnknownNotification.fromFCM(message);
  }
}

final class PendingCallNotification extends AppRemoteNotification {
  PendingCallNotification(super.id, this.call);
  final PendingCall call;

  factory PendingCallNotification.fromFCM(RemoteMessage message) {
    return PendingCallNotification(
      message.messageId!,
      // TODO: refactor callkeep PendingCall structure and CallHandle serialization to avoid mess with handleValue
      PendingCall.fromMap({...message.data, 'number': message.data[CallDataConst.handleValue]}),
    );
  }

  @override
  String toString() {
    return 'PendingCallNotification{id: $id, title: $title, body: $body, call: $call}';
  }
}

final class ChatsNotification extends AppRemoteNotification {
  ChatsNotification(super.id, this.messageId, this.chatId, {super.title, super.body});
  final int messageId;
  final int chatId;

  factory ChatsNotification.fromFCM(RemoteMessage message) {
    return ChatsNotification(
      message.messageId!,
      int.parse(message.data['chat_message_id']),
      int.parse(message.data['chat_id']),
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }

  @override
  String toString() {
    return 'ChatsNotification{id: $id, title: $title, body: $body}';
  }
}

final class SmsNotification extends AppRemoteNotification {
  SmsNotification(super.id, this.messageId, this.conversationId, {super.title, super.body});
  final int messageId;
  final int conversationId;

  factory SmsNotification.fromFCM(RemoteMessage message) {
    return SmsNotification(
      message.messageId!,
      int.parse(message.data['chat_message_id']),
      int.parse(message.data['sms_conversation_id']),
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }

  @override
  String toString() {
    return 'SmsNotification{id: $id, title: $title, body: $body}';
  }
}

final class UnknownNotification extends AppRemoteNotification {
  UnknownNotification(super.id, {super.title, super.body});

  factory UnknownNotification.fromFCM(RemoteMessage message) {
    return UnknownNotification(
      message.messageId ?? '_',
      title: message.notification?.title,
      body: message.notification?.body,
    );
  }

  @override
  String toString() {
    return 'UnknownNotification{id: $id, title: $title, body: $body}';
  }
}
