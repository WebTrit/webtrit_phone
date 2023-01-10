import 'dart:html' as html;

import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Creates a [HtmlWebSocketChannel] for the provided [socket].
WebSocketChannel createWebSocketChannel(html.WebSocket socket) {
  return HtmlWebSocketChannel(socket);
}
