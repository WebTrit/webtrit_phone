import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

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

final _logger = Logger('pjsua_call_server');

final _processes = <int, Process>{};

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (record.loggerName == 'pjsua_call_server') {
      // ignore: avoid_print
      print('${record.time} ${record.level.name} ${record.message}');
    }
  });

  final server = await HttpServer.bind(InternetAddress.anyIPv4, _serverPort);
  _logger.info('pjsua call server listening on http://0.0.0.0:$_serverPort');
  _logger.info('SIP account: sip:$_sipUsername@$_sipServer');

  await for (final request in server) {
    switch (request.uri.path) {
      case '/health':
        _respond(request, HttpStatus.ok, 'ok');
      case '/call':
        try {
          final to = request.uri.queryParameters['to'];
          if (to == null || to.isEmpty) {
            _respond(request, HttpStatus.badRequest, 'missing "to" parameter');
            return;
          }

          final duration = int.tryParse(request.uri.queryParameters['duration'] ?? '') ?? 60;
          final callTarget = 'sip:$to@$_sipServer';
          _logger.info('Placing pjsua call → $callTarget (duration: ${duration}s)');

          final process = await _spawnPjsua(callTarget, duration);
          _logger.info('pjsua started with PID: ${process.pid}');
          
          _processes[process.pid] = process;
          monitorExit(process.pid);
          attachStateTicker(process.pid);
          attachStdoutConsumer(process.pid);

          _respond(request, HttpStatus.ok, 'call initiated to $callTarget');
        } catch (e) {
          _respond(request, HttpStatus.internalServerError, 'failed to spawn pjsua: $e');
        }
      case '/hold':
        throw UnimplementedError();
      case '/unhold':
        throw UnimplementedError();
      case '/mute':
        throw UnimplementedError();
      case '/unmute':
        throw UnimplementedError();
      case '/transfer':
        throw UnimplementedError();
      default:
        _respond(request, HttpStatus.notFound, 'not found');
    }
  }
}

void _respond(HttpRequest request, int status, String body) {
  request.response
    ..statusCode = status
    ..write(body)
    ..close();
}

Future<Process> _spawnPjsua(String callTarget, int duration) async {
  final process = await Process.start('pjsua', [
    '--id=sip:$_sipUsername@$_sipServer',
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
  ]);

  final pid = process.pid;
  _logger.info('pjsua started with PID: $pid');

  return process;
}

Future<void> closeProc(int pid) async {
  final process = _processes[pid];
  if (process != null) {
    _logger.info('Closing pjsua ($pid)');
    process.stdin.writeln('q');
    await process.stdin.flush();
    await Future.delayed(const Duration(seconds: 5));
    process.kill();
    _processes.remove(pid);
  }
}

void monitorExit(int pid) {
  final process = _processes[pid];
  if (process != null) {
    process.exitCode.then((code) {
      _logger.info('pjsua ($pid) exited with code $code');
      _processes.remove(pid);
    });
  }
}

void attachStateTicker(int pid) {
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (_processes[pid] != null) {
      _processes[pid]!.stdin.writeln('');
      await _processes[pid]!.stdin.flush();
    } else {
      timer.cancel();
    }
  });
}

void attachStdoutConsumer(int pid) {
  final process = _processes[pid];
  if (process == null) return;
  // Listen to pjsua stdout
  process.stdout.transform(Utf8Decoder(allowMalformed: true)).forEach((chunk) async {
    if (chunk.contains('You have 0 active call')) {
      closeProc(pid);
    }

    _logger.info('pjsua ($pid): $chunk');
    _logger.info('pjsua ($pid): ${chunk.length} \n-------------------------------');
  });
}
