import 'dart:io' as io;

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Creates a [IOWebSocketChannel] for the provided [socket].
WebSocketChannel createWebSocketChannel(io.WebSocket socket) {
  return IOWebSocketChannel(socket);
}
