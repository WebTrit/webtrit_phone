/// What an install that upgrades onto the preferences-backed cache actually
/// meets: the previously cached system info is gone, so the first read has to
/// go to the core, and a core that does not answer leaves the session with
/// nothing to work with.
library;

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../mocks/mock_app_preferences.dart';
import '../mocks/mock_system_info.dart';

class _MockSystemInfoRemoteDatasource extends Mock implements SystemInfoRemoteDatasource {}

WebtritSystemInfo _realSystemInfo() {
  final seeded = MockAppPreferences(initialData: {'system-info': const SystemInfoBuilder().build()});
  return SystemInfoLocalRepositoryPrefsImpl(seeded).getSystemInfo()!;
}

void main() {
  late MockAppPreferences appPreferences;
  late _MockSystemInfoRemoteDatasource remoteDatasource;
  late SystemInfoRepository repository;

  setUp(() {
    appPreferences = MockAppPreferences();
    remoteDatasource = _MockSystemInfoRemoteDatasource();
    repository = SystemInfoRepositoryImpl(
      localDatasource: SystemInfoLocalRepositoryPrefsImpl(appPreferences),
      remoteDatasource: remoteDatasource,
    );
  });

  group('system info after the upgrade', () {
    test('starts with nothing cached', () async {
      expect(await repository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly), isNull);
      expect(repository.getLocalSystemInfo, throwsStateError);
    });

    test('is fetched from the core on the first read and cached again', () async {
      final systemInfo = _realSystemInfo();
      when(
        () => remoteDatasource.getSystemInfo(
          overrideCoreUrl: any(named: 'overrideCoreUrl'),
          overrideTenantId: any(named: 'overrideTenantId'),
        ),
      ).thenAnswer((_) async => systemInfo);

      expect(await repository.getSystemInfo(fetchPolicy: FetchPolicy.cacheFirst), isNotNull);

      expect(appPreferences.getSystemInfo(), isNotNull);
      expect(repository.getLocalSystemInfo, returnsNormally);
    });

    test('leaves the session with nothing when the core cannot be reached', () async {
      when(
        () => remoteDatasource.getSystemInfo(
          overrideCoreUrl: any(named: 'overrideCoreUrl'),
          overrideTenantId: any(named: 'overrideTenantId'),
        ),
      ).thenThrow(Exception('no network'));

      await expectLater(repository.getSystemInfo(fetchPolicy: FetchPolicy.cacheFirst), throwsException);

      expect(appPreferences.getSystemInfo(), isNull);
      expect(repository.getLocalSystemInfo, throwsStateError);
    });
  });
}
