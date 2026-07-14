import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'dart:typed_data';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/settings/features/transcription_settings/transcription_settings.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

class _MockStackRouter extends Mock implements StackRouter {}

class _FakeTranscriptionDataSource implements TranscriptionDataSource {
  _FakeTranscriptionDataSource(this.engine);

  @override
  final String engine;

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) async => '';

  @override
  void dispose() {}
}

class _NoopTranscriptionStore implements TranscriptionStore {
  @override
  Future<bool> saveInProgress(String mediaType, String mediaId, String engine) async => true;

  @override
  Future<void> saveTranscript(String mediaType, String mediaId, String transcript, String engine) async {}

  @override
  Future<bool> saveFailure(String mediaType, String mediaId, Object error, String engine) async => true;

  @override
  Future<void> remove(String mediaType, String mediaId) async {}

  @override
  Future<void> removeAllForType(String mediaType) async {}

  @override
  Future<void> removeAll() async {}
}

class _FakeTranscriptionModelRepository implements TranscriptionModelRepository {
  String? value;

  @override
  String? getTranscriptionModel() => value;

  @override
  Future<void> setTranscriptionModel(String? newValue) async {
    value = newValue;
  }

  @override
  Future<void> clear() async {
    value = null;
  }
}

void main() {
  Widget wrap(_FakeTranscriptionModelRepository modelRepository, {String defaultModel = 'base'}) {
    final router = _MockStackRouter();
    when(
      () => router.canPop(
        ignoreChildRoutes: any(named: 'ignoreChildRoutes'),
        ignoreParentRoutes: any(named: 'ignoreParentRoutes'),
        ignorePagelessRoutes: any(named: 'ignorePagelessRoutes'),
      ),
    ).thenReturn(false);
    when(() => router.topPage).thenReturn(null);
    when(() => router.pagelessRoutesObserver).thenReturn(PagelessRoutesObserver());

    final modelService = TranscriptionModelService(
      modelRepository: modelRepository,
      transcriptionService: TranscriptionService(
        (model) => _FakeTranscriptionDataSource('fake:${model ?? defaultModel}'),
        initialLocalModel: modelRepository.getTranscriptionModel(),
        store: _NoopTranscriptionStore(),
      ),
      transcriptionConfig: TranscriptionConfig(mode: 'local', localModel: defaultModel),
    );

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: RouterScope(
        controller: router,
        inheritableObserversBuilder: () => const [],
        stateHash: 0,
        navigatorObservers: const [],
        child: StackRouterScope(
          controller: router,
          stateHash: 0,
          child: BlocProvider(
            create: (_) => TranscriptionSettingsCubit(modelService: modelService),
            child: const TranscriptionSettingsScreen(),
          ),
        ),
      ),
    );
  }

  testWidgets('lists the preset tiers and marks the default one', (tester) async {
    await tester.pumpWidget(wrap(_FakeTranscriptionModelRepository()));

    expect(find.text('Fast (Default)'), findsOneWidget);
    expect(find.text('Balanced'), findsOneWidget);
    expect(find.text('Accurate'), findsOneWidget);
  });

  testWidgets('selecting a tier persists it as the override', (tester) async {
    final modelRepository = _FakeTranscriptionModelRepository();
    await tester.pumpWidget(wrap(modelRepository));

    await tester.tap(find.text('Balanced'));
    await tester.pumpAndSettle();

    expect(modelRepository.value, 'small');
    final radioGroup = tester.widget<RadioGroup<String>>(find.byType(RadioGroup<String>));
    expect(radioGroup.groupValue, 'small');
  });

  testWidgets('picking the default tier clears the override', (tester) async {
    final modelRepository = _FakeTranscriptionModelRepository()..value = 'small';
    await tester.pumpWidget(wrap(modelRepository));

    await tester.tap(find.text('Fast (Default)'));
    await tester.pumpAndSettle();

    expect(modelRepository.value, isNull);
  });

  testWidgets('a non-preset default appears as an extra option with its raw name', (tester) async {
    await tester.pumpWidget(wrap(_FakeTranscriptionModelRepository(), defaultModel: 'tiny.en'));

    expect(find.text('tiny.en (Default)'), findsOneWidget);
    final radioGroup = tester.widget<RadioGroup<String>>(find.byType(RadioGroup<String>));
    expect(radioGroup.groupValue, 'tiny.en');
  });
}
