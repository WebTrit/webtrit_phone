import 'package:flutter/foundation.dart';

import 'package:path_provider/path_provider.dart';

class AppPath {
  static Future<AppPath> init() async {
    if (kIsWeb) {
      // TODO(web): no filesystem on web; path_provider is unimplemented there.
      // Paths stay empty - the drift WasmDatabase ignores the db path and
      // file-based logging is disabled on web (see bootstrap).
      return AppPath._('', '');
    }
    final appDocDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    return AppPath._(appDocDir.path, tempDir.path);
  }

  AppPath._(this._applicationDocumentsPath, this._temporaryPath);

  final String _applicationDocumentsPath;
  final String _temporaryPath;

  String get applicationDocumentsPath => _applicationDocumentsPath;

  String get temporaryPath => _temporaryPath;

  String get logFilePath => '$_applicationDocumentsPath/app_logs.log';

  /// Absolute path to the native (Kotlin) log buffer written by the callkeep_core process.
  ///
  /// This is the single source of truth for the native log path. Pass it to
  /// [NativeLogForwarder] on startup so Flutter can watch the file and forward
  /// new lines into the shared Flutter log and remote logging service.
  String get nativeLogFilePath => '$_applicationDocumentsPath/app_logs_native.log';

  String get mediaCacheBasePath => '$temporaryPath/media_cache';
}
