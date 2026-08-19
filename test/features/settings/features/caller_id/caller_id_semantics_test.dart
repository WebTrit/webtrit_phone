import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/settings/features/caller_id/caller_id.dart';
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

    // On its own the chooser announces the number it shows and nothing else -
    // the caption next to it is what says which number that is. Name, id and
    // the field itself have to be ONE node: a caption sitting on a node above
    // the field leaves the field nameless, which is what a screen reader
    // actually reads out.
    final chooser = tester.getSemantics(find.bySemanticsIdentifier(callerIdDefaultNumberId)).getSemanticsData();
    expect(chooser.label, contains('Number'));
    expect(chooser.identifier, callerIdDefaultNumberId);
    expect(chooser.flagsCollection.isTextField, isTrue, reason: 'the named node IS the chooser');

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
    expect(number.label, contains('Number to show for this dial code'));
    expect(number.identifier, callerIdMatchNumberId);
    expect(number.flagsCollection.isTextField, isTrue, reason: 'the named node IS the chooser');

    // The picker is a button; its name has to sit on the node that answers
    // the press, not on one above it.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(callerIdMatchPrefixId),
      identifier: callerIdMatchPrefixId,
    );
    final prefix = tester.getSemantics(find.bySemanticsIdentifier(callerIdMatchPrefixId)).getSemanticsData();
    expect(prefix.label, contains('Dial code to match'));

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

  testWidgets('the screen leaves no unnamed press target behind', (tester) async {
    final handle = tester.ensureSemantics();

    stub(matchers: matchers);
    await tester.pumpWidget(wrap());

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
