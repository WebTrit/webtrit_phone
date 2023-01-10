import 'package:web_socket_channel/web_socket_channel.dart';

/// Creates a platform-specific WebSocketChannel for the provided [socket].
WebSocketChannel createWebSocketChannel(dynamic socket) {
  throw UnsupportedError('No implementation of the api provided');
}
