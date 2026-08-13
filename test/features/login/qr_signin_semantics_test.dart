import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/login/login.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

import '../../helpers/helpers.dart';

class _MockQrSigninCubit extends MockCubit<QrSigninState> implements QrSigninCubit {}

class _MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  group('camera permission view', () {
    testWidgets('the request button is named and targetable', (tester) async {
      final handle = tester.ensureSemantics();

      var requested = false;
      await tester.pumpWidget(
        wrap(
          QrSigninPermissionView(
            permanentlyDenied: false,
            onRequestPermission: () => requested = true,
            onOpenSettings: () {},
          ),
        ),
      );

      final button = find.bySemanticsIdentifier(loginQrAllowCameraButtonId);
      expectTapTargetSemantics(tester, button, label: 'Continue', identifier: loginQrAllowCameraButtonId);

      await tapViaSemantics(tester, button);
      expect(requested, isTrue);

      handle.dispose();
    });

    testWidgets('once the denial is permanent the settings button takes its place', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        wrap(QrSigninPermissionView(permanentlyDenied: true, onRequestPermission: () {}, onOpenSettings: () {})),
      );

      // The two buttons replace each other, so a flow must not wait for the
      // wrong one: they carry different ids on purpose.
      expect(find.bySemanticsIdentifier(loginQrAllowCameraButtonId), findsNothing);
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(loginQrOpenSettingsButtonId),
        label: 'Open settings',
        identifier: loginQrOpenSettingsButtonId,
      );

      handle.dispose();
    });
  });

  testWidgets('the tab says it is working while the camera permission is checked', (tester) async {
    final handle = tester.ensureSemantics();

    final qrCubit = _MockQrSigninCubit();
    when(() => qrCubit.state).thenReturn(const QrSigninState());
    final loginCubit = _MockLoginCubit();
    when(() => loginCubit.state).thenReturn(const LoginState());

    await tester.pumpWidget(
      wrap(
        MultiBlocProvider(
          providers: [
            BlocProvider<QrSigninCubit>.value(value: qrCubit),
            BlocProvider<LoginCubit>.value(value: loginCubit),
          ],
          child: const LoginQrSigninScreen(),
        ),
      ),
    );

    // This state used to render an empty box: no anchor for a flow and nothing
    // for a screen reader to land on.
    expect(find.bySemanticsIdentifier(loginQrScreenId), findsOneWidget);
    expect(find.bySemanticsLabel('Loading'), findsWidgets);

    handle.dispose();
  });
}
