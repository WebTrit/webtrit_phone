import 'package:webtrit_phone/data/data.dart';

class FCMIsolateDatabase extends AppDatabase {
  FCMIsolateDatabase(super.e);

  static FCMIsolateDatabase? _instance;

  static FCMIsolateDatabase instance(executor) {
    _instance ??= FCMIsolateDatabase(executor);

    return _instance!;
  }
}
