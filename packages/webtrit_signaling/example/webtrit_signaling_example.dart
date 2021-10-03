import 'dart:io';

import 'package:webtrit_signaling/src/commands/commands.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

void main(List<String> arguments) async {
  if (arguments.length != 2) {
    stderr.writeln('Incorrect arguments count, must be: <url> <token>');
    exit(1);
  }

  final url = arguments[0];
  final token = arguments[1];

  final client = await WebtritSignalingClient.connect(url, token);

  client.listen(
    (event) {
      print('>> event: $event');
    },
    onError: (error, stackTrace) {
      print('>> error: $error\n$stackTrace');
    },
    onDone: () {
      print('>> onDone with code: ${client.closeCode} and reason: ${client.closeReason}');
    },
  );

  print('Register');
  await client.send(RegisterCommand());

  print('Wait');
  await Future.delayed(Duration(seconds: 5));

  print('Unregister');
  await client.send(UnregisterCommand());

  print('Wait');
  await Future.delayed(Duration(seconds: 3));

  print('Close');
  await client.close();
}
