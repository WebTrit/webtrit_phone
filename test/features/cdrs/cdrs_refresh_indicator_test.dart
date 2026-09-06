import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/call_routing.dart';
import 'package:webtrit_phone/features/cdrs/cdrs.dart';
import 'package:webtrit_phone/features/cdrs/widgets/full_recent_cdrs_list.dart';
import 'package:webtrit_phone/features/cdrs/widgets/missed_recent_cdrs_list.dart';
import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';

class MockFullRecentCdrsCubit extends MockCubit<CdrsListState> implements FullRecentCdrsCubit {}

class MockMissedRecentCdrsCubit extends MockCubit<CdrsListState> implements MissedRecentCdrsCubit {}

class MockSessionStatusCubit extends MockCubit<SessionStatusState> implements SessionStatusCubit {}

class MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {}

class MockMicrophoneStatusBloc extends MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>
    implements MicrophoneStatusBloc {}

class MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class MockCallRoutingCubit extends MockCubit<CallRoutingState?> implements CallRoutingCubit {}

class MockContactsRepository extends Mock implements ContactsRepository {}

CdrRecord record(String id, {CdrStatus status = CdrStatus.accepted}) => CdrRecord(
  callId: id,
  direction: CallDirection.incoming,
  status: status,
  callee: '1000',
  calleeNumber: '1000',
  caller: '2000',
  callerNumber: '2000',
  connectTime: DateTime.utc(2026, 1, 1),
  disconnectTime: DateTime.utc(2026, 1, 1, 0, 0, 10),
  disconnectReason: 'normal',
  duration: const Duration(seconds: 10),
);

void main() {
  late MockFullRecentCdrsCubit fullCubit;
  late MockMissedRecentCdrsCubit missedCubit;
  late MockSessionStatusCubit sessionStatusCubit;
  late MockUserInfoCubit userInfoCubit;
  late MockMicrophoneStatusBloc microphoneStatusBloc;
  late MockCallBloc callBloc;
  late MockCallRoutingCubit callRoutingCubit;
  late MockContactsRepository contactsRepository;
  late CallController callController;

  setUp(() {
    fullCubit = MockFullRecentCdrsCubit();
    missedCubit = MockMissedRecentCdrsCubit();
    sessionStatusCubit = MockSessionStatusCubit();
    userInfoCubit = MockUserInfoCubit();
    microphoneStatusBloc = MockMicrophoneStatusBloc();
    callBloc = MockCallBloc();
    callRoutingCubit = MockCallRoutingCubit();
    contactsRepository = MockContactsRepository();
    callController = CallController(callBloc: callBloc);
    when(() => fullCubit.refresh()).thenAnswer((_) async {});
    when(() => missedCubit.refresh()).thenAnswer((_) async {});
    whenListen(fullCubit, const Stream<CdrsListState>.empty(), initialState: const CdrsListState(isLoading: false));
    whenListen(missedCubit, const Stream<CdrsListState>.empty(), initialState: const CdrsListState(isLoading: false));
    whenListen(sessionStatusCubit, const Stream<SessionStatusState>.empty(), initialState: const SessionStatusState());
    whenListen(userInfoCubit, const Stream<UserInfoState>.empty(), initialState: const UserInfoState());
    whenListen(
      microphoneStatusBloc,
      const Stream<MicrophoneStatusState>.empty(),
      initialState: const MicrophoneStatusState(),
    );
    whenListen(callBloc, const Stream<CallState>.empty(), initialState: const CallState());
    whenListen(callRoutingCubit, const Stream<CallRoutingState?>.empty(), initialState: null);
    when(() => contactsRepository.watchContactByPhoneNumber(any())).thenAnswer((_) => Stream.value(null));
  });

  Widget app() {
    return ThemeProvider(
      settings: const ThemeSettings(),
      lightDynamic: null,
      darkDynamic: null,
      child: MaterialApp(
        theme: ThemeData(platform: TargetPlatform.iOS),
        scrollBehavior: const MaterialScrollBehavior().copyWith(physics: const BouncingScrollPhysics()),
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RepositoryProvider<ContactsRepository>.value(
          value: contactsRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<FullRecentCdrsCubit>.value(value: fullCubit),
              BlocProvider<MissedRecentCdrsCubit>.value(value: missedCubit),
              BlocProvider<SessionStatusCubit>.value(value: sessionStatusCubit),
              BlocProvider<UserInfoCubit>.value(value: userInfoCubit),
              BlocProvider<MicrophoneStatusBloc>.value(value: microphoneStatusBloc),
              BlocProvider<CallBloc>.value(value: callBloc),
              BlocProvider<CallRoutingCubit>.value(value: callRoutingCubit),
            ],
            child: CallControllerScope(
              controller: callController,
              child: RecentCdrsScreen(
                transferEnabled: false,
                videoEnabled: false,
                chatsEnabled: false,
                smssEnabled: false,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Finder refreshProgress() =>
      find.descendant(of: find.byType(RefreshIndicator), matching: find.byType(RefreshProgressIndicator));

  testWidgets('pull invokes the current CDR cubit and waits for its result', (tester) async {
    final refresh = Completer<void>();
    when(() => fullCubit.refresh()).thenAnswer((_) => refresh.future);
    await tester.pumpWidget(app());

    final pull = tester.state<RefreshIndicatorState>(find.byType(RefreshIndicator)).show();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();

    verify(() => fullCubit.refresh()).called(1);
    expect(refreshProgress(), findsOneWidget);

    refresh.complete();
    await pull;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(refreshProgress(), findsNothing);
  });

  testWidgets('failed pull completes and reports the error', (tester) async {
    when(() => fullCubit.refresh()).thenAnswer((_) => Future<void>.error(StateError('offline')));
    await tester.pumpWidget(app());

    final pull = tester.state<RefreshIndicatorState>(find.byType(RefreshIndicator)).show();
    await tester.pump();
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await pull;

    verify(() => fullCubit.refresh()).called(1);
    expect(refreshProgress(), findsNothing);
    expect(find.text('Could not refresh call history - please try again'), findsOneWidget);
  });

  testWidgets('empty missed list can still be pulled', (tester) async {
    await tester.pumpWidget(app());
    await tester.tap(find.text('Missed'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.fling(find.byType(CustomScrollView), const Offset(0, 300), 1000);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    verify(() => missedCubit.refresh()).called(1);
  });

  testWidgets('iOS leading overscroll only runs the polling task on both populated tabs', (tester) async {
    when(() => fullCubit.fetchHistory()).thenAnswer((_) async {});
    when(() => missedCubit.fetchHistory()).thenAnswer((_) async {});
    whenListen(
      fullCubit,
      const Stream<CdrsListState>.empty(),
      initialState: CdrsListState(records: [record('full')], isLoading: false),
    );
    whenListen(
      missedCubit,
      const Stream<CdrsListState>.empty(),
      initialState: CdrsListState(records: [record('missed', status: CdrStatus.missed)], isLoading: false),
    );
    await tester.pumpWidget(app());

    final dynamic fullState = tester.state(find.byType(FullRecentCdrsList));
    final fullScrollController = fullState.scrollController as ScrollController;
    fullScrollController.jumpTo(-50);
    expect(fullScrollController.position.pixels, lessThan(0));
    verifyNever(() => fullCubit.fetchHistory());
    final fullPull = tester.state<RefreshIndicatorState>(find.byType(RefreshIndicator)).show();
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await fullPull;

    await tester.tap(find.text('Missed'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    final dynamic missedState = tester.state(find.byType(MissedRecentCdrsList));
    final missedScrollController = missedState.scrollController as ScrollController;
    missedScrollController.jumpTo(-50);
    expect(missedScrollController.position.pixels, lessThan(0));
    verifyNever(() => missedCubit.fetchHistory());
    final missedPull = tester.state<RefreshIndicatorState>(find.byType(RefreshIndicator)).show();
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await missedPull;

    verify(() => fullCubit.refresh()).called(1);
    verify(() => missedCubit.refresh()).called(1);
  });

  testWidgets('iOS trailing overscroll still requests older history', (tester) async {
    when(() => fullCubit.fetchHistory()).thenAnswer((_) async {});
    whenListen(
      fullCubit,
      const Stream<CdrsListState>.empty(),
      initialState: CdrsListState(records: [record('full')], isLoading: false),
    );
    await tester.pumpWidget(app());

    final dynamic fullState = tester.state(find.byType(FullRecentCdrsList));
    final scrollController = fullState.scrollController as ScrollController;
    scrollController.jumpTo(50);

    expect(scrollController.position.pixels, greaterThan(scrollController.position.minScrollExtent));
    verify(() => fullCubit.fetchHistory()).called(1);
    verifyNever(() => fullCubit.refresh());
  });
}
