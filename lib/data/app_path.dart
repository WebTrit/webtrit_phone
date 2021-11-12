import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class AppPath {
  static late AppPath _instance;

  static Future<void> init() async {
    _instance = AppPath._(
      documentsDirectory: await getApplicationDocumentsDirectory(),
      temporaryDirectory: await getTemporaryDirectory(),
    );
  }

  factory AppPath() {
    return _instance;
  }

  const AppPath._({
    required this.documentsDirectory,
    required this.temporaryDirectory,
  });

  final Directory documentsDirectory;
  final Directory temporaryDirectory;

  String get documentsPath => documentsDirectory.path;

  String get temporaryPath => temporaryDirectory.path;

  String get databasePath => path.join(documentsPath, 'db.sqlite');

  String logRecordsPath(String name) => path.join(temporaryPath, '$name.log');
}
