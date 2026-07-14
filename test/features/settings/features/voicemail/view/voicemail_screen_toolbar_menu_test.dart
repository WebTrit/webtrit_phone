import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/settings/features/voicemail/bloc/bloc.dart';
import 'package:webtrit_phone/features/settings/features/voicemail/view/voicemail_screen.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/services/services.dart';

class _MockVoicemailCubit extends MockCubit<VoicemailState> implements VoicemailCubit {}

class _MockTranscriptionModelService extends Mock implements TranscriptionModelService {}

class _FakeCacheSection implements CacheSection {
  @override
  String get id => 'voicemail';

  @override
  String get titleL10n => 'voicemail_Cache_title';

  @override
  String get descriptionL10n => 'voicemail_Cache_description';

  @override
  Future<CacheUsage> usage() async => const CacheUsage.bytes(0);

  @override
  Future<void> clear() async {}
}

void main() {
  final overflowButton = find.byWidgetPredicate((widget) => widget is PopupMenuButton);

  Widget host({required bool cacheAvailable, bool canSelectModel = true}) {
    final modelService = _MockTranscriptionModelService();
    when(() => modelService.canSelectModel).thenReturn(canSelectModel);

    final cubit = _MockVoicemailCubit();
    whenListen(
      cubit,
      const Stream<VoicemailState>.empty(),
      initialState: const VoicemailState(status: VoicemailStatus.loaded),
    );

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiProvider(
        providers: [
          BlocProvider<VoicemailCubit>.value(value: cubit),
          Provider<TranscriptionModelService>.value(value: modelService),
          Provider<AppCacheManager>(
            create: (_) => AppCacheManager(sections: cacheAvailable ? [_FakeCacheSection()] : const []),
          ),
        ],
        child: const VoicemailScreen(),
      ),
    );
  }

  testWidgets('overflow menu offers delete, transcription model and cache management', (tester) async {
    await tester.pumpWidget(host(cacheAvailable: true));

    await tester.tap(overflowButton);
    await tester.pumpAndSettle();

    expect(find.text('Delete'), findsOneWidget);
    expect(find.text('Transcription model'), findsOneWidget);
    expect(find.text('Storage & cache'), findsOneWidget);
  });

  testWidgets('hides only the cache item when no cache sections are registered', (tester) async {
    await tester.pumpWidget(host(cacheAvailable: false));

    await tester.tap(overflowButton);
    await tester.pumpAndSettle();

    expect(find.text('Delete'), findsOneWidget);
    expect(find.text('Transcription model'), findsOneWidget);
    expect(find.text('Storage & cache'), findsNothing);
  });
}
