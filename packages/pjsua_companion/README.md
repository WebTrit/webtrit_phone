# pjsua_companion

HTTP server that wraps the `pjsua` CLI tool to automate SIP calls during integration tests.
Integration tests use `PjsuaCompanionClient` (Dart HTTP client) to drive the server.

## Prerequisites

Install `pjsua` on the machine that will run the server:

```bash
# macOS
brew install pjsip

# Ubuntu / Debian
sudo apt-get install pjsip-apps
```

Verify the binary is on `PATH`:

```bash
pjsua --version
```

## Starting the server

From the repo root:

```bash
dart run packages/pjsua_companion/bin/server.dart [port]
```

Default port is **7788**. Override via the first positional argument:

```bash
dart run packages/pjsua_companion/bin/server.dart 9000
```

The `patrol_e2e_run_local_android.sh` script starts the server automatically in the background before running tests.

## HTTP API

All endpoints use `GET`. Responses are plain text. A `200` status means success; any other status carries an error message in the body.

### `GET /health`

Liveness check. Returns `ok`.

---

### `GET /call`

Spawn a `pjsua` process that registers and immediately places an outgoing call.

| Query param   | Required | Description |
|---------------|----------|-------------|
| `sip_server`  | yes | SIP registrar / proxy host |
| `sip_username`| yes | SIP account username |
| `sip_password`| yes | SIP account password |
| `calle`       | yes | Callee username (target URI becomes `sip:<calle>@<sip_server>`) |
| `duration`    | no  | Max call duration in seconds (default `60`) |

Returns the PID of the spawned process. The process exits automatically after `duration` seconds or when the call ends.

```
GET /call?sip_server=sip.example.com&sip_username=alice&sip_password=secret&calle=bob&duration=30
→ 42137
```

---

### `GET /register_autoanswer`

Spawn a `pjsua` process that registers and auto-answers any incoming call (`--auto-answer=200`).

| Query param   | Required | Description |
|---------------|----------|-------------|
| `sip_server`  | yes | SIP registrar / proxy host |
| `sip_username`| yes | SIP account username |
| `sip_password`| yes | SIP account password |
| `duration`    | no  | Max lifetime in seconds (default `60`) |

Returns the PID. Audio is looped back (`--auto-loop`, `--null-audio`).

---

### `GET /hold?pid=<pid>`

Send a hold command to the active call in process `<pid>`.

---

### `GET /unhold?pid=<pid>`

Resume a held call in process `<pid>`.

---

### `GET /hangup?pid=<pid>`

Hang up the active call in process `<pid>` (sends `h` to `pjsua` stdin).

---

### `GET /close?pid=<pid>`

Gracefully quit the `pjsua` process `<pid>` (sends `q`, waits 5 s, then kills it).

## Dart client

`PjsuaCompanionClient` mirrors the HTTP API:

```dart
import 'package:pjsua_companion/pjsua_companion.dart';

final companion = PjsuaCompanionClient(host: 'localhost', port: 7788);

// Outgoing call — returns pid
final pid = await companion.call(
  'bob',
  sipServer: 'sip.example.com',
  sipUsername: 'alice',
  sipPassword: 'secret',
  callDuration: Duration(seconds: 30),
);

// Auto-answer incoming calls
final pid = await companion.registerAutoanswer(
  sipServer: 'sip.example.com',
  sipUsername: 'bob',
  sipPassword: 'secret',
);

// Call control
await companion.hold(pid);
await companion.unhold(pid);
await companion.hangup(pid);
await companion.close(pid);
```

## Process lifecycle

Each spawned `pjsua` process is tracked by PID. The server applies three automatic monitors:

- **Exit monitor** — removes the PID from the registry when the process exits naturally.
- **Stale monitor** — forcibly closes the process after `duration + 10` seconds.
- **State ticker** — sends an empty newline to `pjsua` stdin every second to keep the interactive session alive.

For outgoing calls, an additional stdout consumer watches for `You have 0 active call` and shuts the process down as soon as the call ends.
