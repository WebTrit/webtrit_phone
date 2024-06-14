import 'package:phoenix_socket/phoenix_socket.dart';

extension PhoenixSocketExt on PhoenixSocket {
  PhoenixChannel get userChannel => channels.values.firstWhere((c) => c.topic.startsWith('chat:user:'));
  String get userId => userChannel.topic.split(':').last;
}
