import 'dart:io';

/// Raw TCP proxy that forwards bytes between a local plain-TCP listener and a
/// remote server (optionally over TLS).
///
/// Useful in tests to simulate adverse network conditions without mocks.
///
/// ### Basic usage
/// ```dart
/// final proxy = TcpProxy(host: 'example.com');
/// final port = await proxy.start();
///
/// // Connect your client to ws://127.0.0.1:$port/...
///
/// proxy.pause();   // simulate network blackhole
/// proxy.resume();  // restore connectivity
///
/// await proxy.stop();
/// ```
///
/// ### WebSocket over TLS
/// When proxying WebSocket traffic the HTTP upgrade request contains a
/// `Host` header set to `localhost:<port>`.  Pass [rewriteHostHeader] so the
/// remote server receives the correct hostname and accepts the upgrade.
///
/// ```dart
/// final proxy = TcpProxy(
///   host: 'signaling.example.com',
///   rewriteHostHeader: 'signaling.example.com',
/// );
/// ```
class TcpProxy {
  TcpProxy({required this.host, this.port = 443, this.useTls = true, this.rewriteHostHeader});

  /// Remote hostname — used as TLS SNI when [useTls] is true.
  final String host;

  /// Remote port. Defaults to 443.
  final int port;

  /// Whether to connect to the remote server over TLS. Defaults to true.
  final bool useTls;

  /// When set, the `Host` header in the first HTTP request is rewritten to
  /// this value before being forwarded.  Required for WebSocket proxying when
  /// the remote server validates the Host header.
  final String? rewriteHostHeader;

  ServerSocket? _server;
  bool _paused = false;

  bool get isPaused => _paused;

  /// Binds a local TCP listener on a random port and starts accepting
  /// connections. Returns the bound port number.
  Future<int> start() async {
    _server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
    _acceptLoop();
    return _server!.port;
  }

  /// Stops accepting new connections and closes the listener socket.
  /// Existing relayed connections finish naturally.
  Future<void> stop() async => _server?.close();

  /// Silently drops all incoming bytes in both directions — simulates a
  /// network blackhole (e.g. NAT timeout, Wi-Fi drop).
  void pause() => _paused = true;

  /// Resumes transparent byte forwarding.
  void resume() => _paused = false;

  // ---------------------------------------------------------------------------

  void _acceptLoop() async {
    await for (final clientSocket in _server!) {
      _relay(clientSocket);
    }
  }

  void _relay(Socket clientSocket) async {
    try {
      final Socket serverSocket;
      if (useTls) {
        serverSocket = await SecureSocket.connect(host, port, timeout: const Duration(seconds: 15));
      } else {
        serverSocket = await Socket.connect(host, port, timeout: const Duration(seconds: 15));
      }

      if (rewriteHostHeader != null) {
        _relayWithHostRewrite(clientSocket, serverSocket, rewriteHostHeader!);
      } else {
        _relayRaw(clientSocket, serverSocket);
      }
    } catch (_) {
      clientSocket.destroy();
    }
  }

  static const _maxHeaderBytes = 64 * 1024; // 64 KB guard against unbounded buffering

  /// Buffers the first HTTP request, rewrites the Host header, then switches
  /// to a transparent raw-byte relay for the rest of the connection.
  void _relayWithHostRewrite(Socket clientSocket, Socket serverSocket, String targetHost) {
    final headerBuf = <int>[];
    var headersDone = false;

    clientSocket.listen(
      (bytes) {
        if (headersDone) {
          if (!_paused) serverSocket.add(bytes);
          return;
        }

        if (_paused) return;

        headerBuf.addAll(bytes);

        if (headerBuf.length > _maxHeaderBytes) {
          clientSocket.destroy();
          serverSocket.destroy();
          return;
        }

        final end = _findCrlfCrlf(headerBuf);
        if (end == -1) return;

        headersDone = true;

        final headerStr = String.fromCharCodes(headerBuf.sublist(0, end + 4));
        final tail = headerBuf.sublist(end + 4);
        final rewritten = headerStr.replaceFirstMapped(
          RegExp(r'^Host: .+$', multiLine: true, caseSensitive: false),
          (_) => 'Host: $targetHost',
        );

        if (!_paused) {
          serverSocket.add(rewritten.codeUnits);
          if (tail.isNotEmpty) serverSocket.add(tail);
        }
      },
      onDone: () => serverSocket.destroy(),
      onError: (_) => serverSocket.destroy(),
      cancelOnError: true,
    );

    serverSocket.listen(
      (bytes) {
        if (!_paused) clientSocket.add(bytes);
      },
      onDone: () => clientSocket.destroy(),
      onError: (_) => clientSocket.destroy(),
      cancelOnError: true,
    );
  }

  void _relayRaw(Socket clientSocket, Socket serverSocket) {
    clientSocket.listen(
      (bytes) {
        if (!_paused) serverSocket.add(bytes);
      },
      onDone: () => serverSocket.destroy(),
      onError: (_) => serverSocket.destroy(),
      cancelOnError: true,
    );

    serverSocket.listen(
      (bytes) {
        if (!_paused) clientSocket.add(bytes);
      },
      onDone: () => clientSocket.destroy(),
      onError: (_) => clientSocket.destroy(),
      cancelOnError: true,
    );
  }

  /// Returns the index of the first `\r\n\r\n` (CR LF CR LF, bytes 13 10 13 10)
  /// sequence in [bytes], or -1 if not found.
  ///
  /// HTTP headers end with a blank line, encoded as `\r\n\r\n`. Finding this
  /// sequence marks the boundary between the HTTP request headers and the body
  /// (or, for a WebSocket upgrade, the start of the WebSocket framing).
  static int _findCrlfCrlf(List<int> bytes) {
    for (var i = 0; i < bytes.length - 3; i++) {
      if (bytes[i] == 13 && bytes[i + 1] == 10 && bytes[i + 2] == 13 && bytes[i + 3] == 10) return i;
    }
    return -1;
  }
}
