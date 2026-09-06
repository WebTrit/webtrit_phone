import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/register_status/register_status.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/features/settings/settings.dart';
import 'package:webtrit_phone/features/settings/widgets/user_info_list_tile.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../helpers/helpers.dart';

class _MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState> implements SettingsBloc {}

class _MockMicrophoneStatusBloc extends MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>
    implements MicrophoneStatusBloc {}

class _MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {}

class _MockSessionStatusCubit extends MockCubit<SessionStatusState> implements SessionStatusCubit {}

class _MockRegisterStatusCubit extends MockCubit<RegisterStatus> implements RegisterStatusCubit {}

class _MockStackRouter extends Mock implements StackRouter {}

/// The screen keeps the ordinary back button of the app bar, which asks the
/// router whether there is anywhere to go back to.
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

  Widget wrap(Widget child) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: _presence(child)),
  );

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

  testWidgets('the pencil next to the account says what it edits', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(UserInfoListTile(info: info, onEditPressed: () {})));

    // The row shows a name, a number and a balance, so a bare pencil beside
    // them is announced as "button" with nothing to say what it changes.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(settingsUserInfoEditId),
      label: 'Edit account details',
      identifier: settingsUserInfoEditId,
    );

    handle.dispose();
  });

  testWidgets('pressing the pencil through semantics starts the edit', (tester) async {
    final handle = tester.ensureSemantics();

    var pressed = false;
    await tester.pumpWidget(wrap(UserInfoListTile(info: info, onEditPressed: () => pressed = true)));

    await tapViaSemantics(tester, find.bySemanticsIdentifier(settingsUserInfoEditId));

    expect(pressed, isTrue);

    handle.dispose();
  });

  testWidgets('the account row leaves no unnamed press target behind', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(UserInfoListTile(info: info, onEditPressed: () {})));

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });

  testWidgets('the account screen leaves no unnamed press target behind', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrapScreen());

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
