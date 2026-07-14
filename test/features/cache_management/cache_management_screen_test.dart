import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/settings/features/cache_management/cache_management.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';

class _MockStackRouter extends Mock implements StackRouter {}

class _FakeCacheSection implements CacheSection {
  _FakeCacheSection({this.size = 0});

  int size;
  int clearCalls = 0;

  @override
  String get id => 'voicemail';

  @override
  String get titleL10n => 'voicemail_Cache_title';

  @override
  String get descriptionL10n => 'voicemail_Cache_description';

  @override
  Future<CacheUsage> usage() async => CacheUsage.bytes(size);

  @override
  Future<void> clear() async {
    clearCalls++;
    size = 0;
  }
}

class _FakeItemsCacheSection implements CacheSection {
  _FakeItemsCacheSection({this.count = 0});

  int count;

  @override
  String get id => 'database';

  @override
  String get titleL10n => 'database_Cache_title';

  @override
  String get descriptionL10n => 'database_Cache_description';

  @override
  Future<CacheUsage> usage() async => CacheUsage.items(count);

  @override
  Future<void> clear() async {
    count = 0;
  }
}

class _ThrowingCacheSection implements CacheSection {
  @override
  String get id => 'voicemail';

  @override
  String get titleL10n => 'voicemail_Cache_title';

  @override
  String get descriptionL10n => 'voicemail_Cache_description';

  @override
  Future<CacheUsage> usage() async => throw StateError('database closed');

  @override
  Future<void> clear() async {}
}

void main() {
  Widget wrap(List<CacheSection> sections) {
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
            create: (_) => CacheManagementCubit(AppCacheManager(sections: sections)),
            child: const CacheManagementScreen(),
          ),
        ),
      ),
    );
  }

  testWidgets('renders a section with its title and measured size', (tester) async {
    await tester.pumpWidget(wrap([_FakeCacheSection(size: 2048)]));
    await tester.pump();

    expect(find.text('Voicemail audio'), findsOneWidget);
    expect(find.text('2.0 KB'), findsOneWidget);
  });

  testWidgets('clearing a section re-measures its size', (tester) async {
    final section = _FakeCacheSection(size: 2048);
    await tester.pumpWidget(wrap([section]));
    await tester.pump();

    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();

    expect(section.clearCalls, 1);
    expect(find.text('0 B'), findsOneWidget);
  });

  testWidgets('renders an item-based section with its record count', (tester) async {
    await tester.pumpWidget(wrap([_FakeItemsCacheSection(count: 128)]));
    await tester.pump();

    expect(find.text('Local database'), findsOneWidget);
    expect(find.text('128 records'), findsOneWidget);
  });

  testWidgets('shows an unknown usage when measuring fails', (tester) async {
    await tester.pumpWidget(wrap([_ThrowingCacheSection()]));
    await tester.pump();

    expect(find.text('Unknown'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('shows the empty label without sections', (tester) async {
    await tester.pumpWidget(wrap(const []));

    expect(find.text('Nothing is cached on this device'), findsOneWidget);
  });

  group('formatBytes', () {
    test('formats each magnitude', () {
      expect(formatBytes(0), '0 B');
      expect(formatBytes(500), '500 B');
      expect(formatBytes(2048), '2.0 KB');
      expect(formatBytes(5 * 1024 * 1024), '5.0 MB');
      expect(formatBytes(3 * 1024 * 1024 * 1024), '3.0 GB');
    });

    test('rolls sizes just below a unit boundary over to the next unit', () {
      expect(formatBytes(1048570), '1.0 MB');
      expect(formatBytes(1024 * 1024 * 1024 - 1024), '1.0 GB');
      expect(formatBytes(1023 * 1024), '1023.0 KB');
    });
  });
}
