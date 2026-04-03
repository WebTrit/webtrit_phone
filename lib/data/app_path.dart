import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppPath {
  static Future<AppPath> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    final instance = AppPath._(appDocDir.path, tempDir.path);
    await Directory(instance.mediaCacheBasePath).create(recursive: true);
    return instance;
  }

  AppPath._(this._applicationDocumentsPath, this._temporaryPath);

  final String _applicationDocumentsPath;
  final String _temporaryPath;

  String get applicationDocumentsPath => _applicationDocumentsPath;

  String get temporaryPath => _temporaryPath;

  String get mediaCacheBasePath => '$temporaryPath/media_cache';
}
