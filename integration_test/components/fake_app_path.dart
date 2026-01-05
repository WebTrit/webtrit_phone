import 'dart:io';

import 'package:webtrit_phone/data/app_path.dart';

/// A fake implementation of [AppPath] for testing purposes.
///
/// It creates real temporary directories in the system, allowing
/// SQLite databases and other file operations to function correctly
/// without polluting the main application directory.
class FakeAppPath implements AppPath {
  /// Creates an isolated temporary directory for the test.
  factory FakeAppPath() {
    final rootDir = Directory.systemTemp.createTempSync('webtrit_test_');
    return FakeAppPath._(rootDir);
  }

  FakeAppPath._(this._root);

  final Directory _root;

  @override
  String get applicationDocumentsPath => _root.path;

  @override
  String get temporaryPath => '${_root.path}/temp';

  @override
  String get mediaCacheBasePath => '$temporaryPath/media_cache';
}
