import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/login/login.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../../helpers/helpers.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockAppInfo extends Mock implements AppInfo {}

class _MockPackageInfo extends Mock implements PackageInfo {}

void main() {
  late NotificationsBloc notificationsBloc;
  late LoginCubit cubit;

  setUp(() {
    notificationsBloc = NotificationsBloc();

    final appInfo = _MockAppInfo();
    when(() => appInfo.version).thenReturn(Version.parse('1.0.0'));
    final packageInfo = _MockPackageInfo();
    when(() => packageInfo.version).thenReturn('1.0.0');
    when(() => packageInfo.buildNumber).thenReturn('1');

    cubit = LoginCubit(
      authRepository: _MockAuthRepository(),
      notificationsBloc: notificationsBloc,
      appInfo: appInfo,
      packageInfo: packageInfo,
      appCompatibilityResolver: const DefaultAppCompatibilityResolver(),
      onLoginSuccess: (_, _) {},
    );
  });

  tearDown(() {
    cubit.close();
    notificationsBloc.close();
  });

  Widget wrap(Widget child, {bool ownScaffold = false}) {
    final content = BlocProvider<LoginCubit>.value(value: cubit, child: child);

    return ThemeProvider(
      settings: const ThemeSettings(),
      lightDynamic: null,
      darkDynamic: null,
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ownScaffold ? content : Scaffold(body: content),
      ),
    );
  }

  group('password sign-in', () {
    testWidgets('the screen and its controls can be told apart by id', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(wrap(const LoginPasswordSigninScreen()));

      // Every login screen offers a button captioned "Proceed", so the screen
      // itself has to be identifiable before any control is touched.
      expect(find.bySemanticsIdentifier(loginPasswordScreenId), findsOneWidget);
      expect(find.bySemanticsIdentifier(passwordUserInputId), findsOneWidget);
      expect(find.bySemanticsIdentifier(passwordPasswordInputId), findsOneWidget);

      // The submit button is the flow's completion signal, so its id has to
      // survive both states: it is disabled until the form is filled in.
      expect(
        tester.getSemantics(find.bySemanticsIdentifier(passwordButtonId)),
        isSemantics(label: 'Proceed', identifier: passwordButtonId, hasTapAction: false),
      );

      await tester.enterText(find.byKey(passwordUserInputKey), '555001');
      await tester.enterText(find.byKey(passwordPasswordInputKey), 'test123');
      await tester.pump();

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(passwordButtonId),
        label: 'Proceed',
        identifier: passwordButtonId,
      );

      handle.dispose();
    });

    testWidgets('the visibility toggle says what it does and which way it is set', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(wrap(const LoginPasswordSigninScreen()));

      final toggle = find.bySemanticsIdentifier(passwordObscureToggleId);
      // The password starts hidden, so the button offers to show it.
      expectTapTargetSemantics(tester, toggle, label: 'Show password', identifier: passwordObscureToggleId);

      await tapViaSemantics(tester, toggle);
      await tester.pump();

      expect(cubit.state.passwordSigninPasswordInputObscureText, isFalse);
      expectTapTargetSemantics(tester, toggle, label: 'Hide password', identifier: passwordObscureToggleId);

      handle.dispose();
    });

    testWidgets('the submit button says it is busy instead of going nameless', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(wrap(const LoginPasswordSigninScreen()));
      cubit.emit(cubit.state.copyWith(processing: true));
      await tester.pump();

      // The spinner replaces the caption while the request is in flight; with
      // nothing said in its place the button is a node with no name at all,
      // and the wait has no observable end.
      expect(
        tester.getSemantics(find.bySemanticsIdentifier(passwordButtonId)),
        isSemantics(label: 'Loading', identifier: passwordButtonId),
      );

      handle.dispose();
    });

    testWidgets('the field keeps its own node so the toggle stays reachable', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(wrap(const LoginPasswordSigninScreen()));
      await tester.enterText(find.byKey(passwordPasswordInputKey), 'secret');
      await tester.pump();

      // Merging the field into one node would swallow the activation of the
      // toggle its decoration hosts: the two must stay separately reachable
      // while the field is in use.
      expect(cubit.state.passwordSigninPasswordInput.value, 'secret');
      expect(
        tester.getSemantics(find.bySemanticsIdentifier(passwordPasswordInputId)),
        isSemantics(identifier: passwordPasswordInputId),
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(passwordObscureToggleId),
        label: 'Show password',
        identifier: passwordObscureToggleId,
      );

      handle.dispose();
    });
  });

  group('login type switch', () {
    Widget switchScreen({List<LoginType> supported = const [LoginType.otpSignin, LoginType.passwordSignin]}) {
      return wrap(
        ownScaffold: true,
        LoginSwitchScreen(
          appBar: null,
          header: null,
          body: const SizedBox.shrink(),
          currentLoginType: LoginType.otpSignin,
          supportedLoginTypes: supported,
        ),
      );
    }

    testWidgets('a segment carries its id, its selected state and its action on one node', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(switchScreen());

      // The id is placed on the segment label, which the segmented button
      // merges into the node that also holds the selection and the tap.
      expect(
        tester.getSemantics(find.bySemanticsIdentifier(loginTypeSegmentOtpSigninId)),
        isSemantics(identifier: loginTypeSegmentOtpSigninId, isSelected: true, hasTapAction: true),
      );
      expect(
        tester.getSemantics(find.bySemanticsIdentifier(loginTypeSegmentPasswordSigninId)),
        isSemantics(identifier: loginTypeSegmentPasswordSigninId, isSelected: false, hasTapAction: true),
      );

      handle.dispose();
    });

    testWidgets('every login type the backend can offer carries its own id', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(switchScreen(supported: LoginType.values));

      // A backend that offers sign-up or QR gets those options too, and a flow
      // has to be able to tell them apart without reading their captions.
      for (final id in [
        loginTypeSegmentOtpSigninId,
        loginTypeSegmentPasswordSigninId,
        loginTypeSegmentSignupId,
        loginTypeSegmentQrSigninId,
      ]) {
        expect(
          tester.getSemantics(find.bySemanticsIdentifier(id)),
          isSemantics(identifier: id, hasTapAction: true),
          reason: id,
        );
      }

      handle.dispose();
    });
  });
}
