import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/settings/features/voicemail/widgets/playback_button.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      // The button names itself for assistive technology, so it needs the
      // localizations even in a bare harness.
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('offers to start playback while idle and to stop it while playing', (tester) async {
    await tester.pumpWidget(wrap(PlaybackButton(playing: false, onPressed: () {})));
    expect(find.byIcon(Icons.play_arrow), findsOneWidget);

    await tester.pumpWidget(wrap(PlaybackButton(playing: true, onPressed: () {})));
    expect(find.byIcon(Icons.pause), findsOneWidget);
  });

  testWidgets('reports the press', (tester) async {
    var pressed = 0;
    await tester.pumpWidget(wrap(PlaybackButton(playing: false, onPressed: () => pressed++)));

    await tester.tap(find.byType(PlaybackButton));
    expect(pressed, 1);
  });
}
