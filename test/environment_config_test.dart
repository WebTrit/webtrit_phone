import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/environment_config.dart';

void main() {
  group('EnvRegistry', () {
    late EnvRegistry registry;

    setUp(() => registry = EnvRegistry());

    test('string: override wins; empty and missing fall back to compile-time', () {
      registry.apply({'A': 'override'});
      expect(registry.string('A', 'default'), 'override');

      registry.apply({'A': ''});
      expect(registry.string('A', 'default'), 'default');

      registry.apply({});
      expect(registry.string('A', 'default'), 'default');
    });

    test('stringOrNull: empty and missing fall back (may be null)', () {
      registry.apply({'A': ''});
      expect(registry.stringOrNull('A', null), isNull);
      expect(registry.stringOrNull('A', 'd'), 'd');

      registry.apply({'A': 'x'});
      expect(registry.stringOrNull('A', 'd'), 'x');
    });

    test('boolean: true/false honoured; malformed and empty fall back', () {
      registry.apply({'B': 'TRUE'});
      expect(registry.boolean('B', false), isTrue);

      registry.apply({'B': 'false'});
      expect(registry.boolean('B', true), isFalse);

      registry.apply({'B': 'yes'}); // malformed -> compile-time
      expect(registry.boolean('B', true), isTrue);

      registry.apply({'B': ''}); // empty -> compile-time
      expect(registry.boolean('B', true), isTrue);

      registry.apply({});
      expect(registry.boolean('B', false), isFalse);
    });

    test('integer: numeric honoured; malformed and empty fall back', () {
      registry.apply({'N': '42'});
      expect(registry.integer('N', 1), 42);

      registry.apply({'N': 'abc'});
      expect(registry.integer('N', 7), 7);

      registry.apply({'N': ''});
      expect(registry.integer('N', 7), 7);
    });

    test('has / clear', () {
      registry.apply({'A': 'x'});
      expect(registry.has('A'), isTrue);

      registry.clear();
      expect(registry.has('A'), isFalse);
    });
  });

  group('EnvironmentConfig overrides', () {
    tearDown(EnvironmentConfig.clearOverrides);

    test('APP_NAME reflects an override and falls back when empty/cleared', () {
      EnvironmentConfig.applyOverrides({EnvironmentConfig.APP_NAME__NAME: 'Custom'});
      expect(EnvironmentConfig.APP_NAME, 'Custom');

      EnvironmentConfig.applyOverrides({EnvironmentConfig.APP_NAME__NAME: ''});
      expect(EnvironmentConfig.APP_NAME, 'WebTrit');

      EnvironmentConfig.clearOverrides();
      expect(EnvironmentConfig.APP_NAME, 'WebTrit');
    });

    test('a non-positive polling-interval override falls back to the default', () {
      const name = EnvironmentConfig.USER_REPOSITORY_POLLING_INTERVAL_SECONDS__NAME;

      EnvironmentConfig.applyOverrides({name: '0'});
      expect(EnvironmentConfig.USER_REPOSITORY_POLLING_INTERVAL_SECONDS, 10);

      EnvironmentConfig.applyOverrides({name: '-5'});
      expect(EnvironmentConfig.USER_REPOSITORY_POLLING_INTERVAL_SECONDS, 10);

      EnvironmentConfig.applyOverrides({name: '30'});
      expect(EnvironmentConfig.USER_REPOSITORY_POLLING_INTERVAL_SECONDS, 30);
    });
  });
}
