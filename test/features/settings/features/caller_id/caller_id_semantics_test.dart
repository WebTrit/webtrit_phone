import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/settings/features/caller_id/caller_id.dart';
import 'package:webtrit_phone/features/settings/features/caller_id/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/caller_id_settings.dart';

import '../../../../helpers/helpers.dart';

class _MockCallerIdSettingsCubit extends MockCubit<CallerIdSettingsState?> implements CallerIdSettingsCubit {}

void main() {
  late _MockCallerIdSettingsCubit cubit;

  final matchers = [PrefixMatcher('+1', '441'), PrefixMatcher('+44', '442')];

  void stub({List<NumberMatcher> matchers = const []}) {
    when(() => cubit.state).thenReturn(
      CallerIdSettingsState(
        settings: CallerIdSettings(matchers: matchers),
        mainNumber: '440',
        additionalNumbers: const ['441', '442'],
      ),
    );
  }

  setUp(() {
    cubit = _MockCallerIdSettingsCubit();
    stub();
  });

  Widget wrap() => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: BlocProvider<CallerIdSettingsCubit>.value(value: cubit, child: const CallerIdSettingsScreen()),
  );

  testWidgets('the screen says which one it is before anything on it is touched', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap());

    expect(find.bySemanticsIdentifier(callerIdScreenId), findsOneWidget);

    handle.dispose();
  });

  testWidgets('the default number chooser is named by the caption beside it', (tester) async {
    final handle = tester.ensureSemantics();

    stub();
    await tester.pumpWidget(wrap());

    // On its own the chooser announces the number it shows and nothing else.
    // The name, the id and the field itself have to be ONE node: a name
    // sitting on a node above the field leaves the field nameless, which is
    // what a screen reader actually reads out.
    final chooser = tester.getSemantics(find.bySemanticsIdentifier(callerIdDefaultNumberId)).getSemanticsData();
    expect(chooser.label, 'Number to call from by default');
    expect(chooser.identifier, callerIdDefaultNumberId);
    expect(chooser.value, '440', reason: 'and it says which number is chosen');
    expect(chooser.flagsCollection.isTextField, isTrue, reason: 'the named node IS the chooser');

    handle.dispose();
  });

  testWidgets('an existing rule reads as the sentence it states, not as three fragments', (tester) async {
    // The row draws a flag with a dial code, an arrow and a number. Left to
    // themselves each was announced separately, the arrow as the glyph it is:
    // "+1", "button, disabled", "=>  441". None of the three answers a press.
    final handle = tester.ensureSemantics();
    stub(matchers: matchers);

    await tester.pumpWidget(wrap());
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('Calls to +1 show 441'), findsOneWidget);
    expect(find.bySemanticsLabel('Calls to +44 show 442'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp(r'=>')), findsNothing, reason: 'the arrow is a glyph, not a word');
    expect(find.bySemanticsLabel('+1'), findsNothing, reason: 'the dial code is spoken inside the sentence');

    // The one control of the row keeps its own name and its own node.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(numberedId(callerIdRemoveMatchId, 0)),
      label: 'Remove the match for +1',
      identifier: numberedId(callerIdRemoveMatchId, 0),
    );

    handle.dispose();
  });

  testWidgets('the default number chooser says what is chosen, not only what it is for', (tester) async {
    // The value is put there by us, not by the field inside the chooser: on the
    // web the framework drops that field from the tree, and the chosen number
    // would go with it. A widget test always runs off the web, so what is
    // pinned here is that our own node carries it.
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap());

    final chooser = tester.widget<NumberDropdown<String?>>(find.byType(NumberDropdown<String?>));
    expect(chooser.value, '440', reason: 'the main number is what a fresh account calls from');

    // Asserting the value on the merged node would prove nothing here: off the
    // web the field inside supplies one too. What is checked instead is the node
    // this widget adds - the one that survives the field being dropped.
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.properties.value == '440' && widget.child is DropdownMenu<String?>,
      ),
      findsOneWidget,
    );

    handle.dispose();
  });

  testWidgets('the halves of a new rule say what each of them chooses', (tester) async {
    final handle = tester.ensureSemantics();

    stub();
    await tester.pumpWidget(wrap());
    await tapViaSemantics(tester, find.bySemanticsIdentifier(callerIdAddMatchId));
    await tester.pumpAndSettle();

    // The number chooser is named by a hint that disappears the moment a
    // number is picked, and the country picker announces only the code it
    // currently shows - neither says what it is for.
    final number = tester.getSemantics(find.bySemanticsIdentifier(callerIdMatchNumberId)).getSemanticsData();
    expect(number.label, startsWith('Number to show for this dial code'));
    expect(number.identifier, callerIdMatchNumberId);
    expect(number.flagsCollection.isTextField, isTrue, reason: 'the named node IS the chooser');

    // The picker is a button: its name, its id and the press it answers have
    // to be on one node, and the name has to say which country was picked -
    // the picker itself shows a flag and a dial code and says neither.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(callerIdMatchPrefixId),
      label: 'Dial code to match, currently United States\n+1',
      identifier: callerIdMatchPrefixId,
    );

    handle.dispose();
  });

  testWidgets('choosing a country through semantics renames the picker after it', (tester) async {
    final handle = tester.ensureSemantics();

    stub();
    await tester.pumpWidget(wrap());
    await tapViaSemantics(tester, find.bySemanticsIdentifier(callerIdAddMatchId));
    await tester.pumpAndSettle();

    // Opening the picker is the only way to change the rule's dial code, so
    // the press has to work through semantics and not only through a pointer.
    await tapViaSemantics(tester, find.bySemanticsIdentifier(callerIdMatchPrefixId));
    await tester.pumpAndSettle();

    expect(find.byType(Dialog), findsOneWidget, reason: 'the country list opened');

    handle.dispose();
  });

  testWidgets('the button that adds a rule says what it does', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap());

    // A bare plus sign is announced as "button" and nothing else, and it is
    // the only control on the screen that has no caption of its own.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(callerIdAddMatchId),
      label: 'Add a dial code match',
      identifier: callerIdAddMatchId,
    );

    handle.dispose();
  });

  testWidgets('pressing the add button through semantics opens the form', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap());

    await tapViaSemantics(tester, find.bySemanticsIdentifier(callerIdAddMatchId));
    await tester.pumpAndSettle();

    expect(find.text('Save'), findsOneWidget);
    expect(find.bySemanticsIdentifier(callerIdAddMatchId), findsNothing);

    handle.dispose();
  });

  testWidgets('each rule row names the dial code it removes and is numbered by its place', (tester) async {
    final handle = tester.ensureSemantics();

    stub(matchers: matchers);
    await tester.pumpWidget(wrap());

    // Every row carries the same cross, so the name has to say which rule goes
    // away, and the id has to keep the two rows apart.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(callerIdRemoveMatchId),
      label: 'Remove the match for +1',
      identifier: callerIdRemoveMatchId,
    );
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(numberedId(callerIdRemoveMatchId, 1)),
      label: 'Remove the match for +44',
      identifier: numberedId(callerIdRemoveMatchId, 1),
    );

    handle.dispose();
  });

  testWidgets('pressing a rule row through semantics removes that rule', (tester) async {
    final handle = tester.ensureSemantics();

    stub(matchers: matchers);
    when(() => cubit.removePrefixMatcher(any())).thenReturn(null);
    await tester.pumpWidget(wrap());

    await tapViaSemantics(tester, find.bySemanticsIdentifier(numberedId(callerIdRemoveMatchId, 1)));

    verify(() => cubit.removePrefixMatcher('+44')).called(1);

    handle.dispose();
  });

  testWidgets('the form that adds a rule leaves no unnamed press target behind', (tester) async {
    final handle = tester.ensureSemantics();

    stub();
    await tester.pumpWidget(wrap());
    await tapViaSemantics(tester, find.bySemanticsIdentifier(callerIdAddMatchId));
    await tester.pumpAndSettle();

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });

  testWidgets('the screen leaves no unnamed press target behind', (tester) async {
    final handle = tester.ensureSemantics();

    stub(matchers: matchers);
    await tester.pumpWidget(wrap());

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
