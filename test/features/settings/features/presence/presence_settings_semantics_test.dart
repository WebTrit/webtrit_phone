import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/settings/features/presence/widgets/widgets.dart';

import '../../../../helpers/helpers.dart';
import 'presence_settings_harness.dart';

void main() {
  group('presence settings', () {
    testWidgets('the screen says which one it is', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      final handle = tester.ensureSemantics();

      expect(find.bySemanticsIdentifier(presenceSettingsScreenId), findsOneWidget);

      handle.dispose();
    });

    testWidgets('the preset control is named and opens through semantics', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      final handle = tester.ensureSemantics();

      final finder = find.bySemanticsIdentifier(presenceSettingsPresetId);
      // A menu of this kind answers "expand", not a press: that is what the
      // framework gives it, and the name and the id have to sit on the same
      // node as that action.
      expect(
        tester.getSemantics(finder),
        isSemantics(
          // The caption of the frame around the control is read out with it.
          label: 'Status preset\nCustom',
          identifier: presenceSettingsPresetId,
          hasExpandedState: true,
          isExpanded: false,
        ),
      );
      final node = tester.getSemantics(finder);
      expect(node.getSemanticsData().hasAction(SemanticsAction.expand), isTrue);

      node.owner!.performAction(node.id, SemanticsAction.expand);
      await tester.pumpAndSettle();
      expect(find.text('Do not disturb').hitTestable(), findsWidgets);

      handle.dispose();
    });

    testWidgets('the section of controls carries an id on the row that opens it', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      final handle = tester.ensureSemantics();

      final finder = find.bySemanticsIdentifier(presenceSettingsConfigSectionId);
      expectTapTargetSemantics(tester, finder, label: 'Configuration:', identifier: presenceSettingsConfigSectionId);

      await tapViaSemantics(tester, finder);
      await tester.pumpAndSettle();
      // The section folds its contents away rather than dropping them.
      expect(find.byType(SwitchListTile).hitTestable(), findsNothing);

      handle.dispose();
    });

    testWidgets('availability is one named switch that answers through semantics', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      final handle = tester.ensureSemantics();

      final finder = find.bySemanticsIdentifier(presenceSettingsAvailabilityId);
      expectTapTargetSemantics(tester, finder, label: 'Availability:', identifier: presenceSettingsAvailabilityId);
      // The same node also reports whether the status is available.
      expect(tester.getSemantics(finder), isSemantics(hasToggledState: true, isToggled: true));

      await tapViaSemantics(tester, finder);
      expect(harness.settings.available, isFalse);

      handle.dispose();
    });

    testWidgets('rejecting calls is one named switch that answers through semantics', (tester) async {
      // The switch is only offered while the status is unavailable.
      final harness = PresenceSettingsHarness(settings: statusOffThePresets(available: false));
      await harness.pump(tester);
      final handle = tester.ensureSemantics();

      final finder = find.bySemanticsIdentifier(presenceSettingsDndId);
      expectTapTargetSemantics(tester, finder, label: 'Reject calls (DND)', identifier: presenceSettingsDndId);
      expect(tester.getSemantics(finder), isSemantics(hasToggledState: true, isToggled: false));

      await tapViaSemantics(tester, finder);
      expect(harness.settings.dndMode, isTrue);

      handle.dispose();
    });

    testWidgets('the note keeps a node of its own to be found by', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      final handle = tester.ensureSemantics();

      final finder = find.bySemanticsIdentifier(presenceSettingsNoteId);
      expect(
        tester.getSemantics(finder),
        isSemantics(label: 'Note', identifier: presenceSettingsNoteId, isTextField: true, value: 'Working from home'),
      );

      handle.dispose();
    });

    testWidgets('the activity control is named and opens through semantics', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      final handle = tester.ensureSemantics();

      final finder = find.bySemanticsIdentifier(presenceSettingsActivityId);
      expect(
        tester.getSemantics(finder),
        isSemantics(
          // Named by the caption of its own frame, which is read out with it.
          label: 'Activity',
          value: 'None',
          identifier: presenceSettingsActivityId,
          hasExpandedState: true,
          isExpanded: false,
        ),
      );

      final node = tester.getSemantics(finder);
      node.owner!.performAction(node.id, SemanticsAction.expand);
      await tester.pumpAndSettle();
      expect(find.text('In a meeting').hitTestable(), findsWidgets);

      handle.dispose();
    });

    testWidgets('every explanation says which option it belongs to and opens through semantics', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      final handle = tester.ensureSemantics();

      for (final button in {
        presenceSettingsAvailabilityInfoId: 'What Availability means',
        presenceSettingsNoteInfoId: 'What Note means',
        presenceSettingsActivityInfoId: 'What Activity means',
        presenceSettingsDndInfoId: 'What Reject calls (DND) means',
      }.entries) {
        final finder = find.bySemanticsIdentifier(button.key);
        expectTapTargetSemantics(tester, finder, label: button.value, identifier: button.key, isButton: true);

        await tapViaSemantics(tester, finder);
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsOneWidget, reason: button.key);
        await tester.tap(find.widgetWithText(TextButton, 'Ok'));
        await tester.pumpAndSettle();
      }

      handle.dispose();
    });

    testWidgets('the status icon buttons are named and answer through semantics', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final harness = PresenceSettingsHarness(settings: statusOffThePresets(icon: '\u{1F600}'));
      await harness.pump(tester);
      final handle = tester.ensureSemantics();

      final pick = find.bySemanticsIdentifier(presenceSettingsStatusIconPickId);
      expectTapTargetSemantics(
        tester,
        pick,
        label: 'Choose a status icon',
        identifier: presenceSettingsStatusIconPickId,
        isButton: true,
      );

      final clear = find.bySemanticsIdentifier(presenceSettingsStatusIconClearId);
      expectTapTargetSemantics(
        tester,
        clear,
        label: 'Remove the status icon',
        identifier: presenceSettingsStatusIconClearId,
        isButton: true,
      );

      await tapViaSemantics(tester, pick);
      await tester.pumpAndSettle();
      expect(find.bySemanticsIdentifier(statusIconPickerId), findsOneWidget);
      Navigator.of(tester.element(find.byType(StatusIconPickerSheet))).pop();
      await tester.pumpAndSettle();

      await tapViaSemantics(tester, clear);
      expect(harness.settings.statusIcon, isNull);

      handle.dispose();
    });

    testWidgets('nothing on the screen is a control without a name', (tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      final handle = tester.ensureSemantics();

      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

      handle.dispose();
    });
  });

  group('the status icon picker', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    Future<PresenceSettingsHarness> openPicker(WidgetTester tester) async {
      final harness = PresenceSettingsHarness();
      await harness.pump(tester);
      await harness.openStatusIconPicker(tester);
      return harness;
    }

    testWidgets('the sheet says which one it is and every category is named', (tester) async {
      await openPicker(tester);
      final handle = tester.ensureSemantics();

      expect(find.bySemanticsIdentifier(statusIconPickerId), findsOneWidget);

      // In the order the picker lays them out.
      const categories = {
        Category.RECENT: 'Recently used',
        Category.SMILEYS: 'Smileys and people',
        Category.ANIMALS: 'Animals and nature',
        Category.FOODS: 'Food and drink',
        Category.TRAVEL: 'Travel and places',
        Category.ACTIVITIES: 'Activities',
        Category.OBJECTS: 'Objects',
        Category.SYMBOLS: 'Symbols',
        Category.FLAGS: 'Flags',
      };
      var index = 1;
      for (final category in categories.entries) {
        final identifier = categoryTabId(category.key);
        final finder = find.bySemanticsIdentifier(identifier);
        // The tab bar adds its own "Tab 3 of 9" to the name it is given.
        expectTapTargetSemantics(tester, finder, label: 'Tab $index of 9\n${category.value}', identifier: identifier);
        index++;
      }

      final flags = find.bySemanticsIdentifier(categoryTabId(Category.FLAGS));
      await tapViaSemantics(tester, flags);
      await tester.pumpAndSettle();
      expect(tester.getSemantics(flags), isSemantics(isSelected: true, identifier: categoryTabId(Category.FLAGS)));

      handle.dispose();
    });

    testWidgets('the search is named, opens and closes through semantics', (tester) async {
      await openPicker(tester);
      final handle = tester.ensureSemantics();

      final search = find.bySemanticsIdentifier(statusIconPickerSearchId);
      expectTapTargetSemantics(
        tester,
        search,
        label: 'Search icons',
        identifier: statusIconPickerSearchId,
        isButton: true,
      );

      await tapViaSemantics(tester, search);
      await tester.pumpAndSettle();

      final input = find.bySemanticsIdentifier(statusIconPickerSearchInputId);
      expect(tester.getSemantics(input), isSemantics(identifier: statusIconPickerSearchInputId, isTextField: true));

      final close = find.bySemanticsIdentifier(statusIconPickerSearchCloseId);
      expectTapTargetSemantics(
        tester,
        close,
        label: 'Stop searching icons',
        identifier: statusIconPickerSearchCloseId,
        isButton: true,
      );

      await tapViaSemantics(tester, close);
      await tester.pumpAndSettle();
      expect(find.bySemanticsIdentifier(statusIconPickerSearchInputId), findsNothing);
      expect(find.bySemanticsIdentifier(statusIconPickerSearchId), findsOneWidget);

      handle.dispose();
    });

    testWidgets('nothing in the sheet is a control without a name', (tester) async {
      await openPicker(tester);
      final handle = tester.ensureSemantics();

      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

      handle.dispose();
    });
  });
}
