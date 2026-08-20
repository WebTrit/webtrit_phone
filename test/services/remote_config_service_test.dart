import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/services/services.dart';

class _MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

class _MockRemoteCacheConfigService extends Mock implements RemoteCacheConfigService {}

void main() {
  late _MockFirebaseRemoteConfig remoteConfig;
  late _MockRemoteCacheConfigService cache;

  setUpAll(() {
    registerFallbackValue(RemoteConfigSettings(fetchTimeout: Duration.zero, minimumFetchInterval: Duration.zero));
  });

  setUp(() {
    remoteConfig = _MockFirebaseRemoteConfig();
    cache = _MockRemoteCacheConfigService();
    when(() => remoteConfig.onConfigUpdated).thenAnswer((_) => const Stream.empty());
    when(remoteConfig.getAll).thenReturn(const {});
  });

  test('init does not start configuration or network refresh', () async {
    final settings = Completer<void>();
    final fetch = Completer<bool>();
    when(() => remoteConfig.setConfigSettings(any())).thenAnswer((_) => settings.future);
    when(remoteConfig.fetchAndActivate).thenAnswer((_) => fetch.future);

    final service = await CachedRemoteConfigService.init(cache, remoteConfig: remoteConfig);

    expect(service, isA<CachedRemoteConfigService>());
    verifyNever(() => remoteConfig.setConfigSettings(any()));
    verifyNever(remoteConfig.fetchAndActivate);

    final refresh = service.refresh();
    verify(() => remoteConfig.setConfigSettings(any())).called(1);
    settings.complete();
    await untilCalled(remoteConfig.fetchAndActivate);
    fetch.complete(false);
    await refresh;
    await service.dispose();
  });

  test('background refresh emits an updated snapshot', () async {
    when(() => remoteConfig.setConfigSettings(any())).thenAnswer((_) async {});
    when(remoteConfig.fetchAndActivate).thenAnswer((_) async => true);
    final service = await CachedRemoteConfigService.init(cache, remoteConfig: remoteConfig);
    final update = service.onConfigUpdated.first;
    final refresh = service.refresh();

    expect(await update, isA<RemoteConfigSnapshot>());
    await refresh;
    await service.dispose();
  });

  test('refresh retries configuration after a transient failure', () async {
    var configurationAttempts = 0;
    when(() => remoteConfig.setConfigSettings(any())).thenAnswer((_) async {
      configurationAttempts++;
      if (configurationAttempts == 1) throw StateError('transient failure');
    });
    when(remoteConfig.fetchAndActivate).thenAnswer((_) async => false);
    final service = await CachedRemoteConfigService.init(cache, remoteConfig: remoteConfig);

    await service.refresh();
    await service.refresh();

    expect(configurationAttempts, 2);
    verify(remoteConfig.fetchAndActivate).called(1);
    await service.dispose();
  });

  test('background refresh is bounded by its timeout', () async {
    final settings = Completer<void>();
    when(() => remoteConfig.setConfigSettings(any())).thenAnswer((_) => settings.future);
    when(remoteConfig.fetchAndActivate).thenAnswer((_) async => false);
    final service = await CachedRemoteConfigService.init(
      cache,
      remoteConfig: remoteConfig,
      refreshTimeout: const Duration(milliseconds: 10),
    );

    await service.refresh().timeout(const Duration(seconds: 1));

    verifyNever(remoteConfig.fetchAndActivate);
    settings.complete();
    await service.dispose();
  });
}
