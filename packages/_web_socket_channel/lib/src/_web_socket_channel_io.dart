import 'dart:io' as io;

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<io.WebSocket> connectWebSocket(
  String url, {
  Iterable<String>? protocols,
  Duration? connectionTimeout,
  Duration? pingInterval,
  List<(List<int> bytes, String? password)> certs = const [],
}) async {
  io.SecurityContext? securityContext;

  if (certs.isNotEmpty) {
    securityContext = io.SecurityContext();
    for (final cert in certs) {
      securityContext.setTrustedCertificatesBytes(cert.$1, password: cert.$2);
    }
  }

  final customHttpClient = io.HttpClient(context: securityContext);
  customHttpClient.connectionTimeout = connectionTimeout;

  final webSocket = await io.WebSocket.connect(
    url,
    protocols: protocols,
    customClient: customHttpClient,
  );
  webSocket.pingInterval = pingInterval;

  return webSocket;
}

/// Creates a [IOWebSocketChannel] for the provided [socket].
WebSocketChannel createWebSocketChannel(io.WebSocket socket) {
  return IOWebSocketChannel(socket);
}
