library;

import 'package:web_socket_channel/web_socket_channel.dart';

import 'src/_web_socket_channel_stub.dart'
    if (dart.library.html) 'src/_web_socket_channel_html.dart'
    if (dart.library.io) 'src/_web_socket_channel_io.dart' as platform;

Future<dynamic> connectWebSocket(
  String url, {
  Iterable<String>? protocols,
  Duration? connectionTimeout,
  Duration? pingInterval,
  List<(List<int> bytes, String? password)> certs = const [],
}) {
  return platform.connectWebSocket(
    url,
    protocols: protocols,
    connectionTimeout: connectionTimeout,
    pingInterval: pingInterval,
    certs: certs,
  );
}

WebSocketChannel createWebSocketChannel(dynamic socket) {
  return platform.createWebSocketChannel(socket);
}
