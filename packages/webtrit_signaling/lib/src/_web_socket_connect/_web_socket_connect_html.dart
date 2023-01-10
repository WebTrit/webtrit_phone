import 'dart:async';
import 'dart:html';

Future<WebSocket> connect(
  String url, {
  Iterable<String>? protocols,
  Duration? connectionTimeout,
  Duration? pingInterval,
}) async {
  final webSocket = WebSocket(url, protocols);
  if (webSocket.readyState == 1) return webSocket;

  final completer = Completer<WebSocket>();

  unawaited(
    webSocket.onOpen.first.then((_) {
      completer.complete(webSocket);
    }),
  );

  unawaited(
    webSocket.onError.first.then((event) {
      final error = event is ErrorEvent ? event.error : null;
      completer.completeError(error ?? 'unknown error');
    }),
  );

  if (connectionTimeout != null) {
    return completer.future.timeout(connectionTimeout);
  } else {
    return completer.future;
  }
}
