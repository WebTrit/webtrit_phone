import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_pull/call_pull.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../helpers/helpers.dart';

class MockCallPullCubit extends MockCubit<List<DialogInfo>> implements CallPullCubit {}

class MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

DialogInfo buildDialog({required bool pullable, required String name, String id = 'dialog-1'}) {
  return DialogInfo(
    id: id,
    entityNumber: '555001',
    state: pullable ? DialogState.confirmed : DialogState.early,
    callId: 'call-$id',
    direction: DialogDirection.recipient,
    localTag: 'local',
    localNumber: '555001',
    localDisplayName: 'Me',
    remoteTag: 'remote',
    remoteNumber: '555002',
    remoteDisplayName: name,
    arrivalVersion: '1',
    arrivalTime: DateTime(2026),
  );
}

void main() {
  late MockCallPullCubit callPullCubit;
  late MockCallBloc callBloc;

  setUp(() {
    callPullCubit = MockCallPullCubit();
    callBloc = MockCallBloc();
    when(() => callBloc.state).thenReturn(const CallState());
  });

  /// The badge shakes itself forever, so a settled frame never arrives; the
  /// tests below hold it still the way the accessibility setting does.
  Future<void> pumpBadge(WidgetTester tester, List<DialogInfo> calls) async {
    when(() => callPullCubit.state).thenReturn(calls);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<CallPullCubit>.value(value: callPullCubit),
              BlocProvider<CallBloc>.value(value: callBloc),
            ],
            child: Scaffold(
              appBar: AppBar(actions: [CallPullBadge(pullableCallDialogs: calls)]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpDialog(WidgetTester tester, List<DialogInfo> calls) async {
    when(() => callPullCubit.state).thenReturn(calls);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PullableCallsDialog(callPullCubit: callPullCubit, callBloc: callBloc),
      ),
    );
  }

  testWidgets('the badge says whose call is waiting', (tester) async {
    final handle = tester.ensureSemantics();

    await pumpBadge(tester, [buildDialog(pullable: true, name: 'Anna')]);

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(callPullBadgeId),
      label: 'Take over the call with Anna',
      identifier: callPullBadgeId,
      isButton: true,
    );

    handle.dispose();
  });

  testWidgets('and how many there are when there is a choice', (tester) async {
    final handle = tester.ensureSemantics();

    await pumpBadge(tester, [
      buildDialog(pullable: true, name: 'Anna'),
      buildDialog(pullable: true, name: 'Bohdan', id: 'dialog-2'),
    ]);

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(callPullBadgeId),
      label: 'Take over one of 2 calls',
      identifier: callPullBadgeId,
      isButton: true,
    );

    handle.dispose();
  });

  testWidgets('a screen reader can open the list from it', (tester) async {
    final handle = tester.ensureSemantics();

    await pumpBadge(tester, [buildDialog(pullable: true, name: 'Anna')]);
    await tapViaSemantics(tester, find.bySemanticsIdentifier(callPullBadgeId));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.bySemanticsIdentifier(callPullDialogId), findsOneWidget);

    handle.dispose();
  });

  testWidgets('each call in the list is picked up by name', (tester) async {
    final handle = tester.ensureSemantics();

    await pumpDialog(tester, [
      buildDialog(pullable: true, name: 'Anna'),
      buildDialog(pullable: true, name: 'Bohdan', id: 'dialog-2'),
    ]);

    // The word on both buttons is the same, so the name is what tells them
    // apart; the second one is numbered the way the rows are counted.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(callPullPickupId),
      label: 'Pick up the call with Anna',
      identifier: callPullPickupId,
      isButton: true,
    );
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(numberedId(callPullPickupId, 1)),
      label: 'Pick up the call with Bohdan',
      identifier: numberedId(callPullPickupId, 1),
      isButton: true,
    );

    handle.dispose();
  });

  testWidgets('a call that is not up yet is named and out of use', (tester) async {
    final handle = tester.ensureSemantics();

    await pumpDialog(tester, [buildDialog(pullable: false, name: 'Anna')]);

    expect(
      tester.getSemantics(find.bySemanticsIdentifier(callPullPickupId)),
      isSemantics(
        label: 'Pick up the call with Anna',
        identifier: callPullPickupId,
        isButton: true,
        isEnabled: false,
        hasTapAction: false,
      ),
    );

    handle.dispose();
  });

  testWidgets('nothing on the badge or the list is left unnamed', (tester) async {
    final handle = tester.ensureSemantics();

    await pumpBadge(tester, [buildDialog(pullable: true, name: 'Anna')]);
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    await pumpDialog(tester, [buildDialog(pullable: true, name: 'Anna')]);
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
