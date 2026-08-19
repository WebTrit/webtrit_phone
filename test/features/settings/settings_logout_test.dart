import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/register_status/register_status.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/settings/settings.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../helpers/helpers.dart';

class _MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState> implements SettingsBloc {}

class _MockMicrophoneStatusBloc extends MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>
    implements MicrophoneStatusBloc {}

class _MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {}

class _MockSessionStatusCubit extends MockCubit<SessionStatusState> implements SessionStatusCubit {}

class _MockRegisterStatusCubit extends MockCubit<RegisterStatus> implements RegisterStatusCubit {}

class _MockSessionsCubit extends MockCubit<SessionsState> implements SessionsCubit {}

class _MockStackRouter extends Mock implements StackRouter {}

StackRouter _router() {
  final router = _MockStackRouter();
  when(
    () => router.canPop(
      ignoreChildRoutes: any(named: 'ignoreChildRoutes'),
      ignoreParentRoutes: any(named: 'ignoreParentRoutes'),
      ignorePagelessRoutes: any(named: 'ignorePagelessRoutes'),
    ),
  ).thenReturn(false);
  when(() => router.topPage).thenReturn(null);
  when(() => router.pagelessRoutesObserver).thenReturn(PagelessRoutesObserver());
  return router;
}

Widget _presence(Widget child) => PresenceViewParams(
  hybridPresenceSupport: false,
  blfViaSipSupport: false,
  presenceViaSipSupport: false,
  child: child,
);

void main() {
  const info = UserInfo(
    numbers: Numbers(main: '555002'),
    aliasName: 'User 555002',
  );

  late _MockSettingsBloc settingsBloc;
  late _MockMicrophoneStatusBloc microphoneStatusBloc;
  late _MockUserInfoCubit userInfoCubit;
  late _MockSessionStatusCubit sessionStatusCubit;
  late _MockRegisterStatusCubit registerStatusCubit;
  late _MockSessionsCubit sessionsCubit;

  setUp(() {
    settingsBloc = _MockSettingsBloc();
    microphoneStatusBloc = _MockMicrophoneStatusBloc();
    userInfoCubit = _MockUserInfoCubit();
    sessionStatusCubit = _MockSessionStatusCubit();
    registerStatusCubit = _MockRegisterStatusCubit();
    sessionsCubit = _MockSessionsCubit();

    when(() => settingsBloc.state).thenReturn(const SettingsState(progress: false));
    when(() => microphoneStatusBloc.state).thenReturn(const MicrophoneStatusState());
    when(() => userInfoCubit.state).thenReturn(const UserInfoState(userInfo: info));
    when(() => sessionStatusCubit.state).thenReturn(const SessionStatusState());
    when(() => registerStatusCubit.state).thenReturn(const RegisterStatus(value: true));
    when(() => registerStatusCubit.fetchStatus()).thenAnswer((_) async => true);
    when(() => sessionsCubit.state).thenReturn(SessionsState());
  });

  Widget wrapScreen({bool sessionsEnabled = false, int sessions = 0, SettingScreenStyle? style}) {
    when(() => sessionsCubit.state).thenReturn(
      SessionsState(
        sessions: [for (var i = 0; i < sessions; i++) ActiveSession(id: '$i', current: i == 0)],
      ),
    );

    final router = _router();
    return ThemeProvider(
      settings: const ThemeSettings(),
      lightDynamic: null,
      darkDynamic: null,
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RouterScope(
          controller: router,
          inheritableObserversBuilder: () => const [],
          stateHash: 0,
          navigatorObservers: const [],
          child: StackRouterScope(
            controller: router,
            stateHash: 0,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<SettingsBloc>.value(value: settingsBloc),
                BlocProvider<MicrophoneStatusBloc>.value(value: microphoneStatusBloc),
                BlocProvider<UserInfoCubit>.value(value: userInfoCubit),
                BlocProvider<SessionStatusCubit>.value(value: sessionStatusCubit),
                BlocProvider<RegisterStatusCubit>.value(value: registerStatusCubit),
                BlocProvider<SessionsCubit>.value(value: sessionsCubit),
              ],
              child: _presence(SettingsScreen(sections: const [], sessionsEnabled: sessionsEnabled, style: style)),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('the app bar offers logout by name', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrapScreen());

    // A bare door-with-an-arrow icon says nothing on its own, and this one
    // ends the session.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(settingsLogoutButtonId),
      label: 'Logout',
      identifier: settingsLogoutButtonId,
    );

    handle.dispose();
  });

  testWidgets('pressing logout through semantics asks before ending the session', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrapScreen());

    await tapViaSemantics(tester, find.bySemanticsIdentifier(settingsLogoutButtonId));
    await tester.pumpAndSettle();

    // Logging out is not undoable, so the icon opens the question instead of
    // ending the session on the spot.
    expect(find.byType(ConfirmDialog), findsOneWidget);
    verifyNever(() => settingsBloc.add(const SettingsLogouted()));

    handle.dispose();
  });

  testWidgets('confirming the question logs out', (tester) async {
    await tester.pumpWidget(wrapScreen());

    await tester.tap(find.byKey(settingsLogoutButtonKey));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(confirmDialogYesButtonKey));
    await tester.pumpAndSettle();

    verify(() => settingsBloc.add(const SettingsLogouted())).called(1);
  });

  testWidgets('logout refuses the press while the account is busy', (tester) async {
    // The busy overlay covers the list only; an action in the bar would stay
    // live on top of it and could tear the session down mid-request.
    when(() => settingsBloc.state).thenReturn(const SettingsState(progress: true));

    await tester.pumpWidget(wrapScreen());

    expect(tester.widget<IconButton>(find.byKey(settingsLogoutButtonKey)).onPressed, isNull);
  });

  testWidgets('the icon takes its colour from the bar, like every other action', (tester) async {
    // A colour of its own would ignore both the color scheme and whatever the
    // page config sets for this bar.
    await tester.pumpWidget(wrapScreen(style: const SettingScreenStyle(logoutIconColor: Color(0xFFAA0000))));

    final icon = tester.widget<Icon>(
      find.descendant(of: find.byKey(settingsLogoutButtonKey), matching: find.byType(Icon)),
    );

    expect(icon.color, isNull);
  });

  testWidgets('the list no longer carries a logout row', (tester) async {
    await tester.pumpWidget(wrapScreen());

    expect(find.descendant(of: find.byType(ListView), matching: find.byIcon(Icons.logout)), findsNothing);
  });

  testWidgets('the sessions row stays in the list and says how many there are', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrapScreen(sessionsEnabled: true, sessions: 3));

    expect(find.text('Sessions'), findsOneWidget);
    // The badge is silent by itself; the row speaks the count after its name.
    expect(tester.getSemantics(find.text('Sessions')).label, contains('3'));

    handle.dispose();
  });

  testWidgets('no sessions row when the backend cannot list them', (tester) async {
    await tester.pumpWidget(wrapScreen());

    expect(find.text('Sessions'), findsNothing);
  });
}
