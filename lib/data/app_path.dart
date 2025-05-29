import 'package:path_provider/path_provider.dart';

class AppPath {
  static late AppPath _instance;

  static Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    _instance = AppPath._(
      appDocDir.path,
      tempDir.path,
    );
  }

  factory AppPath() => _instance;

  AppPath._(this._applicationDocumentsPath, this._temporaryPath);

  final String _applicationDocumentsPath;
  final String _temporaryPath;

  String get applicationDocumentsPath => _applicationDocumentsPath;

  String get temporaryPath => _temporaryPath;

  String get mediaCacheBasePath => '$temporaryPath/media_cache';
}
