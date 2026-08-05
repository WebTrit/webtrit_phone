// Universal push tester: sends an FCM HTTP v1 message to a single device, the
// way webtrit_core does, so push handling can be exercised on a real device
// without driving the whole backend.
//
// Primary use: toggle the iOS notification SOUND. iOS only plays a sound for a
// backgrounded / locked banner when the APNs payload carries `aps.sound`; this
// tool can send WITH or WITHOUT it so you can A/B the difference.
//
// Modes (sound):
//   silent  - notification + data only, NO `apns` block -> on iOS
//             background/locked the banner is silent.
//   loud    - same PLUS apns.payload.aps.sound -> the banner chimes. (default)
//   both    - send `silent`, wait, then `loud`, to compare on one backgrounded app.
//
// The notification text and the `data` map are fully configurable, so this is
// not chat-specific: point `--data` (or PUSH_DATA in .env) at any payload to test
// any push handler (chat, sms, notifications, ...).
//
// Deps: only `http` (already in pubspec) + `openssl` (preinstalled on macOS) for
// the RS256 service-account JWT. No gcloud / jq / extra packages.
//
// Usage:
//   cp tool/.env.example tool/.env   # then fill it in (see that file)
//   dart run tool/send_push.dart                 # loud, default payload
//   dart run tool/send_push.dart silent
//   dart run tool/send_push.dart both
//   dart run tool/send_push.dart loud --title "Hi" --body "test" \
//     --data '{"chat_id":"7","chat_type":"direct","chat_message_id":"1","chat_message_sender_id":"2"}'
//   Options: --env <path> (default tool/.env)  --delay <sec> (gap in `both`, default 6)
//            --sound <name> (custom APNs sound instead of "default")

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const _scope = 'https://www.googleapis.com/auth/firebase.messaging';

Future<void> main(List<String> argv) async {
  final args = List<String>.from(argv);

  final mode = args.isNotEmpty && !args.first.startsWith('-') ? args.removeAt(0) : 'loud';
  if (!const ['silent', 'loud', 'both'].contains(mode)) {
    stderr.writeln(
      'Usage: dart run tool/send_push.dart [silent|loud|both] '
      '[--env <path>] [--delay <sec>] [--title <t>] [--body <b>] [--data <json>] [--sound <name>]',
    );
    exit(64);
  }

  final envPath = _optValue(args, '--env') ?? _defaultEnvPath();
  final delaySec = int.tryParse(_optValue(args, '--delay') ?? '') ?? 6;
  final soundName = _optValue(args, '--sound') ?? 'default';

  final env = _loadEnv(envPath);
  final projectId = _require(env, 'FCM_PROJECT_ID');
  final saPath = _resolvePath(_require(env, 'SERVICE_ACCOUNT_JSON'), envPath);
  final token = _require(env, 'DEVICE_FCM_TOKEN');

  final title = _optValue(args, '--title') ?? env['PUSH_TITLE'] ?? 'Test push';
  final baseBody = _optValue(args, '--body') ?? env['PUSH_BODY'] ?? 'hello';
  final data = _resolveData(_optValue(args, '--data') ?? env['PUSH_DATA'], env);

  final sa = _readServiceAccount(saPath);
  stdout.writeln('Project: $projectId   sender: ${sa.clientEmail}');
  stdout.writeln('Target token: ${token.substring(0, token.length.clamp(0, 16))}...');
  stdout.writeln('Data: ${jsonEncode(data)}');

  final accessToken = await _accessToken(sa);

  Future<void> send(bool loud) async {
    final tag = loud ? 'LOUD (apns.aps.sound=$soundName)' : 'SILENT (no apns block)';
    stdout.writeln('\n--> sending $tag');
    await _sendFcm(
      projectId: projectId,
      accessToken: accessToken,
      token: token,
      title: title,
      body: '$baseBody [${loud ? 'loud' : 'silent'}]',
      data: data,
      sound: loud ? soundName : null,
    );
  }

  switch (mode) {
    case 'silent':
      await send(false);
      break;
    case 'loud':
      await send(true);
      break;
    case 'both':
      stdout.writeln('\nBackground the app (or lock the screen) NOW. Sending in 3s...');
      await Future<void>.delayed(const Duration(seconds: 3));
      await send(false);
      stdout.writeln('\nWaiting ${delaySec}s before the loud one...');
      await Future<void>.delayed(Duration(seconds: delaySec));
      await send(true);
      break;
  }
  stdout.writeln('\nDone.');
}

/// Resolves the `data` map: explicit JSON (--data / PUSH_DATA) wins; otherwise a
/// chat-shaped default built from CHAT_* env vars (handy for the common case).
Map<String, String> _resolveData(String? rawJson, Map<String, String> env) {
  if (rawJson != null && rawJson.trim().isNotEmpty) {
    final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    return decoded.map((k, v) => MapEntry(k, '$v'));
  }
  return {
    'chat_id': env['CHAT_ID'] ?? '7',
    'chat_type': env['CHAT_TYPE'] ?? 'direct',
    'chat_message_id': env['CHAT_MESSAGE_ID'] ?? '999',
    'chat_message_sender_id': env['CHAT_SENDER_ID'] ?? '1152127',
  };
}

// ---- FCM v1 send -----------------------------------------------------------

Future<void> _sendFcm({
  required String projectId,
  required String accessToken,
  required String token,
  required String title,
  required String body,
  required Map<String, String> data,
  required String? sound,
}) async {
  final message = <String, dynamic>{
    'token': token,
    'notification': {'title': title, 'body': body},
    'android': {'priority': 'high', 'ttl': '0s'},
    'data': data,
  };
  if (sound != null) {
    message['apns'] = {
      'headers': {'apns-priority': '10', 'apns-push-type': 'alert'},
      'payload': {
        'aps': {'sound': sound},
      },
    };
  }

  final uri = Uri.parse('https://fcm.googleapis.com/v1/projects/$projectId/messages:send');
  final resp = await http.post(
    uri,
    headers: {'Authorization': 'Bearer $accessToken', 'Content-Type': 'application/json'},
    body: jsonEncode({'message': message}),
  );

  if (resp.statusCode == 200) {
    final name = (jsonDecode(resp.body) as Map<String, dynamic>)['name'];
    stdout.writeln('    ok: $name');
  } else {
    stderr.writeln('    FAILED ${resp.statusCode}: ${resp.body}');
    // Common: 404 UNREGISTERED (stale token), 403 SenderId mismatch (wrong
    // project), 400 third_party_auth_error (APNs key missing in Firebase for
    // this bundle id). See tool/.env.example notes.
    exit(1);
  }
}

// ---- Service-account OAuth (JWT bearer, RS256 via openssl) ------------------

class _ServiceAccount {
  _ServiceAccount(this.clientEmail, this.privateKeyPem, this.tokenUri);
  final String clientEmail;
  final String privateKeyPem;
  final String tokenUri;
}

_ServiceAccount _readServiceAccount(String path) {
  final f = File(path);
  if (!f.existsSync()) {
    stderr.writeln('SERVICE_ACCOUNT_JSON not found: $path');
    exit(66);
  }
  final j = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
  final email = j['client_email'] as String?;
  final key = j['private_key'] as String?;
  if (email == null || key == null) {
    stderr.writeln('SERVICE_ACCOUNT_JSON missing client_email / private_key: $path');
    exit(66);
  }
  return _ServiceAccount(email, key, (j['token_uri'] as String?) ?? 'https://oauth2.googleapis.com/token');
}

Future<String> _accessToken(_ServiceAccount sa) async {
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final header = _b64url(utf8.encode(jsonEncode({'alg': 'RS256', 'typ': 'JWT'})));
  final claims = _b64url(
    utf8.encode(
      jsonEncode({'iss': sa.clientEmail, 'scope': _scope, 'aud': sa.tokenUri, 'iat': now, 'exp': now + 3600}),
    ),
  );
  final signingInput = '$header.$claims';
  final signature = _b64url(_rs256Sign(signingInput, sa.privateKeyPem));
  final jwt = '$signingInput.$signature';

  final resp = await http.post(
    Uri.parse(sa.tokenUri),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer', 'assertion': jwt},
  );
  if (resp.statusCode != 200) {
    stderr.writeln('Token exchange failed ${resp.statusCode}: ${resp.body}');
    exit(1);
  }
  return (jsonDecode(resp.body) as Map<String, dynamic>)['access_token'] as String;
}

List<int> _rs256Sign(String input, String privateKeyPem) {
  final tmp = Directory.systemTemp.createTempSync('fcm_push_');
  try {
    final keyFile = File('${tmp.path}/key.pem')..writeAsStringSync(privateKeyPem);
    final inFile = File('${tmp.path}/in.txt')..writeAsBytesSync(utf8.encode(input));
    final r = Process.runSync(
      'openssl',
      ['dgst', '-sha256', '-sign', keyFile.path, '-binary', inFile.path],
      stdoutEncoding: null, // raw bytes
    );
    if (r.exitCode != 0) {
      stderr.writeln('openssl signing failed: ${r.stderr}');
      exit(1);
    }
    return r.stdout as List<int>;
  } finally {
    tmp.deleteSync(recursive: true);
  }
}

String _b64url(List<int> bytes) => base64Url.encode(bytes).replaceAll('=', '');

// ---- tiny .env loader ------------------------------------------------------

Map<String, String> _loadEnv(String path) {
  final f = File(path);
  if (!f.existsSync()) {
    stderr.writeln('env file not found: $path\nCreate it: cp tool/.env.example tool/.env');
    exit(66);
  }
  final out = <String, String>{};
  for (var line in f.readAsLinesSync()) {
    line = line.trim();
    if (line.isEmpty || line.startsWith('#')) continue;
    final i = line.indexOf('=');
    if (i <= 0) continue;
    var v = line.substring(i + 1).trim();
    if (v.length >= 2 && ((v.startsWith('"') && v.endsWith('"')) || (v.startsWith("'") && v.endsWith("'")))) {
      v = v.substring(1, v.length - 1);
    }
    out[line.substring(0, i).trim()] = v;
  }
  return out;
}

String _require(Map<String, String> env, String key) {
  final v = env[key];
  if (v == null || v.isEmpty) {
    stderr.writeln('Missing required env var: $key (see tool/.env.example)');
    exit(64);
  }
  return v;
}

String? _optValue(List<String> args, String name) {
  final i = args.indexOf(name);
  if (i < 0 || i + 1 >= args.length) return null;
  return args[i + 1];
}

String _defaultEnvPath() {
  final scriptDir = File.fromUri(Platform.script).parent.path;
  return '$scriptDir/.env';
}

String _resolvePath(String p, String envPath) {
  if (p.startsWith('/') || p.startsWith('~')) {
    return p.replaceFirst('~', Platform.environment['HOME'] ?? '~');
  }
  // relative paths are resolved against the .env file's directory
  return '${File(envPath).parent.path}/$p';
}
