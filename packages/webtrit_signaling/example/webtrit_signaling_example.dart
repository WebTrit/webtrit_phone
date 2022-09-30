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

  print('Connect');
  final httpClient = HttpClient();
  httpClient.connectionTimeout = Duration(seconds: 5);
  final client = await WebtritSignalingClient.connect(url, token, false, customHttpClient: httpClient);

  print('Listen');
  client.listen(
    onStateHandshake: (stateHandshake) {
      print('>> onStateHandshake: $stateHandshake');
    },
    onEvent: (event) {
      print('>> onEvent: $event');
    },
    onError: (error, stackTrace) {
      print('>> onError: $error\n$stackTrace');
    },
    onDisconnect: (code, reason) {
      print('>> onDisconnect with code: $code and reason: $reason');
    },
  );

  print('Wait StateEvent');
  await Future.delayed(Duration(seconds: 5));

  print('Disconnect');
  await client.disconnect();
}
