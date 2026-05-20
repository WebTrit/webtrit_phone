/// Host-side HTTP server that triggers pjsua to place a SIP call.
///
/// Run this on the host machine before executing patrol tests:
///   dart patrol_test/tools/pjsua_call_server.dart
///
/// The server listens on port 7788 and exposes two endpoints:
///   GET /health          → 200 ok
///   GET /call?to=<ext>&duration=<seconds>  → spawns pjsua to call <ext>
///
/// On Android emulator the device reaches host localhost via 10.0.2.2.
/// On a real device set WEBTRIT_APP_TEST_PJSUA_SERVER_HOST to the host's LAN IP
/// and forward port 7788 (or set WEBTRIT_APP_TEST_PJSUA_SERVER_PORT accordingly).
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

const _sipServer = '217.182.47.194';
const _sipUsername = '111000124';
const _sipPassword = 'zzzxxx123';
const _serverPort = 7788;

// TODO:
// - rewrite to classes
// - save call pids to reuse themasa
// - add remote muting (mute, unmute)
// - add remote hold and resume
// - add transfer
// - add video file playback
// - add incoming RTP check to verify app actions

void main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, _serverPort);
  print('pjsua call server listening on http://0.0.0.0:$_serverPort');
  print('SIP account: sip:$_sipUsername@$_sipServer');

  await for (final request in server) {
    switch (request.uri.path) {
      case '/health':
        _respond(request, HttpStatus.ok, 'ok');
      case '/call':
        await _handleCall(request);
      default:
        _respond(request, HttpStatus.notFound, 'not found');
    }
  }
}

Future<void> _handleCall(HttpRequest request) async {
  final to = request.uri.queryParameters['to'];
  if (to == null || to.isEmpty) {
    _respond(request, HttpStatus.badRequest, 'missing "to" parameter');
    return;
  }

  final duration = int.tryParse(request.uri.queryParameters['duration'] ?? '') ?? 60;
  final callTarget = 'sip:$to@$_sipServer';
  print('Placing pjsua call → $callTarget (duration: ${duration}s)');

  _respond(request, HttpStatus.ok, 'call initiated to $callTarget');

  await _spawnPjsua(callTarget, duration);
}

void _respond(HttpRequest request, int status, String body) {
  request.response
    ..statusCode = status
    ..write(body)
    ..close();
}

Future<void> _spawnPjsua(String callTarget, int duration) async {
  try {
    final process = await Process.start('pjsua', [
      '--id=sip:$_sipUsername@$_sipServer',
      // '--registrar=sip:$_sipServer',
      '--username=$_sipUsername',
      '--password=$_sipPassword',
      '--realm=*',
      '--local-port=0',
      '--null-audio',
      '--auto-loop',
      '--duration=$duration',
      '--log-append',
      '--no-stderr',
      '--no-color',
      '--use-compact-form',
      '--publish',
      // '--mwi',
      '--log-level=1',
      callTarget,
    ], runInShell: true);

    final pid = process.pid;
    print('pjsua started with PID: $pid');

    Future<void> closeFunc() async {
      process.stdin.writeln('q');
      await process.stdin.flush();
      await Future.delayed(const Duration(seconds: 5));
      process.kill();
    }

    process.stdout.transform(Utf8Decoder(allowMalformed: true)).forEach((chunk) async {
      if (chunk.contains('BYE sip:')) {
        closeFunc();
        print('Call ended');
      }

      print('pjsua ($pid): ${chunk}');
      print('pjsua ($pid): ${chunk.length} \n-------------------------------');
    });

    // Future.delayed(Duration(seconds: 5), () async {
    //   process.stdin.writeln('H');
    //   await process.stdin.flush();
    // });

    // Quit gracefully once the call should be done; kill if it lingers.
    Future.delayed(Duration(seconds: duration + 10), closeFunc);

    final exitCode = await process.exitCode;
    print('pjsua ($pid) exited with code $exitCode');
  } catch (e) {
    print('Failed to run pjsua: $e');
  }
}
