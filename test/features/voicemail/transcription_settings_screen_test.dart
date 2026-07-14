import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/settings/features/transcription_settings/transcription_settings.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _MockStackRouter extends Mock implements StackRouter {}

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
            create: (_) => TranscriptionSettingsCubit(
              modelRepository: modelRepository,
              transcriptionConfig: TranscriptionConfig(mode: 'local', localModel: defaultModel),
            ),
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
