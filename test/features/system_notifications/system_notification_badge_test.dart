import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/system_notifications/system_notifications.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

import '../../helpers/helpers.dart';

class _MockCounterCubit extends MockCubit<int> implements SystemNotificationsCounterCubit {}

void main() {
  Widget buildTestable(SystemNotificationsCounterCubit cubit) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: BlocProvider<SystemNotificationsCounterCubit>.value(
          value: cubit,
          child: const SystemNotificationsBadge(),
        ),
      ),
    );
  }

  testWidgets('with unseen items the bell announces the count as part of its name', (tester) async {
    final handle = tester.ensureSemantics();

    final cubit = _MockCounterCubit();
    whenListen(cubit, const Stream<int>.empty(), initialState: 3);
    await tester.pumpWidget(buildTestable(cubit));

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(systemNotificationsBadgeId),
      label: 'Notifications, 3',
      identifier: systemNotificationsBadgeId,
      isButton: true,
    );

    handle.dispose();

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 20));
  });

  testWidgets('bell is announced as "Notifications" and is targetable by id', (tester) async {
    final handle = tester.ensureSemantics();

    final cubit = _MockCounterCubit();
    whenListen(cubit, const Stream<int>.empty(), initialState: 0);
    await tester.pumpWidget(buildTestable(cubit));

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(systemNotificationsBadgeId),
      label: 'Notifications',
      identifier: systemNotificationsBadgeId,
      isButton: true,
    );

    handle.dispose();

    // Let the widget's unseen-count polling loop notice the disposal and stop,
    // so no timer outlives the test.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 2));
  });
}
