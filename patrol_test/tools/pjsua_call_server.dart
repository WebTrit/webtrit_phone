import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

// TODO:
// - add transfer
// - add video file playback
// - add incoming RTP check to verify app actions

final _logger = Logger('pjsua_call_server');

final _processes = <int, Process>{};

void main(List<String> args) async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (record.loggerName == 'pjsua_call_server') {
      // ignore: avoid_print
      print('${record.time} ${record.level.name} ${record.message}');
    }
  });

  final serverPort = args.isNotEmpty ? (int.tryParse(args[0]) ?? 7788) : 7788;

  final server = await HttpServer.bind(InternetAddress.anyIPv4, serverPort);
  _logger.info('pjsua call server listening on http://0.0.0.0:$serverPort');

  await for (final request in server) {
    switch (request.uri.path) {
      case '/health':
        _respond(request, HttpStatus.ok, 'ok');
      case '/call':
        try {
          final params = request.uri.queryParameters;

          final sipServer = _validateParam(params, 'sip_server');
          final sipUsername = _validateParam(params, 'sip_username');
          final sipPassword = _validateParam(params, 'sip_password');
          final calle = _validateParam(params, 'calle');
          final duration = int.parse(_validateParam(params, 'duration', defaultValue: '60'));
          final callTarget = 'sip:$calle@$sipServer';
          _logger.info('Placing pjsua call → $callTarget (duration: ${duration}s)');

          final process = await _spawnPjsua(callTarget, sipServer, sipUsername, sipPassword, duration);
          _logger.info('pjsua started with PID: ${process.pid}');

          _processes[process.pid] = process;
          monitorExit(process.pid);
          attachStateTicker(process.pid);
          attachStdoutConsumer(process.pid);

          _respond(request, HttpStatus.ok, '${process.pid}');
        } on ArgumentError catch (e) {
          _respond(request, HttpStatus.badRequest, e.message.toString());
        } catch (e) {
          _respond(request, HttpStatus.internalServerError, 'failed to spawn pjsua: $e');
        }
      case '/hold':
        try {
          final pid = int.parse(_validateParam(request.uri.queryParameters, 'pid'));
          final process = _requireProcess(pid);
          process.stdin.writeln('H');
          await process.stdin.flush();
          _logger.info('hold sent to pjsua ($pid)');
          _respond(request, HttpStatus.ok, 'hold sent to pjsua ($pid)');
        } on ArgumentError catch (e) {
          _respond(request, HttpStatus.badRequest, e.message.toString());
        } on NotFoundException catch (e) {
          _respond(request, HttpStatus.notFound, e.message);
        } catch (e) {
          _respond(request, HttpStatus.internalServerError, 'failed to hold: $e');
        }
      case '/unhold':
        try {
          final pid = int.parse(_validateParam(request.uri.queryParameters, 'pid'));
          final process = _requireProcess(pid);
          process.stdin.writeln('v');
          await process.stdin.flush();
          _logger.info('unhold sent to pjsua ($pid)');
          _respond(request, HttpStatus.ok, 'unhold sent to pjsua ($pid)');
        } on ArgumentError catch (e) {
          _respond(request, HttpStatus.badRequest, e.message.toString());
        } on NotFoundException catch (e) {
          _respond(request, HttpStatus.notFound, e.message);
        } catch (e) {
          _respond(request, HttpStatus.internalServerError, 'failed to unhold: $e');
        }
      case '/hangup':
        try {
          final pid = int.parse(_validateParam(request.uri.queryParameters, 'pid'));
          final process = _requireProcess(pid);
          process.stdin.writeln('h');
          await process.stdin.flush();
          _logger.info('hangup sent to pjsua ($pid)');
          _respond(request, HttpStatus.ok, 'hangup sent to pjsua ($pid)');
        } on ArgumentError catch (e) {
          _respond(request, HttpStatus.badRequest, e.message.toString());
        } on NotFoundException catch (e) {
          _respond(request, HttpStatus.notFound, e.message);
        } catch (e) {
          _respond(request, HttpStatus.internalServerError, 'failed to hold: $e');
        }
        throw UnimplementedError();
      case '/transfer':
        throw UnimplementedError();
      default:
        _respond(request, HttpStatus.notFound, 'not found');
    }
  }
}

String _validateParam(Map<String, String> params, String name, {String? defaultValue}) {
  final value = params[name];
  if (value == null || value.isEmpty) {
    if (defaultValue != null) return defaultValue;
    throw ArgumentError('missing "$name" parameter');
  }
  return value;
}

Process _requireProcess(int pid) {
  final process = _processes[pid];
  if (process == null) throw NotFoundException('no active pjsua process with pid $pid');
  return process;
}

class NotFoundException implements Exception {
  NotFoundException(this.message);
  final String message;
}

void _respond(HttpRequest request, int status, String body) {
  request.response
    ..statusCode = status
    ..write(body)
    ..close();
}

Future<Process> _spawnPjsua(
  String callTarget,
  String sipServer,
  String sipUsername,
  String sipPassword,
  int duration,
) async {
  final process = await Process.start('pjsua', [
    '--id=sip:$sipUsername@$sipServer',
    '--username=$sipUsername',
    '--password=$sipPassword',
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
    _logger.info('pjsua ($pid): $chunk');
    _logger.info('pjsua ($pid): ${chunk.length} \n-------------------------------');

    if (chunk.contains('You have 0 active call')) {
      _logger.info('0 active call detected, shutting down pjsua ($pid)');
      closeProc(pid);
    }
  });
}


// State example
// 2026-05-26 11:47:32.200863 INFO pjsua (93869): >>>>
// Account list:
//   [ 0] <sip:192.168.31.123:59764>: does not register
//        Online status: Online
//   [ 1] <sip:192.168.31.123:59764;transport=TCP>: does not register
//        Online status: Online
//  *[ 2] sip:123123@123.182.47.123: does not register
//        Online status: Online
// Buddy list:
//  [ 1] <?>  sip:123123@123.182.47.123

// +=============================================================================+
// |       Call Commands:         |   Buddy, IM & Presence:  |     Account:      |
// |                              |                          |                   |
// |  m  Make new call            | +b  Add new buddy        | +a  Add new accnt.|
// |  M  Make multiple calls      | -b  Delete buddy         | -a  Delete accnt. |
// |  a  Answer call              |  i  Send IM              | !a  Modify accnt. |
// |  h  Hangup call  (ha=all)    |  s  Subscribe presence   | rr  (Re-)register |
// |  H  Hold call                |  u  Unsubscribe presence | ru  Unregister    |
// |  o  Toggle call SDP offer    |  D  Subscribe dlg event  |                   |
// |                              |  Du Unsub dlg event      |                   |
// |  v  re-inVite (release hold) |  t  Toggle online status |  >  Cycle next ac.|
// |  U  send UPDATE              |  T  Set online status    |  <  Cycle prev ac.|
// | ],[ Select next/prev call    +--------------------------+-------------------+
// |  x  Xfer call                |      Media Commands:     |  Status & Config: |
// |  X  Xfer with Replaces       |                          |                   |
// |  #  Send RFC 2833 DTMF       | cl  List ports           |  d  Dump status   |
// |  *  Send DTMF with INFO      | cc  Connect port         | dd  Dump detailed |
// | rt  Send real-time text      | cd  Disconnect port      | dc  Dump config   |
// | dq  Dump curr. call quality  |  V  Adjust audio Volume  |  f  Save config   |
// |  S  Send arbitrary REQUEST   | Cp  Codec priorities     |                   |
// +-----------------------------------------------------------------------------+
// |  q  QUIT      L  ReLoad       I  IP change     n  detect NAT type           |
// |  sleep MS     echo [0|1|txt]                                                |
// +=============================================================================+
// You have 0 active call
// >>> 
// 2026-05-26 11:47:32.201215 INFO pjsua (93869): 2281 