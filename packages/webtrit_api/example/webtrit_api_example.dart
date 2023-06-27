import 'dart:convert';
import 'dart:io';

import 'package:webtrit_api/webtrit_api.dart';

void main(List<String> arguments) async {
  final String url;
  final String tenantId;
  final String token;
  if (arguments.length == 2) {
    url = arguments[0];
    tenantId = '';
    token = arguments[1];
  } else if (arguments.length == 3) {
    url = arguments[0];
    tenantId = arguments[1];
    token = arguments[2];
  } else {
    stderr.writeln('Incorrect arguments count, must be: <url> [<tenantId>] <token>');
    exit(1);
  }

  final client = WebtritApiClient(
    Uri.parse(url),
    tenantId,
    connectionTimeout: Duration(seconds: 5),
  );

  final info = await client.info();
  print(jsonEncode(info.toJson()));

  final accountInfo = await client.accountInfo(token);
  print(jsonEncode(accountInfo.toJson()));

  final status = await client.appStatus(token);
  print(jsonEncode(status.toJson()));

  client.close();
}
