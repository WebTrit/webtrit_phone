import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_appearance_theme/models/models.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import '../mocks/mocks.dart';

void main() {
  group('LoggingMapper.map', () {
    late MockAppConfig mockAppConfig;

    setUp(() {
      mockAppConfig = MockAppConfig();
    });

    group('logLevel resolution', () {
      test('override takes priority over SupportedLoggingConfig', () {
        when(() => mockAppConfig.supported).thenReturn([const SupportedFeature.loggingConfig(logLevel: 'WARNING')]);
        final overrides = FeatureOverrides(logLevel: Level.FINE);

        final config = LoggingMapper.map(mockAppConfig, overrides);

        expect(config.logLevel, Level.FINE);
      });

      test('SupportedLoggingConfig is used when no override', () {
        when(() => mockAppConfig.supported).thenReturn([const SupportedFeature.loggingConfig(logLevel: 'WARNING')]);
        const overrides = FeatureOverrides();

        final config = LoggingMapper.map(mockAppConfig, overrides);

        expect(config.logLevel, Level.WARNING);
      });

      test('defaults to Level.INFO when no override and no SupportedLoggingConfig', () {
        when(() => mockAppConfig.supported).thenReturn([]);
        const overrides = FeatureOverrides();

        final config = LoggingMapper.map(mockAppConfig, overrides);

        expect(config.logLevel, Level.INFO);
      });

      test('defaults to Level.INFO when SupportedLoggingConfig has unknown logLevel string', () {
        when(
          () => mockAppConfig.supported,
        ).thenReturn([const SupportedFeature.loggingConfig(logLevel: 'UNKNOWN_LEVEL')]);
        const overrides = FeatureOverrides();

        final config = LoggingMapper.map(mockAppConfig, overrides);

        expect(config.logLevel, Level.INFO);
      });
    });

    group('remoteLoggingEnabled resolution', () {
      test('uses override value when set to true', () {
        when(() => mockAppConfig.supported).thenReturn([]);
        const overrides = FeatureOverrides(remoteLoggingEnabled: true);

        final config = LoggingMapper.map(mockAppConfig, overrides);

        expect(config.remoteLoggingEnabled, isTrue);
      });

      test('uses override value when set to false', () {
        when(() => mockAppConfig.supported).thenReturn([]);
        const overrides = FeatureOverrides(remoteLoggingEnabled: false);

        final config = LoggingMapper.map(mockAppConfig, overrides);

        expect(config.remoteLoggingEnabled, isFalse);
      });

      test('defaults to false when not set in overrides', () {
        when(() => mockAppConfig.supported).thenReturn([]);
        const overrides = FeatureOverrides();

        final config = LoggingMapper.map(mockAppConfig, overrides);

        expect(config.remoteLoggingEnabled, isFalse);
      });
    });
  });

  group('LoggingMapper.mapFromOverridesOnly', () {
    group('logLevel resolution', () {
      test('uses override logLevel when set', () {
        final overrides = FeatureOverrides(logLevel: Level.FINE);

        final config = LoggingMapper.mapFromOverridesOnly(overrides);

        expect(config.logLevel, Level.FINE);
      });

      test('defaults to Level.INFO when logLevel not set', () {
        const overrides = FeatureOverrides();

        final config = LoggingMapper.mapFromOverridesOnly(overrides);

        expect(config.logLevel, Level.INFO);
      });
    });

    group('remoteLoggingEnabled resolution', () {
      test('uses override value when set to true', () {
        const overrides = FeatureOverrides(remoteLoggingEnabled: true);

        final config = LoggingMapper.mapFromOverridesOnly(overrides);

        expect(config.remoteLoggingEnabled, isTrue);
      });

      test('defaults to false when not set', () {
        const overrides = FeatureOverrides();

        final config = LoggingMapper.mapFromOverridesOnly(overrides);

        expect(config.remoteLoggingEnabled, isFalse);
      });
    });
  });
}
