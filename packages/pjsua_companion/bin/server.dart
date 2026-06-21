import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';

// TODO:
// - add transfer
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
    _logger.info('Received request: ${request.uri}');
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
          final playMusic = params['play_music'] == 'true';
          final playVideo = params['play_video'] == 'true';
          final callTarget = 'sip:$calle@$sipServer';
          _logger.info(
            'Placing pjsua call → $callTarget (duration: ${duration}s, playMusic: $playMusic, playVideo: $playVideo)',
          );

          final process = await _spawnPjsua(
            sipServer,
            sipUsername,
            sipPassword,
            duration,
            callTarget: callTarget,
            playMusic: playMusic,
            playVideo: playVideo,
          );
          _logger.info('pjsua started with PID: ${process.pid}');

          _processes[process.pid] = process;
          attachExitMonitor(process.pid);
          attachStaleProcessMonitor(process.pid, ttl: duration + 10);
          attachStateTicker(process.pid);
          attachStdoutConsumer(process.pid, exitOnIdle: true);

          _respond(request, HttpStatus.ok, '${process.pid}');
        } on ArgumentError catch (e) {
          _respond(request, HttpStatus.badRequest, e.message.toString());
        } catch (e) {
          _respond(request, HttpStatus.internalServerError, 'failed to spawn pjsua: $e');
        }
      case '/register_autoanswer':
        try {
          final params = request.uri.queryParameters;

          final sipServer = _validateParam(params, 'sip_server');
          final sipUsername = _validateParam(params, 'sip_username');
          final sipPassword = _validateParam(params, 'sip_password');
          final duration = int.parse(_validateParam(params, 'duration', defaultValue: '60'));
          final playMusic = params['play_music'] == 'true';
          final playVideo = params['play_video'] == 'true';
          _logger.info(
            'Registering pjsua for auto-answer (duration: ${duration}s, playMusic: $playMusic, playVideo: $playVideo)',
          );

          final process = await _spawnPjsua(
            sipServer,
            sipUsername,
            sipPassword,
            duration,
            autoAnswer: true,
            playMusic: playMusic,
            playVideo: playVideo,
          );
          _logger.info('pjsua started with PID: ${process.pid}');

          _processes[process.pid] = process;
          attachExitMonitor(process.pid);
          attachStaleProcessMonitor(process.pid, ttl: duration + 10);
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
      case '/close':
        try {
          final pid = int.parse(_validateParam(request.uri.queryParameters, 'pid'));
          _requireProcess(pid);
          await closeProc(pid);
          _logger.info('close sent to pjsua ($pid)');
          _respond(request, HttpStatus.ok, 'instance ($pid) closed');
        } on ArgumentError catch (e) {
          _respond(request, HttpStatus.badRequest, e.message.toString());
        } on NotFoundException catch (e) {
          _respond(request, HttpStatus.notFound, e.message);
        } catch (e) {
          _respond(request, HttpStatus.internalServerError, 'failed to close: $e');
        }
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
  String sipServer,
  String sipUsername,
  String sipPassword,
  int duration, {
  String? callTarget,
  bool autoAnswer = false,
  bool playMusic = false,
  bool playVideo = false,
}) async {
  final scriptDir = File(Platform.script.toFilePath()).parent.path;
  final musicFile = '$scriptDir/media/flying_bird.wav';
  final videoFile = '$scriptDir/media/vid.avi';

  final process = await Process.start('pjsua', [
    '--id=sip:$sipUsername@$sipServer',
    '--registrar=sip:$sipServer',
    '--username=$sipUsername',
    '--password=$sipPassword',
    '--realm=*',
    '--local-port=0',
    '--null-audio',
    '--auto-loop',
    if (playMusic) '--play-file=$musicFile',
    if (playMusic) '--auto-play',
    if (playVideo) '--video',
    if (playVideo) '--play-avi=$videoFile',
    if (playVideo) '--auto-play-avi',
    '--duration=$duration',
    '--log-append',
    '--no-stderr',
    '--no-color',
    '--use-compact-form',
    '--publish',
    '--log-level=1',
    if (autoAnswer) '--auto-answer=200',
    ?callTarget,
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

void attachExitMonitor(int pid) {
  final process = _processes[pid];
  if (process != null) {
    process.exitCode.then((code) {
      _logger.info('pjsua ($pid) exited with code $code');
      _processes.remove(pid);
    });
  }
}

void attachStaleProcessMonitor(int pid, {int ttl = 60}) {
  final startTime = DateTime.now();
  Timer.periodic(Duration(seconds: 10), (timer) async {
    if (_processes[pid] != null) {
      if (DateTime.now().difference(startTime).inSeconds > ttl) {
        _logger.info('pjsua ($pid) is stale, removing');
        closeProc(pid);
      }
    } else {
      timer.cancel();
    }
  });
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

void attachStdoutConsumer(int pid, {bool exitOnIdle = false}) {
  final process = _processes[pid];
  if (process == null) return;
  process.stdout.transform(Utf8Decoder(allowMalformed: true)).forEach((chunk) async {
    _logger.info('pjsua ($pid): $chunk');
    _logger.info('pjsua ($pid): ${chunk.length} \n-------------------------------');

    if (exitOnIdle && chunk.contains('You have 0 active call')) {
      _logger.info('0 active call detected, shutting down pjsua ($pid)');
      closeProc(pid);
    }
  });
}
