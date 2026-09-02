import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/settings/settings.dart';
import 'package:webtrit_phone/features/settings/widgets/session_status_list_tile.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

class _MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState> implements SettingsBloc {}

class _MockMicrophoneStatusBloc extends MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>
    implements MicrophoneStatusBloc {}

void main() {
  late _MockSettingsBloc settingsBloc;
  late _MockMicrophoneStatusBloc microphoneStatusBloc;
  late int taps;

  setUp(() {
    settingsBloc = _MockSettingsBloc();
    microphoneStatusBloc = _MockMicrophoneStatusBloc();
    taps = 0;

    when(() => settingsBloc.state).thenReturn(const SettingsState(progress: false));
    when(() => microphoneStatusBloc.state).thenReturn(const MicrophoneStatusState());
  });

  Future<void> pump(WidgetTester tester, {bool microphoneGranted = true}) async {
    when(
      () => microphoneStatusBloc.state,
    ).thenReturn(MicrophoneStatusState(microphonePermissionGranted: microphoneGranted));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider<SettingsBloc>.value(value: settingsBloc),
              BlocProvider<MicrophoneStatusBloc>.value(value: microphoneStatusBloc),
            ],
            child: SessionStatusListTile(
              status: const SessionStatus(signalingStatus: CallStatus.ready),
              registered: true,
              onTap: () => taps++,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('the row is a button, not a bare gesture area', (tester) async {
    await pump(tester);

    // It used to be a gesture detector wrapped around the row, which answered
    // a tap without ever announcing that it could be pressed.
    expect(tester.widget<ListTile>(find.byType(ListTile)).onTap, isNotNull);

    await tester.tap(find.byType(ListTile));
    expect(taps, 1);
  });

  testWidgets('a tap at the far edge of the row still opens it', (tester) async {
    await pump(tester);

    final row = tester.getRect(find.byType(ListTile));
    await tester.tapAt(Offset(row.right - 8, row.center.dy));

    expect(taps, 1);
  });

  testWidgets('the microphone warning leads where it can be dealt with', (tester) async {
    await pump(tester, microphoneGranted: false);

    // The warning sat inside the gesture area that used to cover the whole
    // row, so it opened the diagnostics too; moving the tap onto the row alone
    // would have taken that away without anyone noticing.
    await tester.tap(find.byIcon(Icons.warning_amber));
    await tester.pump();

    expect(taps, 1);

    // And a screen reader has to be told it is something to press, not just a
    // sentence read out.
    final handle = tester.ensureSemantics();
    expect(tester.getSemantics(find.byIcon(Icons.warning_amber)).getSemanticsData().flagsCollection.isButton, isTrue);
    handle.dispose();
  });
}
