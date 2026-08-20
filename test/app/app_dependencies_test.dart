import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/app_dependencies.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';

class _Recorded implements Disposable {
  _Recorded(this.name, this.released);

  final String name;
  final List<String> released;

  @override
  Future<void> dispose() async => released.add(name);
}

class _Failing implements Disposable {
  @override
  Future<void> dispose() async => throw StateError('release failed');
}

class _Slow implements Disposable {
  _Slow(this.gate, this.releases);

  final Completer<void> gate;
  final List<String> releases;

  @override
  Future<void> dispose() async {
    releases.add('slow');
    await gate.future;
  }
}

class _Plain {
  const _Plain();
}

/// Builds an instance with whatever the test put in it; the sealed members are
/// stand-ins, since these tests are about ownership and sharing.
AppDependencies _sealed(AppDependenciesBuilder builder) {
  return builder.build(
    featureAccess: (initial: _FakeFeatureAccess(), updates: () => const Stream<FeatureAccess>.empty()),
    themeSettings: (initial: const ThemeSettings(), updates: () => const Stream<ThemeSettings>.empty()),
    systemInfo: _FakeSystemInfoRepository(),
  );
}

class _FakeFeatureAccess extends Mock implements FeatureAccess {}

class _FakeSystemInfoRepository extends Mock implements SystemInfoRepository {}

void main() {
  group('presentation configuration', () {
    final defaultFeatureAccess = _FakeFeatureAccess();
    final defaultThemeSettings = const ThemeSettings();
    final defaults = (
      featureAccess: (initial: defaultFeatureAccess, updates: () => const Stream<FeatureAccess>.empty()),
      themeSettings: (initial: defaultThemeSettings, updates: () => const Stream<ThemeSettings>.empty()),
    );

    test('keeps bootstrap defaults when no host configures the presentation', () {
      final resolved = resolvePresentationConfig(defaults, null);

      expect(resolved.featureAccess, same(defaults.featureAccess));
      expect(resolved.themeSettings, same(defaults.themeSettings));
    });

    test('lets a host replace presentation sources from the defaults', () {
      final hostFeatureAccess = _FakeFeatureAccess();
      final hostThemeSettings = const ThemeSettings();
      var calls = 0;

      final resolved = resolvePresentationConfig(defaults, (receivedDefaults) {
        calls++;
        expect(receivedDefaults.featureAccess, same(defaults.featureAccess));
        expect(receivedDefaults.themeSettings, same(defaults.themeSettings));
        return (
          featureAccess: (initial: hostFeatureAccess, updates: () => const Stream<FeatureAccess>.empty()),
          themeSettings: (initial: hostThemeSettings, updates: () => const Stream<ThemeSettings>.empty()),
        );
      });

      expect(calls, 1);
      expect(resolved.featureAccess.initial, same(hostFeatureAccess));
      expect(resolved.themeSettings.initial, same(hostThemeSettings));
    });
  });

  group('what the tree receives', () {
    testWidgets('a shared instance reaches the tree', (tester) async {
      final builder = AppDependenciesBuilder()..share<_Plain>(const _Plain());
      _Plain? read;

      await tester.pumpWidget(
        MultiProvider(
          providers: _sealed(builder).providers,
          child: Builder(
            builder: (context) {
              read = context.read<_Plain>();
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(read, isNotNull);
    });

    test('a kept instance is not offered to the tree', () {
      final builder = AppDependenciesBuilder()..keep<_Plain>(const _Plain());

      expect(_sealed(builder).providers, isEmpty);
    });

    test('sharing hands the instance back, so it can be used where it was built', () {
      const instance = _Plain();

      expect(AppDependenciesBuilder().share<_Plain>(instance), same(instance));
      expect(AppDependenciesBuilder().keep<_Plain>(instance), same(instance));
    });

    test('rejects a second shared dependency of the same type', () {
      final builder = AppDependenciesBuilder()..share<_Plain>(const _Plain());

      expect(() => builder.share<_Plain>(const _Plain()), throwsStateError);
    });

    test('rejects taking ownership of the same instance twice', () {
      const instance = _Plain();
      final builder = AppDependenciesBuilder()..keep(instance);

      expect(() => builder.share(instance), throwsStateError);
    });

    test('rejects additions and a second build after it is sealed', () {
      final builder = AppDependenciesBuilder();
      _sealed(builder);

      expect(() => builder.keep(const _Plain()), throwsStateError);
      expect(() => _sealed(builder), throwsStateError);
    });
  });

  group('release', () {
    test('releases in reverse order of creation, kept and shared alike', () async {
      final released = <String>[];
      final builder = AppDependenciesBuilder()
        ..keep(_Recorded('first', released))
        ..share(_Recorded('second', released))
        ..keep(_Recorded('third', released));

      await _sealed(builder).dispose();

      expect(released, ['third', 'second', 'first']);
    });

    test('skips instances that hold no resources', () async {
      final builder = AppDependenciesBuilder()..share<_Plain>(const _Plain());

      await expectLater(_sealed(builder).dispose(), completes);
    });

    test('a failing release does not stop the remaining ones', () async {
      final released = <String>[];
      final builder = AppDependenciesBuilder()
        ..keep(_Recorded('first', released))
        ..keep(_Failing());

      await expectLater(_sealed(builder).dispose(), completes);

      expect(released, ['first']);
    });

    test('runs once, even when a second call arrives while the first is still releasing', () async {
      final releases = <String>[];
      final gate = Completer<void>();
      final app = _sealed(AppDependenciesBuilder()..keep(_Slow(gate, releases)));

      final first = app.dispose();
      final second = app.dispose();
      gate.complete();
      await Future.wait([first, second]);
      await app.dispose();

      expect(releases, ['slow']);
      expect(app.isReleased, isTrue);
    });
  });
}
