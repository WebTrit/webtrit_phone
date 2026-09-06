import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_pull/call_pull.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';

class MockCallPullCubit extends MockCubit<List<DialogInfo>> implements CallPullCubit {}

class MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

DialogInfo buildDialog({required bool pullable, String name = 'Anna'}) {
  return DialogInfo(
    id: 'dialog-1',
    entityNumber: '555001',
    // A call is only there to be picked up once it is actually up.
    state: pullable ? DialogState.confirmed : DialogState.early,
    callId: 'call-1',
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

  Future<void> pumpBadge(WidgetTester tester, {required bool animations}) async {
    when(() => callPullCubit.state).thenReturn([buildDialog(pullable: true)]);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: !animations),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<CallPullCubit>.value(value: callPullCubit),
              BlocProvider<CallBloc>.value(value: callBloc),
            ],
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  CallPullBadge(pullableCallDialogs: [buildDialog(pullable: true)]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Takes the badge off the screen and lets its waiting timer run out, so the
  /// test does not end with one pending.
  Future<void> disposeBadge(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 6));
  }

  Future<void> pumpDialog(WidgetTester tester, DialogInfo dialog) async {
    when(() => callPullCubit.state).thenReturn([dialog]);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PullableCallsDialog(callPullCubit: callPullCubit, callBloc: callBloc),
      ),
    );
  }

  testWidgets('the badge shakes to be noticed', (tester) async {
    await pumpBadge(tester, animations: true);

    expect(tester.hasRunningAnimations, isTrue);

    await disposeBadge(tester);
  });

  testWidgets('and sits still for someone who turned movement off', (tester) async {
    await pumpBadge(tester, animations: false);
    await tester.pump(const Duration(seconds: 6));

    expect(tester.hasRunningAnimations, isFalse);

    await disposeBadge(tester);
  });

  testWidgets('the badge is big enough to hit', (tester) async {
    await pumpBadge(tester, animations: false);

    expect(tester.getSize(find.byType(CallPullBadge)).height, greaterThanOrEqualTo(48));

    await disposeBadge(tester);
  });

  testWidgets('a call that is up can be picked up', (tester) async {
    final dialog = buildDialog(pullable: true);
    await pumpDialog(tester, dialog);

    expect(tester.widget<InkWell>(find.widgetWithText(InkWell, 'Pick up')).onTap, isNotNull);
    expect(tester.getSize(find.widgetWithText(InkWell, 'Pick up')).height, greaterThanOrEqualTo(48));
  });

  testWidgets('a call that is not up yet does not take the press', (tester) async {
    // It looked faded and still accepted a tap that did nothing at all.
    await pumpDialog(tester, buildDialog(pullable: false));

    expect(tester.widget<InkWell>(find.widgetWithText(InkWell, 'Pick up')).onTap, isNull);
  });
}
