import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class AppPath {
  static late AppPath _instance;

  static Future<void> init() async {
    _instance = AppPath._(await getApplicationDocumentsDirectory());
  }

  factory AppPath() {
    return _instance;
  }

  const AppPath._(this.documentsDirectory);

  final Directory documentsDirectory;

  String get documentsPath => documentsDirectory.path;

  String get databasePath => path.join(documentsPath, 'db.sqlite');
}
