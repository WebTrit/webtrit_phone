import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/keypad/widgets/actionpad.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

import '../../helpers/helpers.dart';

void main() {
  Widget buildTestable({
    List<String> callNumbers = const ['1001'],
    VoidCallback? onAudioCallPressed,
    VoidCallback? onVideoCallPressed,
    VoidCallback? onTransferPressed,
    VoidCallback? onInitiatedTransferPressed,
    VoidCallback? onBackspacePressed,
  }) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Actionpad(
          callNumbers: callNumbers,
          actionsEnabled: true,
          onAudioCallPressed: onAudioCallPressed,
          onVideoCallPressed: onVideoCallPressed,
          onTransferPressed: onTransferPressed,
          onInitiatedTransferPressed: onInitiatedTransferPressed,
          onBackspacePressed: onBackspacePressed,
        ),
      ),
    );
  }

  testWidgets('call button is announced as "Audio call" and is targetable by id', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(buildTestable(onAudioCallPressed: () {}, onBackspacePressed: () {}));

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(actionPadVoiceCallId),
      label: 'Audio call',
      identifier: actionPadVoiceCallId,
      isButton: true,
    );

    handle.dispose();
  });

  testWidgets('video call button is announced as "Video call"', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(buildTestable(onAudioCallPressed: () {}, onVideoCallPressed: () {}));

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(actionPadVideoCallId),
      label: 'Video call',
      identifier: actionPadVideoCallId,
      isButton: true,
    );

    handle.dispose();
  });

  testWidgets('backspace is announced as "Backspace"', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(buildTestable(onAudioCallPressed: () {}, onBackspacePressed: () {}));

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(actionPadBackspaceId),
      label: 'Backspace',
      identifier: actionPadBackspaceId,
      isButton: true,
    );

    handle.dispose();
  });

  testWidgets('transfer button is announced and targetable during a transfer flow', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(buildTestable(onInitiatedTransferPressed: () {}));

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(actionPadTransferId),
      label: 'Transfer current call',
      identifier: actionPadTransferId,
      isButton: true,
    );

    handle.dispose();
  });

  testWidgets('overflow menu trigger keeps its localized name and gains an id, and still opens the menu', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      buildTestable(onAudioCallPressed: () {}, onVideoCallPressed: () {}, onTransferPressed: () {}),
    );

    final overflow = find.bySemanticsIdentifier(actionPadOverflowId);
    expectTapTargetSemantics(tester, overflow, identifier: actionPadOverflowId, isButton: true);

    await tester.tap(overflow);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(PopupMenuItem<dynamic>, 'Video call'), findsOneWidget);
    expect(find.widgetWithText(PopupMenuItem<dynamic>, 'Transfer current call'), findsOneWidget);

    handle.dispose();
  });
}
