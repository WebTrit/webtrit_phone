# _tcp_proxy

Internal test utility - raw TCP proxy with pause/resume for network condition simulation.

> **Not published.** This package is part of the WebTrit Phone monorepo and is used
> exclusively in tests via workspace path dependency.

## Usage

```dart
import 'package:_tcp_proxy/_tcp_proxy.dart';

// Connect to a TLS server, rewriting the Host header for WebSocket upgrade.
final proxy = TcpProxy(
  host: 'signaling.example.com',
  rewriteHostHeader: 'signaling.example.com',
);

final port = await proxy.start();

// Point your WebSocket client at 127.0.0.1 (not localhost - see note below).
final client = await WebSocket.connect('ws://127.0.0.1:$port/path');

// Simulate a network blackhole (NAT timeout, Wi-Fi drop, firewall).
proxy.pause();

// Restore transparent forwarding.
proxy.resume();

await proxy.stop();
```

> **Note:** Always use `127.0.0.1` instead of `localhost` in test URLs.
> The proxy binds on IPv4 loopback only; `localhost` may resolve to IPv6 (`::1`) first
> on some systems, causing a connection failure.

## Using in app-level integration tests

The package is already in the monorepo workspace (`packages/_tcp_proxy`). To use it in
`integration_test/` at the app root:

**1. Add the dependency to the root `pubspec.yaml`** (`dev_dependencies` section):

```yaml
dev_dependencies:
  _tcp_proxy:
    path: packages/_tcp_proxy
```

**2. Run `flutter pub get`** (or `melos bootstrap`).

### How the URL injection works

The app derives the signaling WebSocket URL from the `coreUrl` stored in `SecureStorage`
via `WebtritSignalingUtils.parseCoreUrlToSignalingUrl()`:

```
https://core.example.com  ->  wss://core.example.com   (TLS WebSocket, real server)
http://127.0.0.1:PORT     ->  ws://127.0.0.1:PORT      (plain WebSocket, local proxy)
```

Writing `http://127.0.0.1:$proxyPort` as the `coreUrl` before the signaling client
connects makes the app route signaling through the proxy transparently. The proxy then
opens a TLS connection to the real server on the app's behalf:

```
App (plain ws://)  ->  TcpProxy (127.0.0.1:PORT)  ->  Real server (wss://, TLS)
```

**3. Import and use in a test:**

```dart
import 'package:_tcp_proxy/_tcp_proxy.dart';
import 'package:webtrit_phone/data/secure_storage.dart';

void main() {
  late TcpProxy proxy;
  late int proxyPort;

  setUp(() async {
    const realHost = IntegrationTestEnvironmentConfig.CORE_URL; // e.g. 'core.example.com'

    proxy = TcpProxy(
      host: realHost,
      rewriteHostHeader: realHost, // rewrites Host header in the WebSocket upgrade request
    );
    proxyPort = await proxy.start();
  });

  tearDown(() async {
    await proxy.stop();
    // Restore the real coreUrl so subsequent tests are not affected.
    final storage = SecureStorageImpl();
    await storage.writeCoreUrl('https://${IntegrationTestEnvironmentConfig.CORE_URL}');
  });

  patrolTest('should reconnect after network drop mid-call', ($) async {
    // 1. Log in via the real server so a valid session token is stored.
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);
    await loginByMethod($, defaultLoginMethod);

    // 2. Redirect signaling through the proxy before CallBloc connects.
    //    The app reads coreUrl from SecureStorage on every reconnect attempt,
    //    so writing http:// here makes the next connect go to the proxy.
    final storage = SecureStorageImpl();
    await storage.writeCoreUrl('http://127.0.0.1:$proxyPort');

    // 3. Trigger a reconnect so CallBloc picks up the new URL.
    //    (e.g. toggle airplane mode off, or wait for an automatic reconnect cycle)

    // 4. Wait until the call UI is active (signaling connected through proxy).
    await $.waitUntilVisible($(CallActiveScaffold));

    // 5. Simulate a network blackhole - drop all bytes in both directions.
    proxy.pause();

    // 6. Assert the app shows a reconnect indicator.
    await $.waitUntilVisible($(ReconnectingIndicator));

    // 7. Restore connectivity and verify recovery.
    proxy.resume();
    await $.waitUntilVisible($(CallActiveScaffold));
  });
}
```

> **Tip:** The proxy sits between the app and the server at the TCP level - below WebSocket
> framing and TLS. `pause()` silently discards all bytes in both directions without closing
> the socket, which is indistinguishable from a NAT timeout or Wi-Fi drop from the app's
> perspective.

## How it works

The proxy opens a plain-TCP listener on a random local port. For each incoming connection it
opens a TLS connection to the remote server (using the correct SNI hostname) and relays bytes
transparently in both directions.

When `rewriteHostHeader` is set, the proxy buffers the first HTTP request until the end of
headers (`\r\n\r\n`), rewrites the `Host` header to the real server hostname, and then switches
to a raw byte relay for the rest of the connection lifetime.

Calling `pause()` sets an internal flag that causes all byte forwarding to be silently
discarded - simulating a network path that is physically broken but where the TCP connection
itself has not been reset (the most realistic scenario for keepalive timeout testing).
