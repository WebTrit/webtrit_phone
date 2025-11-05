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
    stderr.writeln(
        'Incorrect arguments count, must be: <url> [<tenantId>] <token>');
    exit(1);
  }

  final client = WebtritApiClient(
    Uri.parse(url),
    tenantId,
    connectionTimeout: Duration(seconds: 5),
  );

  final info = await client.getSystemInfo();
  print(jsonEncode(info.toJson()));

  final userInfo = await client.getUserInfo(token);
  print(jsonEncode(userInfo.toJson()));

  final status = await client.getAppStatus(token);
  print(jsonEncode(status.toJson()));

  client.close();
}
