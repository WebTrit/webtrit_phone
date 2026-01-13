import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/features.dart';

class MockDeviceRotationService extends Mock implements DeviceRotationUtil {}

void main() {
  group('OrientationsBloc', () {
    late DeviceRotationUtil deviceRotationService;
    late StreamController<bool> rotationStreamController;
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      deviceRotationService = MockDeviceRotationService();
      rotationStreamController = StreamController<bool>();
      log.clear();

      when(() => deviceRotationService.stream).thenAnswer((_) => rotationStreamController.stream);

      when(() => deviceRotationService.isEnabled).thenAnswer((_) async => true);

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall methodCall) async {
          log.add(methodCall);
          return null;
        },
      );
    });

    tearDown(() {
      rotationStreamController.close();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });

    test('initial state is correct', () {
      final bloc = OrientationsBloc(deviceRotationUtil: deviceRotationService);
      expect(bloc.state, const OrientationsState());
      bloc.close();
    });

    group('OrientationsChanged', () {
      blocTest<OrientationsBloc, OrientationsState>(
        'emits state with PreferredOrientation.portrait and forces portrait (Up & Down)',
        build: () => OrientationsBloc(deviceRotationUtil: deviceRotationService),
        act: (bloc) => bloc.add(const OrientationsChanged(PreferredOrientation.portrait)),
        expect: () => [const OrientationsState(lastOrientation: PreferredOrientation.portrait)],
        verify: (_) {
          expect(log, isNotEmpty);
          final call = log.last;
          expect(call.method, 'SystemChrome.setPreferredOrientations');
          // Expects both portrait orientations
          expect(call.arguments, ['DeviceOrientation.portraitUp', 'DeviceOrientation.portraitDown']);
        },
      );

      blocTest<OrientationsBloc, OrientationsState>(
        'emits state with PreferredOrientation.auto and enables all orientations when system rotation is ON',
        setUp: () {
          when(() => deviceRotationService.isEnabled).thenAnswer((_) async => true);
        },
        build: () => OrientationsBloc(deviceRotationUtil: deviceRotationService),
        act: (bloc) => bloc.add(const OrientationsChanged(PreferredOrientation.auto)),
        expect: () => [const OrientationsState(lastOrientation: PreferredOrientation.auto)],
        verify: (_) {
          final call = log.last;
          expect(call.method, 'SystemChrome.setPreferredOrientations');
          // Expects all 4 orientations
          expect(
            call.arguments,
            unorderedEquals([
              'DeviceOrientation.portraitUp',
              'DeviceOrientation.portraitDown',
              'DeviceOrientation.landscapeLeft',
              'DeviceOrientation.landscapeRight',
            ]),
          );
        },
      );

      blocTest<OrientationsBloc, OrientationsState>(
        'emits state with PreferredOrientation.auto but restricts to portrait if system rotation is OFF',
        setUp: () {
          when(() => deviceRotationService.isEnabled).thenAnswer((_) async => false);
        },
        build: () => OrientationsBloc(deviceRotationUtil: deviceRotationService),
        act: (bloc) => bloc.add(const OrientationsChanged(PreferredOrientation.auto)),
        expect: () => [const OrientationsState(lastOrientation: PreferredOrientation.auto)],
        verify: (_) {
          final call = log.last;
          expect(call.method, 'SystemChrome.setPreferredOrientations');
          // Should fallback to portrait only
          expect(call.arguments, ['DeviceOrientation.portraitUp', 'DeviceOrientation.portraitDown']);
        },
      );
    });

    group('SystemRotationChanged (Stream)', () {
      blocTest<OrientationsBloc, OrientationsState>(
        'updates system chrome when in Auto mode and device rotation changes',
        build: () => OrientationsBloc(deviceRotationUtil: deviceRotationService),
        seed: () => const OrientationsState(lastOrientation: PreferredOrientation.auto),
        act: (bloc) {
          // Trigger a change from the mocked stream
          rotationStreamController.add(true);
        },
        expect: () => [],
        // State object doesn't change, but side effect occurs
        verify: (_) {
          final call = log.last;
          expect(call.method, 'SystemChrome.setPreferredOrientations');
          expect(
            call.arguments,
            unorderedEquals([
              'DeviceOrientation.portraitUp',
              'DeviceOrientation.portraitDown',
              'DeviceOrientation.landscapeLeft',
              'DeviceOrientation.landscapeRight',
            ]),
          );
        },
      );

      blocTest<OrientationsBloc, OrientationsState>(
        'ignores device rotation changes when in Portrait mode',
        build: () => OrientationsBloc(deviceRotationUtil: deviceRotationService),
        seed: () => const OrientationsState(lastOrientation: PreferredOrientation.portrait),
        act: (bloc) {
          rotationStreamController.add(true);
        },
        expect: () => [],
        verify: (_) {
          // Verify no additional SystemChrome calls were made as a result of this action.
          // If a pristine call log is required for strict assertion, clear or reinitialize `log` in `seed`/`setUp`.
          // An empty `log` here indicates the rotation event produced no side-effects.
          expect(log, isEmpty);
        },
      );
    });
  });
}
