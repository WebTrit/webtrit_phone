import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/settings/features/media_settings/widgets/inline_choosable_section.dart';

void main() {
  group('option ids', () {
    test('an option is identified by what it means, not by its position', () {
      expect(settingsOptionId(settingsLanguageOptionIdPrefix, 'uk'), 'settingsLanguageOptionUk');
      expect(settingsOptionId(settingsThemeModeOptionIdPrefix, 'dark'), 'settingsThemeModeOptionDark');
      expect(settingsOptionId(settingsLanguageOptionIdPrefix, 'system'), 'settingsLanguageOptionSystem');
    });
  });

  group('media settings toggle', () {
    Widget wrap({required String sectionId, String Function(bool?)? optionIdValue}) {
      return MaterialApp(
        home: Scaffold(
          body: InlineChoosableSection<bool>(
            title: 'Echo cancellation',
            sectionId: sectionId,
            optionIdValue: optionIdValue,
            options: const [true, false],
            selected: true,
            onSelect: (_) {},
            buildOptionTitle: (option) => Text(switch (option) {
              null => 'Auto',
              true => 'On',
              false => 'Off',
            }),
          ),
        ),
      );
    }

    testWidgets('each choice carries its own id next to the state the toggle already reports', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(wrap(sectionId: 'audioProcessingEc'));

      // The same choices repeat on every section of the screen, so the id has
      // to say which setting it belongs to. The active one is reported by the
      // toggle itself, and nothing here should say it a second time.
      for (final entry in {
        'mediaSettingsOptionAudioProcessingEcAuto': false,
        'mediaSettingsOptionAudioProcessingEcOn': true,
        'mediaSettingsOptionAudioProcessingEcOff': false,
      }.entries) {
        expect(
          tester.getSemantics(find.bySemanticsIdentifier(entry.key)),
          isSemantics(
            identifier: entry.key,
            hasCheckedState: true,
            isChecked: entry.value,
            isSelected: false,
            hasTapAction: true,
          ),
          reason: entry.key,
        );
      }

      handle.dispose();
    });

    testWidgets('a section that is not an on/off switch names its options for what they are', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        wrap(
          sectionId: 'encodingOpusChannels',
          optionIdValue: (option) => switch (option) {
            true => 'stereo',
            false => 'mono',
            _ => 'auto',
          },
        ),
      );

      expect(find.bySemanticsIdentifier('mediaSettingsOptionEncodingOpusChannelsStereo'), findsOneWidget);
      expect(find.bySemanticsIdentifier('mediaSettingsOptionEncodingOpusChannelsMono'), findsOneWidget);
      expect(find.bySemanticsIdentifier('mediaSettingsOptionEncodingOpusChannelsOn'), findsNothing);

      handle.dispose();
    });
  });
}
