import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

class _RecordingCrashKeysWriter implements CrashKeysWriter {
  final List<Map<String, Object?>> batches = [];
  final Map<String, Object> singles = {};

  @override
  void setKeys(Map<String, Object?> keys) => batches.add(keys);

  @override
  void setKey(String key, Object value) => singles[key] = value;
}

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

  late _RecordingCrashKeysWriter writer;

  setUp(() {
    writer = _RecordingCrashKeysWriter();
  });

  group('AppSessionCrashlyticsContext', () {
    late AppSessionCrashlyticsContext context;

    setUp(() {
      context = AppSessionCrashlyticsContext(crashKeysWriter: writer);
    });

    test('maps the authorization flag to authorized/unauthorized', () {
      context.logAuthorization(authorized: true);
      expect(writer.singles['authorization'], 'authorized');

      context.logAuthorization(authorized: false);
      expect(writer.singles['authorization'], 'unauthorized');
    });

    test('writes the theme mode name', () {
      context.logThemeMode(ThemeMode.dark);
      expect(writer.singles['themeMode'], 'dark');
    });

    test('writes the language tag and maps the default sentinel locale to system', () {
      context.logLocale(const Locale('uk'));
      expect(writer.singles['locale'], 'uk');

      context.logLocale(LocaleExtension.defaultNull);
      expect(writer.singles['locale'], 'system');
    });

    test('writes the session scope and resets it to unset on logout', () {
      context.logSessionScope(tenantId: 'tenant-a', coreUrl: 'https://core.example.com');
      expect(writer.singles['tenantId'], 'tenant-a');
      expect(writer.singles['coreUrl'], 'https://core.example.com');

      context.logSessionScope();
      expect(writer.singles['tenantId'], 'unset');
      expect(writer.singles['coreUrl'], 'unset');
    });
  });

  group('NetworkCrashlyticsContext', () {
    test('writes the incoming call type name', () {
      NetworkCrashlyticsContext(crashKeysWriter: writer).logIncomingCallType(IncomingCallType.socket);

      expect(writer.singles['incomingCallType'], 'socket');
    });
  });

  group('MediaSettingsCrashlyticsContext', () {
    test('writes the media settings batch with the default sentinel for an unset preset', () {
      MediaSettingsCrashlyticsContext(crashKeysWriter: writer).logMediaSettings(
        encodingPreset: null,
        encodingSettings: EncodingSettings.blank(),
        audioProcessingSettings: AudioProcessingSettings.blank(),
        videoCapturingSettings: const VideoCapturingSettings(resolution: Resolution.p720, framerate: Framerate.f30),
        iceSettings: IceSettings.blank(),
        peerConnectionSettings: PeerConnectionSettings.blank(),
      );

      final keys = writer.batches.single;
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
      MediaSettingsCrashlyticsContext(crashKeysWriter: writer).logMediaSettings(
        encodingPreset: EncodingPreset.quality,
        encodingSettings: EncodingSettings.blank(),
        audioProcessingSettings: AudioProcessingSettings.blank(),
        videoCapturingSettings: VideoCapturingSettings.blank(),
        iceSettings: IceSettings.blank(),
        peerConnectionSettings: PeerConnectionSettings.blank(),
      );

      expect(writer.batches.single['encodingPreset'], 'quality');
    });
  });

  group('AppStartupCrashlyticsContext', () {
    late _MockAppMetadataProvider metadataProvider;
    late _MockIncomingCallTypeRepository incomingCallTypeRepository;
    late _MockEncodingPresetRepository encodingPresetRepository;
    late _MockEncodingSettingsRepository encodingSettingsRepository;
    late _MockAudioProcessingSettingsRepository audioProcessingSettingsRepository;
    late _MockVideoCapturingSettingsRepository videoCapturingSettingsRepository;
    late _MockIceSettingsRepository iceSettingsRepository;
    late _MockPeerConnectionSettingsRepository peerConnectionSettingsRepository;
    late AppStartupCrashlyticsContext context;

    setUp(() {
      metadataProvider = _MockAppMetadataProvider();
      incomingCallTypeRepository = _MockIncomingCallTypeRepository();
      encodingPresetRepository = _MockEncodingPresetRepository();
      encodingSettingsRepository = _MockEncodingSettingsRepository();
      audioProcessingSettingsRepository = _MockAudioProcessingSettingsRepository();
      videoCapturingSettingsRepository = _MockVideoCapturingSettingsRepository();
      iceSettingsRepository = _MockIceSettingsRepository();
      peerConnectionSettingsRepository = _MockPeerConnectionSettingsRepository();

      context = AppStartupCrashlyticsContext(
        metadataProvider: metadataProvider,
        callkeepVersion: '1.3.0',
        incomingCallTypeRepository: incomingCallTypeRepository,
        encodingPresetRepository: encodingPresetRepository,
        encodingSettingsRepository: encodingSettingsRepository,
        audioProcessingSettingsRepository: audioProcessingSettingsRepository,
        videoCapturingSettingsRepository: videoCapturingSettingsRepository,
        iceSettingsRepository: iceSettingsRepository,
        peerConnectionSettingsRepository: peerConnectionSettingsRepository,
        crashKeysWriter: writer,
      );

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
      ).thenReturn(VideoCapturingSettings.blank());
      when(() => iceSettingsRepository.getIceSettings()).thenReturn(IceSettings.blank());
      when(
        () => peerConnectionSettingsRepository.getPeerConnectionSettings(defaultValue: any(named: 'defaultValue')),
      ).thenAnswer((invocation) => invocation.namedArguments[#defaultValue] as PeerConnectionSettings);
    });

    test('seeds the metadata labels with the callkeep version and drops the session-scoped ones', () {
      context.logStartup(defaultPeerConnectionSettings: PeerConnectionSettings.blank());

      final labels = writer.batches.first;
      expect(labels['app'], 'WebTrit');
      expect(labels['appVersion'], '1.16.0+6');
      expect(labels['callkeepVersion'], '1.3.0');
      expect(labels, isNot(contains('authorization')));
      expect(labels, isNot(contains('tenantId')));
      expect(labels, isNot(contains('coreUrl')));
    });

    test('delegates the current user settings to the feature contexts', () {
      context.logStartup(defaultPeerConnectionSettings: PeerConnectionSettings.blank());

      expect(writer.singles['incomingCallType'], 'socket');
      expect(writer.batches, hasLength(2));
      expect(writer.batches.last['encodingPreset'], 'default');
      expect(writer.batches.last['negotiationSettings'], PeerConnectionSettings.blank().negotiationSettings.toString());
    });

    test('logUserSettings re-reads the repositories, so a post-logout re-seed picks up the reset values', () {
      when(
        () => incomingCallTypeRepository.getIncomingCallType(defaultValue: any(named: 'defaultValue')),
      ).thenReturn(IncomingCallType.pushNotification);

      context.logUserSettings(defaultPeerConnectionSettings: PeerConnectionSettings.blank());

      expect(writer.singles['incomingCallType'], 'pushNotification');
      expect(writer.batches.single['encodingPreset'], 'default');
    });

    test('writes the unset sentinel for absent overrides', () {
      context.logFeatureOverrides(const FeatureOverrides());

      final keys = writer.batches.single;
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
      context.logFeatureOverrides(
        FeatureOverrides(
          isVideoCallEnabled: true,
          isVoicemailEnabled: false,
          monitorCheckInterval: const Duration(seconds: 45),
          logLevel: Level.WARNING,
        ),
      );

      final keys = writer.batches.single;
      expect(keys['feature_video_call_enabled'], true);
      expect(keys['feature_voicemail_enabled'], false);
      expect(keys['feature_monitor_check_interval_sec'], 45);
      expect(keys['feature_log_level'], 'WARNING');
    });

    test('skips a re-write when the overrides did not change by value', () {
      // Deliberately non-const: two const expressions would canonicalize to
      // the identical instance and the test would pass on identity alone.
      context.logFeatureOverrides(FeatureOverrides(isVideoCallEnabled: true)); // ignore: prefer_const_constructors
      context.logFeatureOverrides(FeatureOverrides(isVideoCallEnabled: true)); // ignore: prefer_const_constructors

      expect(writer.batches, hasLength(1));
    });

    test('writes again when the overrides change', () {
      context.logFeatureOverrides(const FeatureOverrides(isVideoCallEnabled: true));
      context.logFeatureOverrides(const FeatureOverrides());

      expect(writer.batches, hasLength(2));
      expect(writer.batches.last['feature_video_call_enabled'], 'unset');
    });
  });
}
