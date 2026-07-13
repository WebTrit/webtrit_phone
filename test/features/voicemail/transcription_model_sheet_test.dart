import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/settings/features/voicemail/widgets/transcription_model_sheet.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

void main() {
  Widget wrap({String defaultModel = 'base', String selectedModel = 'base', ValueChanged<String>? onSelected}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: TranscriptionModelSheet(
          defaultModel: defaultModel,
          selectedModel: selectedModel,
          onSelected: onSelected ?? (_) {},
        ),
      ),
    );
  }

  testWidgets('lists the preset tiers and marks the default one', (tester) async {
    await tester.pumpWidget(wrap());

    expect(find.text('Fast (Default)'), findsOneWidget);
    expect(find.text('Balanced'), findsOneWidget);
    expect(find.text('Accurate'), findsOneWidget);
  });

  testWidgets('selecting a tier reports it', (tester) async {
    String? selected;
    await tester.pumpWidget(wrap(onSelected: (model) => selected = model));

    await tester.tap(find.text('Balanced'));
    expect(selected, 'small');
  });

  testWidgets('a non-preset default appears as an extra option with its raw name', (tester) async {
    await tester.pumpWidget(wrap(defaultModel: 'tiny.en', selectedModel: 'tiny.en'));

    expect(find.text('tiny.en (Default)'), findsOneWidget);
    final radioGroup = tester.widget<RadioGroup<String>>(find.byType(RadioGroup<String>));
    expect(radioGroup.groupValue, 'tiny.en');
  });
}
