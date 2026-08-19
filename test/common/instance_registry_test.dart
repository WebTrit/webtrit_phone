import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/common/common.dart';

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

class _Plain {}

void main() {
  group('InstanceRegistry lookup', () {
    test('refuses a second instance of the same type', () {
      final registry = InstanceRegistry()..register<_Plain>(_Plain());

      expect(() => registry.register<_Plain>(_Plain()), throwsStateError);
    });

    test('refuses to invent an instance that was never registered', () {
      expect(() => InstanceRegistry().get<_Plain>(), throwsStateError);
    });

    test('hands back exactly what was registered', () {
      final instance = _Plain();
      final registry = InstanceRegistry()..register<_Plain>(instance);

      expect(registry.get<_Plain>(), same(instance));
    });
  });

  group('InstanceRegistry.dispose', () {
    test('releases in reverse order of registration', () async {
      final released = <String>[];
      final registry = InstanceRegistry()
        ..register<_Recorded>(_Recorded('first', released))
        ..register<_Failing>(_Failing())
        ..register<_Slow>(_Slow(Completer<void>()..complete(), released));

      await registry.dispose();

      expect(released, ['slow', 'first']);
    });

    test('an empty registry releases without complaint', () async {
      await expectLater(InstanceRegistry().dispose(), completes);
    });

    test('skips instances that hold no resources', () async {
      final registry = InstanceRegistry()..register<_Plain>(_Plain());

      await expectLater(registry.dispose(), completes);
    });

    test('a failing release does not stop the remaining ones', () async {
      final released = <String>[];
      final registry = InstanceRegistry()
        ..register<_Recorded>(_Recorded('first', released))
        ..register<_Failing>(_Failing());

      await expectLater(registry.dispose(), completes);

      expect(released, ['first']);
    });

    test('runs once, even when a second call arrives while the first is still releasing', () async {
      final releases = <String>[];
      final gate = Completer<void>();
      final registry = InstanceRegistry()..register<_Slow>(_Slow(gate, releases));

      final first = registry.dispose();
      final second = registry.dispose();
      gate.complete();
      await Future.wait([first, second]);
      await registry.dispose();

      expect(releases, ['slow']);
      expect(registry.isReleased, isTrue);
    });

    test('a released registry refuses to hand instances out', () async {
      final registry = InstanceRegistry()..register<_Plain>(_Plain());

      await registry.dispose();

      expect(() => registry.get<_Plain>(), throwsStateError);
    });
  });
}
