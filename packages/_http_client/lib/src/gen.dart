import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';

/// Util for byte list representation of certificate.
///
/// You should set certificate name in args.
/// Certificate should be in certs folder.
///
/// Call example:
/// dart main.dart cert.pem
///
/// Exit codes:
/// 0 - success
/// 1 - error
void main(List<String> arguments) {
 var exitCode = 0;
  final parser = ArgParser();

  var args = parser.parse(arguments).arguments;

  if (args.length < 1) {
    exitCode = 1;

    throw Exception('You should set certificate name.');
  }

  var fileName = args[0];

  var certFile = File("certs/$fileName");

  if (!certFile.existsSync()) {
    exitCode = 1;

    throw Exception('File certificate ${certFile.path} not found.');
  }

  String fileNameWithoutExt = basenameWithoutExtension(certFile.path);

  var cert = certFile.readAsBytesSync();
  var res = "List<int> $fileNameWithoutExt = <int>[${cert.join(', ')}];";
  var resFile = File("res/$fileNameWithoutExt.dart");

  if (!resFile.existsSync()) {
    resFile.createSync(recursive: true);
  }

  resFile.writeAsString(res);
}