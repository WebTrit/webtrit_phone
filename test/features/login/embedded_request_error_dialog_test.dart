import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/login/features/login_signup/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

import '../../helpers/helpers.dart';

void main() {
  Widget wrap({required VoidCallback onRetry, VoidCallback? onBack}) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: EmbeddedRequestErrorDialog(
        title: 'Something went wrong',
        error: 'The page could not be loaded',
        onRetry: onRetry,
        onBack: onBack,
      ),
    );
  }

  testWidgets('the dead end names its way out', (tester) async {
    final handle = tester.ensureSemantics();

    var retried = false;
    var wentBack = false;
    await tester.pumpWidget(wrap(onRetry: () => retried = true, onBack: () => wentBack = true));

    expect(find.bySemanticsIdentifier(loginSignupEmbeddedErrorScreenId), findsOneWidget);

    // The way out is named by the framework itself on Android, so we add
    // nothing of our own here: doing that made the node say "Back" twice.
    expect(tester.getSemantics(find.bySemanticsLabel('Back').first), isSemantics(label: 'Back', hasTapAction: true));
    await tapViaSemantics(tester, find.bySemanticsLabel('Back').first);
    expect(wentBack, isTrue);

    await tapViaSemantics(tester, find.bySemanticsIdentifier(loginSignupEmbeddedRetryButtonId));
    expect(retried, isTrue);

    handle.dispose();
  });

  testWidgets('with no way back, only the retry is offered', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(onRetry: () {}));

    expect(find.bySemanticsLabel('Back'), findsNothing);
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(loginSignupEmbeddedRetryButtonId),
      label: 'Try Again',
      identifier: loginSignupEmbeddedRetryButtonId,
    );

    handle.dispose();
  });
}
