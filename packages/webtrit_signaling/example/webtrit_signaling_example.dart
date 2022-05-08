import 'dart:io';

import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

void main(List<String> arguments) async {
  if (arguments.length != 2) {
    stderr.writeln('Incorrect arguments count, must be: <url> <token>');
    exit(1);
  }

  PrintAppender.setupLogging(level: Level.ALL);

  final url = arguments[0];
  final token = arguments[1];

  final client = WebtritSignalingClient(
    url,
    onEvent: (event) {
      print('>> event: $event');
    },
    onError: (error, stackTrace) {
      print('>> error: $error\n$stackTrace');
    },
    onDisconnect: (code, reason) {
      print('>> onDone with code: $code and reason: $reason');
    },
  );

  print('Connect');
  await client.connect(token, false);

  print('Wait StateEvent');
  await Future.delayed(Duration(seconds: 5));

  print('Disconnect');
  await client.disconnect();
}
