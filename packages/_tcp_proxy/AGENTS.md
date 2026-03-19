# _tcp_proxy

Internal test utility — raw TCP proxy with pause/resume for network condition simulation.
No Flutter dependency, no code generation. Used exclusively in tests.

## Public API

`TcpProxy` is the only public class:

```dart
final proxy = TcpProxy(
  host: 'signaling.example.com',
  port: 443,           // default
  useTls: true,        // default
  rewriteHostHeader: 'signaling.example.com',
);

final port = await proxy.start();

// Connect your client to ws://127.0.0.1:$port/...

proxy.pause();   // simulate network blackhole (drop all bytes)
proxy.resume();  // restore transparent forwarding

await proxy.stop();
```

## Architecture

```
Test client (plain TCP)           TcpProxy               Remote server (TLS)
  ws://127.0.0.1:$port    →   ServerSocket (IPv4)   →   SecureSocket (TLS SNI)
                                   ↕ relay                      ↕
                           _relayWithHostRewrite           rewrite Host header
                           or _relayRaw                    then raw bytes
```

Two relay modes selected at connect time:

| Mode | When | Behavior |
|------|------|----------|
| `_relayWithHostRewrite` | `rewriteHostHeader != null` | Buffers the first HTTP request until `\r\n\r\n`, rewrites the `Host` header, then switches to raw relay |
| `_relayRaw` | default | Transparent byte forwarding in both directions |

**pause/resume** — sets `_paused` flag; all forwarding calls check it before writing.
While paused, `_relayWithHostRewrite` also discards incoming bytes so `headerBuf` does not grow unbounded.
If `headerBuf` exceeds 64 KB (malformed request guard), both sockets are destroyed.

**TLS SNI** — `SecureSocket.connect(host, port)` uses `host` as SNI, so the remote server
receives the correct certificate even though the test client connects to `127.0.0.1`.

**Host header rewrite** — when a WebSocket client connects to `ws://127.0.0.1:PORT`, the HTTP
upgrade request contains `Host: 127.0.0.1:PORT`. Pass `rewriteHostHeader` so the remote server
receives the real hostname and accepts the upgrade.

## Constraints

- Binds listener on `InternetAddress.loopbackIPv4` (`127.0.0.1`) only — always use `127.0.0.1`
  (not `localhost`) in test URLs to avoid IPv6-first resolution issues.
- `publish_to: none` — internal package, not published to pub.dev.
- No Flutter, no code generation.

## Commands

```bash
dart analyze
dart format --line-length 120 lib/
```
