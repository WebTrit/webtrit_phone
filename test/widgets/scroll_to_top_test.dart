import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/scroll_to_top.dart';

/// Room the app shell takes at the bottom of every tab page: its tab bar plus
/// the system inset underneath it.
const _shellBarRoom = 80.0;

void main() {
  testWidgets('the jump-to-top button stays clear of the tab bar', (tester) async {
    await tester.pumpWidget(
      // Stands in for the app shell: it floats its tab bar over the page and
      // reports the room it takes as the page's bottom padding.
      MediaQuery(
        data: const MediaQueryData(padding: EdgeInsets.only(bottom: _shellBarRoom)),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ScrollToTopOverlay(
              scrolledAway: true,
              onScrollToTop: () {},
              child: ListView(children: const [SizedBox(height: 2000)]),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The tab bar of the main screen floats over these lists. Pinned to the
    // bottom the button is drawn underneath it: visible in the tree, named,
    // and impossible to press - which is how it shipped.
    final button = tester.getRect(find.byType(ScrollToTopButton));
    final screenHeight = tester.getSize(find.byType(ScrollToTopOverlay)).height;

    expect(screenHeight - button.bottom, greaterThanOrEqualTo(_shellBarRoom));
  });
}
