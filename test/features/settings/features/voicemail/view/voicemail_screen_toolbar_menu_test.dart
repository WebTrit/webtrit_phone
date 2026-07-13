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

class _MockVoicemailCubit extends MockCubit<VoicemailState> implements VoicemailCubit {}

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

  Widget host({required bool canSelectModel, required bool cacheAvailable}) {
    final cubit = _MockVoicemailCubit();
    whenListen(
      cubit,
      const Stream<VoicemailState>.empty(),
      initialState: const VoicemailState(status: VoicemailStatus.loaded),
    );
    when(() => cubit.canSelectTranscriptionModel).thenReturn(canSelectModel);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiProvider(
        providers: [
          BlocProvider<VoicemailCubit>.value(value: cubit),
          Provider<AppCacheManager>(
            create: (_) => AppCacheManager(sections: cacheAvailable ? [_FakeCacheSection()] : const []),
          ),
        ],
        child: const VoicemailScreen(),
      ),
    );
  }

  testWidgets('overflow menu offers delete, transcription model and cache management', (tester) async {
    await tester.pumpWidget(host(canSelectModel: true, cacheAvailable: true));

    await tester.tap(overflowButton);
    await tester.pumpAndSettle();

    expect(find.text('Delete'), findsOneWidget);
    expect(find.text('Transcription model'), findsOneWidget);
    expect(find.text('Storage & cache'), findsOneWidget);
  });

  testWidgets('hides the model item when the model is not selectable', (tester) async {
    await tester.pumpWidget(host(canSelectModel: false, cacheAvailable: true));

    await tester.tap(overflowButton);
    await tester.pumpAndSettle();

    expect(find.text('Transcription model'), findsNothing);
    expect(find.text('Storage & cache'), findsOneWidget);
  });

  testWidgets('keeps only delete when nothing else is available', (tester) async {
    await tester.pumpWidget(host(canSelectModel: false, cacheAvailable: false));

    await tester.tap(overflowButton);
    await tester.pumpAndSettle();

    expect(find.text('Delete'), findsOneWidget);
    expect(find.text('Transcription model'), findsNothing);
    expect(find.text('Storage & cache'), findsNothing);
  });
}
