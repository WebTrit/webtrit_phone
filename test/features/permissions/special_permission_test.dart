import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/permissions/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

void main() {
  /// The tips list plus both buttons do not fit the default 800x600 surface,
  /// and a button below the fold cannot be tapped.
  void useTallSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  Widget wrap({required VoidCallback onPop}) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SpecialPermission(
        specialPermissions: CallkeepSpecialPermissions.fullScreenIntent,
        onGoToAppSettings: () {},
        onPop: onPop,
      ),
    );
  }

  testWidgets('the permission can be left for later', (tester) async {
    useTallSurface(tester);
    var skipped = false;

    await tester.pumpWidget(wrap(onPop: () => skipped = true));

    // The label has to read as a choice, not as an acknowledgement: the user is
    // deciding to go on without the permission, not confirming they read the tips.
    expect(find.text('Not now'), findsOneWidget);
    // Both consequences have to be named: the call is only presented differently,
    // but on a protected lock screen answering it now costs an unlock first.
    expect(
      find.text(
        'You can continue without this. Incoming calls will arrive as a notification instead of opening '
        'full screen, and if your phone is locked with a PIN, pattern or fingerprint, you will have to '
        'unlock it to answer from the lock screen.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(permissionTipsButtonKey));
    expect(skipped, isTrue);
  });
}
