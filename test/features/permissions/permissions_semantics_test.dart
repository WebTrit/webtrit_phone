import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/permissions/permissions.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

import '../../helpers/helpers.dart';

class _MockPermissionsCubit extends MockCubit<PermissionsState> implements PermissionsCubit {}

void main() {
  late _MockPermissionsCubit cubit;

  setUp(() {
    cubit = _MockPermissionsCubit();
  });

  Widget wrap() {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<PermissionsCubit>.value(value: cubit, child: const PermissionsScreen()),
    );
  }

  testWidgets('the way forward is named while permissions can still be asked for', (tester) async {
    final handle = tester.ensureSemantics();

    when(() => cubit.state).thenReturn(const PermissionsState());

    await tester.pumpWidget(wrap());

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(permissionsInitButtonId),
      label: 'Continue',
      identifier: permissionsInitButtonId,
    );

    handle.dispose();
  });

  testWidgets('once the denial is permanent the settings button takes its place', (tester) async {
    final handle = tester.ensureSemantics();

    when(() => cubit.state).thenReturn(const PermissionsState(isPermanentlyDenied: true));

    await tester.pumpWidget(wrap());

    // The two buttons replace each other, so they carry different ids: a flow
    // waiting for the wrong one would wait forever on a screen that is stuck.
    expect(find.bySemanticsIdentifier(permissionsInitButtonId), findsNothing);
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(permissionsSettingsButtonId),
      label: 'Open app Settings',
      identifier: permissionsSettingsButtonId,
    );

    handle.dispose();
  });
}
