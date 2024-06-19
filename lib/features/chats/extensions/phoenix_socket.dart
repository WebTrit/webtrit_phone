import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:webtrit_phone/extensions/iterable.dart';

extension PhoenixSocketExt on PhoenixSocket {
  PhoenixChannel? get userChannel => channels.values.firstWhereOrNull((c) => c.topic.startsWith('chat:user:'));
  String? get userId => userChannel?.topic.split(':').last;

  PhoenixChannel? chatroomChannel(int chatId) {
    return channels.values.firstWhereOrNull((c) => c.topic == 'chat:chatroom:$chatId');
  }
}
