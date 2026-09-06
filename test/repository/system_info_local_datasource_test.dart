import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/repositories/system_info/system_info_local_datasource.dart';

import '../mocks/mock_app_preferences.dart';
import '../mocks/mock_system_info.dart';

void main() {
  group('SystemInfoLocalRepositoryPrefsImpl', () {
    test('clear removes the cache written by setSystemInfo', () async {
      final appPreferences = MockAppPreferences(initialData: {'system-info': const SystemInfoBuilder().build()});
      final datasource = SystemInfoLocalRepositoryPrefsImpl(appPreferences);

      final systemInfo = datasource.getSystemInfo();
      expect(systemInfo, isNotNull);

      await datasource.clear();
      expect(datasource.getSystemInfo(), isNull);

      await datasource.setSystemInfo(systemInfo!);
      expect(datasource.getSystemInfo(), isNotNull);

      await datasource.clear();
      expect(datasource.getSystemInfo(), isNull);
    });
  });
}
