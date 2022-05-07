import 'dart:io';

import 'package:webtrit_api/webtrit_api.dart';

void main(List<String> arguments) async {
  if (arguments.length != 2) {
    stderr.writeln('Incorrect arguments count, must be: <url> <token>');
    exit(1);
  }

  final url = arguments[0];
  final token = arguments[1];

  final client = WebtritApiClient(Uri.parse(url));

  final info = await client.accountInfo(token);
  print(info.toJson());

  final status = await client.appStatus(token);
  print(status.toJson());

  client.close();
}
