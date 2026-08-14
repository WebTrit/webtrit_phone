import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/settings/features/diagnostic/bloc/network_tester_cubit.dart';
import 'package:webtrit_phone/features/settings/features/diagnostic/widgets/diagnostic_network_test_item.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class _MockNetworkTesterCubit extends MockCubit<NetworkTesterState> implements NetworkTesterCubit {}

void main() {
  late _MockNetworkTesterCubit cubit;

  setUp(() {
    cubit = _MockNetworkTesterCubit();
    when(() => cubit.state).thenReturn(const NetworkTesterState());
    when(() => cubit.refresh()).thenAnswer((_) async {});
  });

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider<NetworkTesterCubit>.value(
            value: cubit,
            child: DiagnosticNetworkTestItem(onTap: () {}),
          ),
        ),
      ),
    );
  }

  testWidgets('the refresh control is big enough to hit with a finger', (tester) async {
    await pump(tester);

    // The icon is 16 pixels across. Pinned to that, the thing to press was a
    // third of what a finger needs, so it took several attempts to hit.
    final size = tester.getSize(find.byType(IconButton));
    expect(size.width, greaterThanOrEqualTo(kMinInteractiveDimension));
    expect(size.height, greaterThanOrEqualTo(kMinInteractiveDimension));
  });

  testWidgets('pressing refresh runs the test again', (tester) async {
    await pump(tester);

    await tester.tap(find.byType(IconButton));
    await tester.pump();

    verify(() => cubit.refresh()).called(1);
  });

  testWidgets('the row keeps its height whether the check is running or done', (tester) async {
    when(() => cubit.state).thenReturn(const NetworkTesterState(gatheringStatus: IceGatheringStatus.gathering));
    await pump(tester);
    final whileChecking = tester.getSize(find.byType(ListTile)).height;

    when(() => cubit.state).thenReturn(const NetworkTesterState());
    await pump(tester);
    final whenDone = tester.getSize(find.byType(ListTile)).height;

    // The check swaps a spinner for a button; a slot that changes size makes
    // this row and the whole list below it jump on every re-test.
    expect(whenDone, whileChecking);
  });
}
