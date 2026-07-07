import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _MockAppMetadataProvider extends Mock implements AppMetadataProvider {}

class _MockIncomingCallTypeRepository extends Mock implements IncomingCallTypeRepository {}

class _MockEncodingPresetRepository extends Mock implements EncodingPresetRepository {}

class _MockEncodingSettingsRepository extends Mock implements EncodingSettingsRepository {}

class _MockAudioProcessingSettingsRepository extends Mock implements AudioProcessingSettingsRepository {}

class _MockVideoCapturingSettingsRepository extends Mock implements VideoCapturingSettingsRepository {}

class _MockIceSettingsRepository extends Mock implements IceSettingsRepository {}

class _MockPeerConnectionSettingsRepository extends Mock implements PeerConnectionSettingsRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(IncomingCallType.pushNotification);
    registerFallbackValue(PeerConnectionSettings.blank());
  });

  late _MockAppMetadataProvider metadataProvider;
  late _MockIncomingCallTypeRepository incomingCallTypeRepository;
  late _MockEncodingPresetRepository encodingPresetRepository;
  late _MockEncodingSettingsRepository encodingSettingsRepository;
  late _MockAudioProcessingSettingsRepository audioProcessingSettingsRepository;
  late _MockVideoCapturingSettingsRepository videoCapturingSettingsRepository;
  late _MockIceSettingsRepository iceSettingsRepository;
  late _MockPeerConnectionSettingsRepository peerConnectionSettingsRepository;
  late List<Map<String, Object?>> writes;
  late CrashlyticsAppContext appContext;

  setUp(() {
    metadataProvider = _MockAppMetadataProvider();
    incomingCallTypeRepository = _MockIncomingCallTypeRepository();
    encodingPresetRepository = _MockEncodingPresetRepository();
    encodingSettingsRepository = _MockEncodingSettingsRepository();
    audioProcessingSettingsRepository = _MockAudioProcessingSettingsRepository();
    videoCapturingSettingsRepository = _MockVideoCapturingSettingsRepository();
    iceSettingsRepository = _MockIceSettingsRepository();
    peerConnectionSettingsRepository = _MockPeerConnectionSettingsRepository();
    writes = [];

    appContext = CrashlyticsAppContext(
      metadataProvider: metadataProvider,
      callkeepVersion: '1.3.0',
      incomingCallTypeRepository: incomingCallTypeRepository,
      encodingPresetRepository: encodingPresetRepository,
      encodingSettingsRepository: encodingSettingsRepository,
      audioProcessingSettingsRepository: audioProcessingSettingsRepository,
      videoCapturingSettingsRepository: videoCapturingSettingsRepository,
      iceSettingsRepository: iceSettingsRepository,
      peerConnectionSettingsRepository: peerConnectionSettingsRepository,
      writeKeys: (settings) => writes.add(settings),
    );
  });

  group('logStartup', () {
    setUp(() {
      when(
        () => metadataProvider.logLabels,
      ).thenReturn({'app': 'WebTrit', 'appVersion': '1.16.0+6', 'authorization': 'authorized', 'tenantId': 'tenant-a'});
      when(
        () => incomingCallTypeRepository.getIncomingCallType(defaultValue: any(named: 'defaultValue')),
      ).thenReturn(IncomingCallType.socket);
      when(() => encodingPresetRepository.getEncodingPreset(defaultValue: any(named: 'defaultValue'))).thenReturn(null);
      when(() => encodingSettingsRepository.getEncodingSettings()).thenReturn(EncodingSettings.blank());
      when(
        () => audioProcessingSettingsRepository.getAudioProcessingSettings(),
      ).thenReturn(AudioProcessingSettings.blank());
      when(
        () => videoCapturingSettingsRepository.getVideoCapturingSettings(),
      ).thenReturn(const VideoCapturingSettings(resolution: Resolution.p720, framerate: Framerate.f30));
      when(() => iceSettingsRepository.getIceSettings()).thenReturn(IceSettings.blank());
      when(
        () => peerConnectionSettingsRepository.getPeerConnectionSettings(defaultValue: any(named: 'defaultValue')),
      ).thenAnswer((invocation) => invocation.namedArguments[#defaultValue] as PeerConnectionSettings);
    });

    test('writes metadata labels, versions and user settings in one batch', () {
      appContext.logStartup(defaultPeerConnectionSettings: PeerConnectionSettings.blank());

      expect(writes, hasLength(1));
      final keys = writes.single;
      expect(keys['app'], 'WebTrit');
      expect(keys['appVersion'], '1.16.0+6');
      expect(keys['tenantId'], 'tenant-a');
      expect(keys['callkeepVersion'], '1.3.0');
      expect(keys['incomingCallType'], 'socket');
    });

    test('drops the authorization label - AppBloc owns that key', () {
      appContext.logStartup(defaultPeerConnectionSettings: PeerConnectionSettings.blank());

      expect(writes.single, isNot(contains('authorization')));
    });

    test('writes media settings keys with the default sentinel for an unset preset', () {
      appContext.logStartup(defaultPeerConnectionSettings: PeerConnectionSettings.blank());

      final keys = writes.single;
      expect(keys['encodingPreset'], 'default');
      expect(keys['encodingSettings'], EncodingSettings.blank().toString());
      expect(keys['audioProcessingSettings'], AudioProcessingSettings.blank().toString());
      expect(
        keys['videoCapturingSettings'],
        const VideoCapturingSettings(resolution: Resolution.p720, framerate: Framerate.f30).toString(),
      );
      expect(keys['iceSettings'], IceSettings.blank().toString());
      expect(keys['negotiationSettings'], PeerConnectionSettings.blank().negotiationSettings.toString());
    });

    test('names the selected encoding preset', () {
      when(
        () => encodingPresetRepository.getEncodingPreset(defaultValue: any(named: 'defaultValue')),
      ).thenReturn(EncodingPreset.quality);

      appContext.logStartup(defaultPeerConnectionSettings: PeerConnectionSettings.blank());

      expect(writes.single['encodingPreset'], 'quality');
    });
  });

  group('logFeatureOverrides', () {
    test('writes the unset sentinel for absent overrides', () {
      appContext.logFeatureOverrides(const FeatureOverrides());

      expect(writes, hasLength(1));
      final keys = writes.single;
      expect(keys['feature_video_call_enabled'], 'unset');
      expect(keys['feature_system_notifications_enabled'], 'unset');
      expect(keys['feature_hybrid_presence_enabled'], 'unset');
      expect(keys['feature_voicemail_enabled'], 'unset');
      expect(keys['feature_call_history_enabled'], 'unset');
      expect(keys['feature_call_pull_video_strategy'], 'unset');
      expect(keys['feature_monitor_check_interval_sec'], 'unset');
      expect(keys['feature_log_level'], 'unset');
      expect(keys['firebaseRemoteLogging'], 'unset');
      expect(keys['feature_log_anonymization_enabled'], 'unset');
    });

    test('writes the override values when set', () {
      appContext.logFeatureOverrides(
        FeatureOverrides(
          isVideoCallEnabled: true,
          isVoicemailEnabled: false,
          monitorCheckInterval: const Duration(seconds: 45),
          logLevel: Level.WARNING,
        ),
      );

      final keys = writes.single;
      expect(keys['feature_video_call_enabled'], true);
      expect(keys['feature_voicemail_enabled'], false);
      expect(keys['feature_monitor_check_interval_sec'], 45);
      expect(keys['feature_log_level'], 'WARNING');
    });

    test('skips a re-write when the overrides did not change by value', () {
      appContext.logFeatureOverrides(const FeatureOverrides(isVideoCallEnabled: true));
      appContext.logFeatureOverrides(const FeatureOverrides(isVideoCallEnabled: true));

      expect(writes, hasLength(1));
    });

    test('writes again when the overrides change', () {
      appContext.logFeatureOverrides(const FeatureOverrides(isVideoCallEnabled: true));
      appContext.logFeatureOverrides(const FeatureOverrides());

      expect(writes, hasLength(2));
      expect(writes.last['feature_video_call_enabled'], 'unset');
    });
  });
}
