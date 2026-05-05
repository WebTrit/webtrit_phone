import 'package:path_provider/path_provider.dart';

class AppPath {
  static Future<AppPath> init() async {
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

  String get nativeLogFilePath => '$_applicationDocumentsPath/app_logs_native.log';

  String get mediaCacheBasePath => '$temporaryPath/media_cache';
}
