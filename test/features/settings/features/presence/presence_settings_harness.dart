import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/settings/features/presence/presence.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../../../../helpers/helpers.dart';

/// Presence settings kept in memory, so a test can start the screen from a
/// given status and read back what the screen stored.
class FakePresenceSettingsRepository implements PresenceSettingsRepository {
  FakePresenceSettingsRepository(this._settings);

  PresenceSettings _settings;
  DateTime? _lastSettingsSync;

  @override
  PresenceSettings get presenceSettings => _settings;

  @override
  void updatePresenceSettings(PresenceSettings settings) => _settings = settings;

  @override
  DateTime? get lastSettingsSync => _lastSettingsSync;

  @override
  void updateLastSettingsSync(DateTime time) => _lastSettingsSync = time;

  @override
  void resetLastSettingsSync() => _lastSettingsSync = null;

  @override
  Future<void> clear() async => _settings = PresenceSettings.blank(device: _settings.device);
}

class _StubStackRouter extends Mock implements StackRouter {}

/// Puts the router scopes the app bar's back button looks up around [child].
///
/// The button comes from `auto_route` and asks for its router while it is
/// being built, so a screen carrying one cannot be pumped without one. This
/// router reports nothing to go back to, which leaves the app bar with no
/// leading button at all - the screen itself is what these tests are after.
Widget _withStubRouter(Widget child) {
  final router = _StubStackRouter();
  when(() => router.pagelessRoutesObserver).thenReturn(PagelessRoutesObserver());
  when(
    () => router.canPop(
      ignoreChildRoutes: any(named: 'ignoreChildRoutes'),
      ignoreParentRoutes: any(named: 'ignoreParentRoutes'),
      ignorePagelessRoutes: any(named: 'ignorePagelessRoutes'),
    ),
  ).thenReturn(false);

  return RouterScope(
    controller: router,
    inheritableObserversBuilder: () => const [],
    stateHash: 0,
    child: StackRouterScope(controller: router, stateHash: 0, child: child),
  );
}

/// A status that matches none of the presets, which is what makes the screen
/// open its section of controls straight away.
PresenceSettings statusOffThePresets({bool available = true, String note = 'Working from home', String? icon}) {
  return PresenceSettings.blank(device: 'test device')
      .copyWithAvailable(available)
      .copyWithNote(note)
      .copyWithStatusIcon(icon);
}

/// Everything the presence settings screen needs around it.
class PresenceSettingsHarness {
  PresenceSettingsHarness({PresenceSettings? settings})
    : repository = FakePresenceSettingsRepository(settings ?? statusOffThePresets());

  final FakePresenceSettingsRepository repository;

  PresenceSettings get settings => repository.presenceSettings;

  Future<void> pump(WidgetTester tester) async {
    // A phone-shaped surface, wide enough for the block font the test
    // environment draws with: the default test window is shorter than this
    // screen, and a control below its edge cannot be pressed.
    tester.view.physicalSize = const Size(520, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: _withStubRouter(
          BlocProvider(create: (_) => PresenceSettingsCubit(repository), child: const PresenceSettingsScreen()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The screen only unfolds its section of controls for a status that
    // matches no preset; every test here is about what is inside it.
    expect(find.byType(SwitchListTile), findsNWidgets(2), reason: 'the section of controls is folded away');
  }

  /// Presses the [index]th explanation button of the section.
  Future<void> pressExplanation(WidgetTester tester, int index) async {
    await _press(tester, infoButtonAt(index));
  }

  /// Presses through the semantics action rather than with a pointer: the
  /// preset menu keeps a hidden copy of its entries laid out over the screen
  /// to measure itself with, and it swallows pointers aimed at what is behind
  /// it. This is the path assistive technology takes anyway.
  Future<void> _press(WidgetTester tester, Finder finder) async {
    final semantics = tester.ensureSemantics();
    await tester.pump();
    await tapViaSemantics(tester, finder);
    semantics.dispose();
    await tester.pumpAndSettle();
  }

  /// The [index]th explanation button of the section, top to bottom.
  Finder infoButtonAt(int index) =>
      find.ancestor(of: find.byIcon(Icons.info_outline).at(index), matching: find.byType(IconButton)).first;

  /// Opens the sheet that picks the status icon.
  Future<void> openStatusIconPicker(WidgetTester tester) async {
    await _press(tester, find.ancestor(of: find.byIcon(Icons.search), matching: find.byType(IconButton)).first);
  }
}
