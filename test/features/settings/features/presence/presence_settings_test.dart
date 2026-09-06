import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presence_settings_harness.dart';

void main() {
  group('the explanation next to a presence option', () {
    testWidgets('offers a target big enough to hit', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);

      expect(find.byIcon(Icons.info_outline), findsNWidgets(4));
      for (var i = 0; i < 4; i++) {
        final size = tester.getSize(harness.infoButtonAt(i));
        expect(size.width, greaterThanOrEqualTo(kMinInteractiveDimension), reason: 'explanation $i');
        expect(size.height, greaterThanOrEqualTo(kMinInteractiveDimension), reason: 'explanation $i');
      }
    });

    testWidgets('opens on a press and stays until it is dismissed', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);

      await harness.pressExplanation(tester, 0);

      // Titled with the option it explains, so the four rows that carry the
      // same glyph cannot be confused.
      expect(find.widgetWithText(AlertDialog, 'Availability'), findsOneWidget);
      final explanation = find.textContaining('Represents general availability');
      expect(explanation, findsOneWidget);

      // A tooltip took itself away after ten seconds; an explanation has to be
      // readable at any pace.
      await tester.pump(const Duration(seconds: 30));
      expect(explanation, findsOneWidget);

      await tester.tap(find.widgetWithText(TextButton, 'Ok'));
      await tester.pumpAndSettle();
      expect(explanation, findsNothing);
    });

    testWidgets('says which option it belongs to', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);

      for (final option in {1: 'Note', 2: 'Activity', 3: 'Reject calls (DND)'}.entries) {
        await harness.pressExplanation(tester, option.key);
        expect(find.widgetWithText(AlertDialog, option.value), findsOneWidget, reason: option.value);
        await tester.tap(find.widgetWithText(TextButton, 'Ok'));
        await tester.pumpAndSettle();
      }
    });
  });

  group('the sheet that picks a status icon', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    testWidgets('shows the picker whole instead of cutting its controls off', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      await harness.openStatusIconPicker(tester);

      // The sheet used to lay the picker out taller than the box it is drawn
      // in and clip the difference, which took the row of controls along the
      // bottom of the picker off the screen.
      final picker = tester.getRect(find.byType(EmojiPicker));
      expect(picker.height, lessThanOrEqualTo(300));

      final searchButton = tester.getRect(find.byType(SearchButton));
      expect(picker.contains(searchButton.topLeft), isTrue);
      expect(picker.contains(searchButton.bottomRight - const Offset(1, 1)), isTrue);
    });

    testWidgets('does not offer a backspace that does nothing', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      await harness.openStatusIconPicker(tester);

      // The picker's backspace edits the text field it is attached to, and
      // this sheet has none to attach it to.
      expect(find.byType(BackspaceButton), findsNothing);
    });

    testWidgets('gives every category a target big enough to hit', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      await harness.openStatusIconPicker(tester);

      final tabs = find.byType(Tab);
      expect(tabs, findsNWidgets(9));
      for (var i = 0; i < 9; i++) {
        // The tab bar pads each tab from the outside, so what a finger has to
        // hit is the tab together with its padding.
        final size = tester.getSize(find.ancestor(of: tabs.at(i), matching: find.byType(InkWell)).first);
        expect(size.width, greaterThanOrEqualTo(kMinInteractiveDimension), reason: 'category $i');
        expect(size.height, greaterThanOrEqualTo(kMinInteractiveDimension), reason: 'category $i');
      }
    });

    testWidgets('hands the chosen emoji back to the status', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      await harness.openStatusIconPicker(tester);

      // The picker opens on the recently used ones, and nothing has been used
      // yet on a fresh install.
      await tester.tap(find.byType(Tab).at(1));
      await tester.pumpAndSettle();

      final cell = find.byType(EmojiCell).first;
      final emoji = tester.widget<EmojiCell>(cell).emoji.emoji;
      await tester.tap(cell);
      await tester.pumpAndSettle();

      expect(find.byType(EmojiPicker), findsNothing);
      expect(harness.settings.statusIcon, emoji);
    });
  });
}
