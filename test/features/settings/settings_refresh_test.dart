import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/register_status/register_status.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/features/settings/settings.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

class _MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState> implements SettingsBloc {}

class _MockMicrophoneStatusBloc extends MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>
    implements MicrophoneStatusBloc {}

class _MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {}

class _MockSessionStatusCubit extends MockCubit<SessionStatusState> implements SessionStatusCubit {}

class _MockRegisterStatusCubit extends MockCubit<RegisterStatus> implements RegisterStatusCubit {}

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

  setUp(() {
    settingsBloc = _MockSettingsBloc();
    microphoneStatusBloc = _MockMicrophoneStatusBloc();
    userInfoCubit = _MockUserInfoCubit();
    sessionStatusCubit = _MockSessionStatusCubit();
    registerStatusCubit = _MockRegisterStatusCubit();

    when(() => settingsBloc.state).thenReturn(const SettingsState(progress: false));
    when(() => microphoneStatusBloc.state).thenReturn(const MicrophoneStatusState());
    when(() => userInfoCubit.state).thenReturn(const UserInfoState(userInfo: info));
    when(() => sessionStatusCubit.state).thenReturn(const SessionStatusState());
    when(() => registerStatusCubit.state).thenReturn(const RegisterStatus(value: true));
    when(() => registerStatusCubit.fetchStatus()).thenAnswer((_) async => true);
  });

  Widget wrapScreen() {
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
              ],
              child: _presence(const SettingsScreen(sections: [], sessionsEnabled: false)),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pullDown(WidgetTester tester) async {
    await tester.fling(find.byType(ListView), const Offset(0, 400), 1000);
    await tester.pumpAndSettle();
  }

  testWidgets('pulling the account list down asks the server for the status again', (tester) async {
    await tester.pumpWidget(wrapScreen());

    await pullDown(tester);

    verify(() => registerStatusCubit.fetchStatus()).called(1);
  });

  testWidgets('the account screen has no refresh control left in its app bar', (tester) async {
    await tester.pumpWidget(wrapScreen());

    // The gesture replaced the button: an app bar action here would mean two
    // ways to do the same thing.
    expect(find.descendant(of: find.byType(AppBar), matching: find.byType(IconButton)), findsNothing);
  });

  testWidgets('a failed refresh explains itself', (tester) async {
    when(() => registerStatusCubit.fetchStatus()).thenAnswer((_) async => false);

    await tester.pumpWidget(wrapScreen());

    await pullDown(tester);

    expect(find.byType(SnackBar), findsOneWidget);
  });
}
