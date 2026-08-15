import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../../helpers/helpers.dart';

ActiveCall _acceptedCall() {
  return ActiveCall(
    callId: 'call-1',
    direction: CallDirection.incoming,
    line: 0,
    handle: const CallkeepHandle.number('+380991234567'),
    createdTime: DateTime(2024),
    video: false,
    processingStatus: CallProcessingStatus.connected,
    acceptedTime: DateTime(2024),
    displayName: 'Anna Marchenko',
  );
}

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // The avatar standing in for the missing video reads the presence
      // settings from the tree, the way the app supplies them around the call.
      home: Scaffold(
        body: PresenceViewParams(
          hybridPresenceSupport: false,
          blfViaSipSupport: false,
          presenceViaSipSupport: false,
          child: child,
        ),
      ),
    );
  }

  /// Lets the periodic frame probe finish so the test ends with no live timers.
  Future<void> teardown(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 2));
  }

  group('CallActiveThumbnail', () {
    testWidgets('the window announces where it leads and takes the user there', (tester) async {
      final semantics = tester.ensureSemantics();
      var returns = 0;
      await tester.pumpWidget(
        wrap(
          CallActiveThumbnail(activeCall: _acceptedCall(), orientation: Orientation.portrait, onTap: () => returns++),
        ),
      );
      await tester.pump();

      final window = find.bySemanticsIdentifier(callActiveThumbnailId);
      // The name is the way back, and only that: the initials standing in for
      // the missing video must not be read out after it.
      expectTapTargetSemantics(
        tester,
        window,
        label: 'Return to the call',
        identifier: callActiveThumbnailId,
        isButton: true,
      );

      await tapViaSemantics(tester, window);
      expect(returns, 1);
      await teardown(tester);
      semantics.dispose();
    });
  });
}
