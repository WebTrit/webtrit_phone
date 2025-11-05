import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:ssl_certificates/ssl_certificates.dart'
    show TrustedCertificates;

Future<dynamic> connectWebSocket(
  String url, {
  Iterable<String>? protocols,
  Duration? connectionTimeout,
  Duration? pingInterval,
  TrustedCertificates certs = TrustedCertificates.empty,
}) {
  throw UnsupportedError('No implementation of the api provided');
}

/// Creates a platform-specific WebSocketChannel for the provided [socket].
WebSocketChannel createWebSocketChannel(dynamic socket) {
  throw UnsupportedError('No implementation of the api provided');
}
