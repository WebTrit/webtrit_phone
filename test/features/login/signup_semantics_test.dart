import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_api/webtrit_api.dart';

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

  Widget wrap(Widget child) {
    return ThemeProvider(
      settings: const ThemeSettings(),
      lightDynamic: null,
      darkDynamic: null,
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider<LoginCubit>.value(value: cubit, child: child),
        ),
      ),
    );
  }

  testWidgets('the sign-up screen and its controls can be told apart by id', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(const LoginSignupRequestScreen()));

    expect(find.bySemanticsIdentifier(loginSignupRequestScreenId), findsOneWidget);
    expect(find.bySemanticsIdentifier(signupEmailInputId), findsOneWidget);
    // Disabled until the form is filled in, and findable either way.
    expect(
      tester.getSemantics(find.bySemanticsIdentifier(signupEmailButtonId)),
      isSemantics(label: 'Proceed', identifier: signupEmailButtonId, hasTapAction: false),
    );

    await tester.enterText(find.byKey(signupEmailInputKey), 'someone@example.test');
    await tester.pump();

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(signupEmailButtonId),
      label: 'Proceed',
      identifier: signupEmailButtonId,
    );

    handle.dispose();
  });

  testWidgets('the code screen is told apart from the other one that says "Verify"', (tester) async {
    final handle = tester.ensureSemantics();

    // The sign-up and the OTP code screens share both their button caption and
    // their field label, so only the anchor tells them apart.
    cubit.emit(
      cubit.state.copyWith(
        signupSessionOtpProvisionalWithDateTime: (const SessionOtpProvisional(otpId: 'otp-1'), DateTime.now()),
      ),
    );
    await tester.pumpWidget(wrap(const LoginSignupVerifyScreen(bodySafeAreaSides: {})));

    expect(find.bySemanticsIdentifier(loginSignupVerifyScreenId), findsOneWidget);
    expect(find.bySemanticsIdentifier(signupVerifyInputId), findsOneWidget);
    expect(
      tester.getSemantics(find.bySemanticsIdentifier(signupVerifyButtonId)),
      isSemantics(identifier: signupVerifyButtonId, hasTapAction: false),
    );
    // Resend counts down first, so it starts out disabled - and still findable.
    expect(
      tester.getSemantics(find.bySemanticsIdentifier(signupVerifyResendButtonId)),
      isSemantics(identifier: signupVerifyResendButtonId, hasTapAction: false),
    );

    handle.dispose();
  });
}
