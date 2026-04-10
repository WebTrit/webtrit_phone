import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';
import 'package:async/async.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

import '../mocks/mocks.dart';
import '../helpers/helpers.dart';

void main() {
  late MockAppThemes mockAppThemes;
  late MockSystemInfoRepository mockSystemInfoRepository;
  late MockRemoteConfigService mockRemoteConfigService;
  late MockRemoteConfigSnapshot mockSnapshot;
  late FeatureAccessStreamFactory factory;

  late StreamController<WebtritSystemInfo> systemInfoController;
  late StreamController<RemoteConfigSnapshot> remoteConfigController;

  setUpAll(() {
    registerFallbackValue(FetchPolicy.cacheOnly);
    registerFallbackValue(createMockSystemInfo());
  });

  setUp(() {
    mockAppThemes = MockAppThemes();
    mockSystemInfoRepository = MockSystemInfoRepository();
    mockRemoteConfigService = MockRemoteConfigService();
    mockSnapshot = MockRemoteConfigSnapshot();

    systemInfoController = StreamController<WebtritSystemInfo>.broadcast();
    remoteConfigController = StreamController<RemoteConfigSnapshot>.broadcast();

    final mockAppConfig = createMockAppConfig();
    final mockTermsResource = createMockTermsResource();

    when(() => mockAppThemes.appConfig).thenReturn(mockAppConfig);
    when(() => mockAppThemes.embeddedResources).thenReturn([mockTermsResource]);

    when(() => mockRemoteConfigService.snapshot).thenReturn(mockSnapshot);
    when(() => mockRemoteConfigService.onConfigUpdated).thenAnswer((_) => remoteConfigController.stream);
    when(() => mockSnapshot.getBool(any())).thenReturn(null);

    when(() => mockSystemInfoRepository.infoStream).thenAnswer((_) => systemInfoController.stream);

    factory = FeatureAccessStreamFactory(
      appThemes: mockAppThemes,
      systemInfoRepository: mockSystemInfoRepository,
      remoteConfigService: mockRemoteConfigService,
    );
  });

  tearDown(() {
    systemInfoController.close();
    remoteConfigController.close();
  });

  group('FeatureAccessStreamFactory', () {
    test('getInitialSnapshot fetches from cache and uses current remote snapshot', () async {
      final cachedSystemInfo = createMockSystemInfo();

      when(
        () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
      ).thenAnswer((_) async => cachedSystemInfo);

      final result = await factory.getInitialSnapshot();

      expect(result, isA<FeatureAccess>());
      verify(() => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly)).called(1);
    });

    test('create() stream emits initial snapshot first', () async {
      final cachedSystemInfo = createMockSystemInfo();

      when(
        () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
      ).thenAnswer((_) async => cachedSystemInfo);

      final stream = factory.create();
      final queue = StreamQueue(stream);

      final firstEmission = await queue.next;
      expect(firstEmission, isA<FeatureAccess>());

      await queue.cancel();
    });

    test('create() emits update when SystemInfo stream emits', () async {
      final cachedSystemInfo = createMockSystemInfo();
      final newSystemInfo = createMockSystemInfo();

      when(
        () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
      ).thenAnswer((_) async => cachedSystemInfo);

      final stream = factory.create();
      final queue = StreamQueue(stream);

      await queue.next;

      systemInfoController.add(newSystemInfo);

      final secondEmission = await queue.next;
      expect(secondEmission, isA<FeatureAccess>());

      await queue.cancel();
    });

    test('create() emits update when RemoteConfig stream emits', () async {
      final cachedSystemInfo = createMockSystemInfo();
      final newRemoteSnapshot = MockRemoteConfigSnapshot();
      when(() => newRemoteSnapshot.getBool(any())).thenReturn(true);

      when(
        () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
      ).thenAnswer((_) async => cachedSystemInfo);

      final stream = factory.create();
      final queue = StreamQueue(stream);

      await queue.next;

      remoteConfigController.add(newRemoteSnapshot);

      final secondEmission = await queue.next;
      expect(secondEmission, isA<FeatureAccess>());
      expect(secondEmission.overrides.isVideoCallEnabled, isTrue);

      await queue.cancel();
    });

    test('create() handles missing SystemInfo (null cache) gracefully', () async {
      when(
        () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
      ).thenAnswer((_) async => null);
      when(() => mockSnapshot.getBool(any())).thenReturn(true);

      final stream = factory.create();
      final queue = StreamQueue(stream);

      final result = await queue.next;

      expect(result, isA<FeatureAccess>());
      expect(result.coreSupport.supportsVoicemail, isFalse);
      expect(result.overrides.isVideoCallEnabled, isTrue);

      await queue.cancel();
    });
  });

  test('create() emits update with correct monitorCheckInterval from RemoteConfig', () async {
    final cachedSystemInfo = createMockSystemInfo();
    final newRemoteSnapshot = MockRemoteConfigSnapshot();

    when(() => newRemoteSnapshot.getString('feature_monitor_check_interval_sec')).thenReturn('30');
    when(() => newRemoteSnapshot.getBool(any())).thenReturn(null);

    when(
      () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
    ).thenAnswer((_) async => cachedSystemInfo);

    final stream = factory.create();
    final queue = StreamQueue(stream);

    await queue.next;

    remoteConfigController.add(newRemoteSnapshot);

    final secondEmission = await queue.next;

    expect(secondEmission.loggingConfig.monitorCheckInterval, const Duration(seconds: 30));
    expect(secondEmission.overrides.monitorCheckInterval, const Duration(seconds: 30));

    await queue.cancel();
  });

  test('create() propagates 0 monitorCheckInterval from RemoteConfig to disable monitoring', () async {
    final cachedSystemInfo = createMockSystemInfo();
    final newRemoteSnapshot = MockRemoteConfigSnapshot();

    when(() => newRemoteSnapshot.getString('feature_monitor_check_interval_sec')).thenReturn('0');
    when(() => newRemoteSnapshot.getBool(any())).thenReturn(null);

    when(
      () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
    ).thenAnswer((_) async => cachedSystemInfo);

    final stream = factory.create();
    final queue = StreamQueue(stream);

    await queue.next;

    remoteConfigController.add(newRemoteSnapshot);

    final secondEmission = await queue.next;

    expect(secondEmission.overrides.monitorCheckInterval, Duration.zero);
    expect(secondEmission.loggingConfig.monitorCheckInterval, Duration.zero);

    await queue.cancel();
  });

  test('create() ignores invalid monitorCheckInterval (non-numeric string) from RemoteConfig', () async {
    final cachedSystemInfo = createMockSystemInfo();
    final newRemoteSnapshot = MockRemoteConfigSnapshot();

    when(() => newRemoteSnapshot.getString('feature_monitor_check_interval_sec')).thenReturn('invalid_string');
    when(() => newRemoteSnapshot.getBool(any())).thenReturn(null);

    when(
      () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
    ).thenAnswer((_) async => cachedSystemInfo);

    final stream = factory.create();
    final queue = StreamQueue(stream);

    await queue.next;

    remoteConfigController.add(newRemoteSnapshot);

    final secondEmission = await queue.next;

    expect(secondEmission.overrides.monitorCheckInterval, isNull);
    expect(secondEmission.loggingConfig.monitorCheckInterval, const Duration(seconds: 15));

    await queue.cancel();
  });

  test('create() propagates logLevel from RemoteConfig', () async {
    final cachedSystemInfo = createMockSystemInfo();
    final newRemoteSnapshot = MockRemoteConfigSnapshot();

    when(() => newRemoteSnapshot.getString('feature_log_level')).thenReturn('WARNING');
    when(() => newRemoteSnapshot.getBool(any())).thenReturn(null);

    when(
      () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
    ).thenAnswer((_) async => cachedSystemInfo);

    final stream = factory.create();
    final queue = StreamQueue(stream);

    await queue.next;

    remoteConfigController.add(newRemoteSnapshot);

    final secondEmission = await queue.next;

    expect(secondEmission.overrides.logLevel, Level.WARNING);
    expect(secondEmission.loggingConfig.logLevel, Level.WARNING);

    await queue.cancel();
  });

  test('create() defaults logLevel to Level.INFO when not set in RemoteConfig', () async {
    final cachedSystemInfo = createMockSystemInfo();
    final newRemoteSnapshot = MockRemoteConfigSnapshot();

    when(() => newRemoteSnapshot.getBool(any())).thenReturn(null);

    when(
      () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
    ).thenAnswer((_) async => cachedSystemInfo);

    final stream = factory.create();
    final queue = StreamQueue(stream);

    await queue.next;

    remoteConfigController.add(newRemoteSnapshot);

    final secondEmission = await queue.next;

    expect(secondEmission.overrides.logLevel, isNull);
    expect(secondEmission.loggingConfig.logLevel, Level.INFO);

    await queue.cancel();
  });

  test('create() propagates remoteLoggingEnabled from RemoteConfig', () async {
    final cachedSystemInfo = createMockSystemInfo();
    final newRemoteSnapshot = MockRemoteConfigSnapshot();

    when(() => newRemoteSnapshot.getBool(any())).thenReturn(null);
    when(() => newRemoteSnapshot.getBool('firebaseRemoteLogging')).thenReturn(true);

    when(
      () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
    ).thenAnswer((_) async => cachedSystemInfo);

    final stream = factory.create();
    final queue = StreamQueue(stream);

    await queue.next;

    remoteConfigController.add(newRemoteSnapshot);

    final secondEmission = await queue.next;

    expect(secondEmission.overrides.remoteLoggingEnabled, isTrue);
    expect(secondEmission.loggingConfig.remoteLoggingEnabled, isTrue);

    await queue.cancel();
  });

  test('create() defaults remoteLoggingEnabled to false when not set in RemoteConfig', () async {
    final cachedSystemInfo = createMockSystemInfo();
    final newRemoteSnapshot = MockRemoteConfigSnapshot();

    when(() => newRemoteSnapshot.getBool(any())).thenReturn(null);

    when(
      () => mockSystemInfoRepository.getSystemInfo(fetchPolicy: FetchPolicy.cacheOnly),
    ).thenAnswer((_) async => cachedSystemInfo);

    final stream = factory.create();
    final queue = StreamQueue(stream);

    await queue.next;

    remoteConfigController.add(newRemoteSnapshot);

    final secondEmission = await queue.next;

    expect(secondEmission.overrides.remoteLoggingEnabled, isNull);
    expect(secondEmission.loggingConfig.remoteLoggingEnabled, isFalse);

    await queue.cancel();
  });
}
