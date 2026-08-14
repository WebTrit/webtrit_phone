import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/register_status/register_status.dart';
import 'package:webtrit_phone/features/settings/settings.dart';
import 'package:webtrit_phone/features/settings/widgets/register_status_list_tile.dart';
import 'package:webtrit_phone/features/settings/widgets/session_status_list_tile.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../helpers/helpers.dart';

class _MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState> implements SettingsBloc {}

class _MockMicrophoneStatusBloc extends MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>
    implements MicrophoneStatusBloc {}

void main() {
  late _MockSettingsBloc settingsBloc;
  late _MockMicrophoneStatusBloc microphoneStatusBloc;

  setUp(() {
    settingsBloc = _MockSettingsBloc();
    microphoneStatusBloc = _MockMicrophoneStatusBloc();
    when(() => settingsBloc.state).thenReturn(const SettingsState(progress: false));
    when(() => microphoneStatusBloc.state).thenReturn(const MicrophoneStatusState());
  });

  Widget wrap(Widget child) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>.value(value: settingsBloc),
          BlocProvider<MicrophoneStatusBloc>.value(value: microphoneStatusBloc),
        ],
        child: child,
      ),
    ),
  );

  testWidgets('the connection row can be found by id whatever it says', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      wrap(
        SessionStatusListTile(
          status: const SessionStatus(signalingStatus: CallStatus.ready),
          registered: true,
          onTap: () {},
        ),
      ),
    );

    // The caption is the part that changes - connected, connecting, an issue -
    // so a test that looks for the row cannot rely on it.
    // And the id has to sit on the node that carries the row's own text and
    // its tap, not on an empty node above it.
    final row = tester.getSemantics(find.bySemanticsIdentifier(sessionStatusTileId)).getSemanticsData();
    expect(row.label, isNotEmpty);
    expect(row.hasAction(ui.SemanticsAction.tap), isTrue);

    handle.dispose();
  });

  testWidgets('the registration row keeps one id in both of its states', (tester) async {
    final handle = tester.ensureSemantics();

    for (final status in [CallStatus.ready, CallStatus.connectivityNone]) {
      await tester.pumpWidget(
        wrap(
          RegisterStatusListTile(
            sessionStatus: SessionStatus(signalingStatus: status),
            registerStatus: const RegisterStatus(value: true),
            onChanged: (_) {},
            onUnavailableTap: () {},
          ),
        ),
      );

      // One node with the id, the wording and the state - an id on a node of
      // its own would be an anchor that says nothing.
      expect(
        tester.getSemantics(find.bySemanticsIdentifier(registerStatusSwitchId)),
        isSemantics(identifier: registerStatusSwitchId, hasToggledState: true, isToggled: true),
        reason: '$status',
      );
      expect(
        tester.getSemantics(find.bySemanticsIdentifier(registerStatusSwitchId)).getSemanticsData().label,
        isNotEmpty,
        reason: '$status',
      );
    }

    handle.dispose();
  });

  testWidgets('a screen reader can open the connection row, not just a finger', (tester) async {
    final handle = tester.ensureSemantics();
    var taps = 0;

    await tester.pumpWidget(
      wrap(
        SessionStatusListTile(
          status: const SessionStatus(signalingStatus: CallStatus.ready),
          registered: true,
          onTap: () => taps++,
        ),
      ),
    );

    // A pointer tap passes while the semantics path is broken, so activation
    // has to go through the node the screen reader uses.
    await tapViaSemantics(tester, find.bySemanticsIdentifier(sessionStatusTileId));

    expect(taps, 1);

    handle.dispose();
  });

  testWidgets('the rows leave no unlabelled tap target behind them', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      wrap(
        Column(
          children: [
            SessionStatusListTile(
              status: const SessionStatus(signalingStatus: CallStatus.ready),
              registered: true,
              onTap: () {},
            ),
            RegisterStatusListTile(
              sessionStatus: const SessionStatus(signalingStatus: CallStatus.ready),
              registerStatus: const RegisterStatus(value: true),
              onChanged: (_) {},
              onUnavailableTap: () {},
            ),
          ],
        ),
      ),
    );

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
