import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/register_status/register_status.dart';
import 'package:webtrit_phone/features/settings/widgets/register_status_list_tile.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  late List<bool> changes;
  late int unavailableTaps;

  setUp(() {
    changes = [];
    unavailableTaps = 0;
  });

  Widget buildTestable({
    required CallStatus signalingStatus,
    required RegisterStatus registerStatus,
    TextStyle? textStyle,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: RegisterStatusListTile(
          sessionStatus: SessionStatus(signalingStatus: signalingStatus),
          registerStatus: registerStatus,
          onChanged: changes.add,
          onUnavailableTap: () => unavailableTaps++,
          textStyle: textStyle,
        ),
      ),
    );
  }

  AppLocalizations l10nOf(WidgetTester tester) =>
      AppLocalizations.of(tester.element(find.byType(RegisterStatusListTile)))!;

  group('server may be reachable', () {
    testWidgets('switch is interactive and explains that calls are accepted', (tester) async {
      await tester.pumpWidget(
        buildTestable(signalingStatus: CallStatus.ready, registerStatus: const RegisterStatus(value: true)),
      );

      final l10n = l10nOf(tester);
      expect(find.text(l10n.settings_ListViewTileSubtitle_registeredOn), findsOneWidget);
      expect(tester.widget<Switch>(find.byType(Switch)).onChanged, isNotNull);

      await tester.tap(find.byType(Switch));
      expect(changes, [false]);
      expect(unavailableTaps, 0);
    });

    testWidgets('an unregistered account is not a connectivity problem, so the switch stays usable', (tester) async {
      await tester.pumpWidget(
        buildTestable(signalingStatus: CallStatus.appUnregistered, registerStatus: const RegisterStatus(value: false)),
      );

      final l10n = l10nOf(tester);
      expect(find.text(l10n.settings_ListViewTileSubtitle_registeredOff), findsOneWidget);
      expect(tester.widget<Switch>(find.byType(Switch)).onChanged, isNotNull);
    });

    testWidgets('a signaling-channel problem does not block the HTTP-backed setting', (tester) async {
      for (final status in [CallStatus.connectError, CallStatus.connectIssue]) {
        await tester.pumpWidget(
          buildTestable(signalingStatus: status, registerStatus: const RegisterStatus(value: true)),
        );

        expect(tester.widget<Switch>(find.byType(Switch)).onChanged, isNotNull, reason: '$status must stay usable');
      }
    });

    testWidgets('theme text color is passed through undimmed', (tester) async {
      const themed = TextStyle(color: Color(0xFF123456));
      await tester.pumpWidget(
        buildTestable(
          signalingStatus: CallStatus.ready,
          registerStatus: const RegisterStatus(value: true),
          textStyle: themed,
        ),
      );

      final l10n = l10nOf(tester);
      final title = tester.widget<Text>(find.text(l10n.settings_ListViewTileTitle_registered));
      expect(title.style?.color, themed.color);
    });
  });

  group('server is out of reach', () {
    testWidgets('keeps the last known value but drops the claim about it', (tester) async {
      await tester.pumpWidget(
        buildTestable(signalingStatus: CallStatus.connectivityNone, registerStatus: const RegisterStatus(value: true)),
      );

      final l10n = l10nOf(tester);
      expect(find.text(l10n.settings_ListViewTileSubtitle_registeredNeedsConnection), findsOneWidget);

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isTrue, reason: 'the cached value must not be rewritten to false');
      expect(switchWidget.onChanged, isNull);
    });

    testWidgets('a tap reports the row as unavailable instead of toggling', (tester) async {
      await tester.pumpWidget(
        buildTestable(signalingStatus: CallStatus.connectivityNone, registerStatus: const RegisterStatus(value: true)),
      );

      await tester.tap(find.byType(RegisterStatusListTile));
      expect(unavailableTaps, 1);
      expect(changes, isEmpty);
    });

    testWidgets('while connecting the subtitle says the app is waiting, not that it failed', (tester) async {
      await tester.pumpWidget(
        buildTestable(signalingStatus: CallStatus.inProgress, registerStatus: const RegisterStatus(value: true)),
      );

      final l10n = l10nOf(tester);
      expect(find.text(l10n.settings_ListViewTileSubtitle_registeredWaitingForConnection), findsOneWidget);
      expect(tester.widget<Switch>(find.byType(Switch)).onChanged, isNull);
    });

    testWidgets('explicit theme colors are dimmed once, since Material cannot reach them', (tester) async {
      const themed = TextStyle(color: Color(0xFF123456));
      await tester.pumpWidget(
        buildTestable(
          signalingStatus: CallStatus.connectivityNone,
          registerStatus: const RegisterStatus(value: true),
          textStyle: themed,
        ),
      );

      final l10n = l10nOf(tester);
      final title = tester.widget<Text>(find.text(l10n.settings_ListViewTileTitle_registered));
      expect(title.style?.color?.a, closeTo(0.38, 0.001));
      // The tile itself must not add a second, stacked dimming layer on top.
      expect(tester.widgetList<Opacity>(find.byType(Opacity)).where((widget) => widget.opacity < 1), isEmpty);
    });
  });

  testWidgets('an in-flight update replaces the switch with a progress indicator', (tester) async {
    await tester.pumpWidget(
      buildTestable(
        signalingStatus: CallStatus.ready,
        registerStatus: const RegisterStatus(value: true, isUpdating: true),
      ),
    );

    final l10n = l10nOf(tester);
    expect(find.text(l10n.settings_ListViewTileSubtitle_registeredUpdating), findsOneWidget);
    expect(find.byType(Switch), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
