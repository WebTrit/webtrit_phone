import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:webtrit_phone/extensions/iterable.dart';

extension PhoenixSocketExt on PhoenixSocket {
  /// Get user channel if exists
  PhoenixChannel? get userChannel => channels.values.firstWhereOrNull((c) => c.topic.startsWith('chat:user:'));

  /// Get user id from connected user channel topic
  String? get userId => userChannel?.topic.split(':').last;

  /// Create channel by [chatId] and connect, if already exists returns it
  PhoenixChannel createChatChannel(int chatId) => addChannel(topic: 'chat:$chatId')..join();

  /// Get chat channel by [chatId] if exists
  PhoenixChannel? getChatChannel(int chatId) => channels.values.firstWhereOrNull((c) => c.topic == 'chat:$chatId');

  /// Disconnect and remove channel by [chatId]
  void removeChatChannel(int chatId) {
    final channel = getChatChannel(chatId);
    if (channel != null) removeChannel(channel);
  }
}
