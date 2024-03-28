import 'dart:async';
import 'dart:html' as html;

import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<html.WebSocket> connectWebSocket(
  String url, {
  Iterable<String>? protocols,
  Duration? connectionTimeout,
  Duration? pingInterval,
  List<int>? certBytes,
  String? certPassword,
}) async {
  final webSocket = html.WebSocket(url, protocols);
  if (webSocket.readyState == 1) return webSocket;

  final completer = Completer<html.WebSocket>();

  unawaited(
    webSocket.onOpen.first.then((_) {
      completer.complete(webSocket);
    }),
  );

  unawaited(
    webSocket.onError.first.then((event) {
      final error = event is html.ErrorEvent ? event.error : null;
      completer.completeError(error ?? 'unknown error');
    }),
  );

  if (connectionTimeout != null) {
    return completer.future.timeout(connectionTimeout);
  } else {
    return completer.future;
  }
}

/// Creates a [HtmlWebSocketChannel] for the provided [socket].
WebSocketChannel createWebSocketChannel(html.WebSocket socket) {
  return HtmlWebSocketChannel(socket);
}
