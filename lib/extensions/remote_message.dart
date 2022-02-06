import 'package:firebase_messaging/firebase_messaging.dart';

extension RemoteMessageToS on RemoteMessage {
  String toS() {
    return '$RemoteMessage {\n'
        'senderId: $senderId\n'
        'category: $category\n'
        'collapseKey: $collapseKey\n'
        'contentAvailable: $contentAvailable\n'
        'data: $data\n'
        'from: $from\n'
        'messageId: $messageId\n'
        'messageType: $messageType\n'
        'mutableContent: $mutableContent\n'
        'notification: $notification\n'
        'sentTime: $sentTime\n'
        'threadId: $threadId\n'
        'ttl: $ttl\n'
        '}';
  }
}
