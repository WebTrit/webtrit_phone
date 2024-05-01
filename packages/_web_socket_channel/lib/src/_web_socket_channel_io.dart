import 'dart:io' as io;

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:ssl_certificates/ssl_certificates.dart';

Future<io.WebSocket> connectWebSocket(
  String url, {
  Iterable<String>? protocols,
  Duration? connectionTimeout,
  Duration? pingInterval,
  TrustedCertificates certs = TrustedCertificates.empty,
}) async {
  io.SecurityContext? securityContext = initializeSecurityContext(certs);

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
