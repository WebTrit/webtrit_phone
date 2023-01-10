import 'dart:io';

Future<WebSocket> connect(
  String url, {
  Iterable<String>? protocols,
  Duration? connectionTimeout,
  Duration? pingInterval,
}) async {
  final customHttpClient = HttpClient();
  customHttpClient.connectionTimeout = connectionTimeout;

  final webSocket = await WebSocket.connect(
    url,
    protocols: protocols,
    customClient: customHttpClient,
  );
  webSocket.pingInterval = pingInterval;

  return webSocket;
}
