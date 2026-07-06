import 'dart:async';
import 'dart:js_interop';

// This import is only used for web builds; not used in production.
import 'package:web/web.dart' as web;

import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:ssl_certificates/ssl_certificates.dart' show TrustedCertificates;

Future<web.WebSocket> connectWebSocket(
  String url, {
  Iterable<String>? protocols,
  Duration? connectionTimeout,
  Duration? pingInterval,
  TrustedCertificates certs = TrustedCertificates.empty,
}) async {
  final webSocket = protocols == null
      ? web.WebSocket(url)
      : web.WebSocket(url, protocols.map((e) => e.toJS).toList().toJS);
  if (webSocket.readyState == web.WebSocket.OPEN) return webSocket;

  final completer = Completer<web.WebSocket>();

  unawaited(
    webSocket.onOpen.first.then((_) {
      completer.complete(webSocket);
    }),
  );

  unawaited(
    webSocket.onError.first.then((_) {
      // The underlying WebSocket API does not expose any specific information
      // about the error itself.
      completer.completeError('WebSocket connection failed.');
    }),
  );

  if (connectionTimeout != null) {
    return completer.future.timeout(connectionTimeout);
  } else {
    return completer.future;
  }
}

/// Creates a [HtmlWebSocketChannel] for the provided [socket].
WebSocketChannel createWebSocketChannel(web.WebSocket socket) {
  return HtmlWebSocketChannel(socket);
}
