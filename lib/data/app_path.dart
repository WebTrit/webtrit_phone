import 'package:webtrit_phone/utils/utils.dart';

class AppPath {
  static late AppPath _instance;

  static Future<void> init() async {
    final appPath = await getApplicationDocumentsPath();
    _instance = AppPath._(appPath);
  }

  factory AppPath() {
    return _instance;
  }

  AppPath._(this._applicationDocumentsPath);

  String _applicationDocumentsPath;

  String get applicationDocumentsPath => _applicationDocumentsPath;
}
