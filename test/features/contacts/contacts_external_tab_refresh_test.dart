import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/contacts/contacts.dart';

import 'contacts_tab_harness.dart';

void main() {
  late ContactsTabHarness harness;

  setUp(() => harness = ContactsTabHarness());

  final contacts = [for (var id = 1; id <= 12; id++) buildListContact(id: id, name: 'Person $id')];

  testWidgets('pull-to-refresh delegates to the external contacts BLoC', (tester) async {
    await harness.pumpExternal(tester, contacts: contacts);

    await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
    await tester.pumpAndSettle();

    verify(() => harness.externalBloc.refresh()).called(1);
    expect(find.byType(RefreshProgressIndicator), findsNothing);
  });

  testWidgets('failed pull completes and shows the localized error', (tester) async {
    when(() => harness.externalBloc.refresh()).thenAnswer((_) async => false);
    await harness.pumpExternal(tester, contacts: contacts);

    await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
    await tester.pump();
    await tester.pumpAndSettle();

    verify(() => harness.externalBloc.refresh()).called(1);
    expect(find.byType(RefreshProgressIndicator), findsNothing);
    expect(find.text('Could not reach the server - please try again'), findsOneWidget);
  });

  testWidgets('empty-state refresh delegates to the same BLoC action', (tester) async {
    await harness.pumpExternal(tester, contacts: const [], status: ContactsExternalTabStatus.success);

    await tester.tap(find.text('Refresh'));
    await tester.pumpAndSettle();

    verify(() => harness.externalBloc.refresh()).called(1);
  });
}
