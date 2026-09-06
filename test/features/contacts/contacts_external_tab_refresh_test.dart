import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/contacts/contacts.dart';

import 'contacts_tab_harness.dart';

void main() {
  late ContactsTabHarness harness;

  setUp(() => harness = ContactsTabHarness());

  final contacts = [for (var id = 1; id <= 12; id++) buildListContact(id: id, name: 'Person $id')];

  testWidgets('pull-to-refresh delegates to the registered polling task', (tester) async {
    await harness.pumpExternal(tester, contacts: contacts);

    await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
    await tester.pumpAndSettle();

    verify(() => harness.externalSyncTask.runNow()).called(1);
    expect(find.byType(RefreshProgressIndicator), findsNothing);
  });

  testWidgets('failed pull completes and shows the localized error', (tester) async {
    when(() => harness.externalSyncTask.runNow())
        .thenAnswer((_) => Future<void>.error(StateError('task was unregistered')));
    await harness.pumpExternal(tester, contacts: contacts);

    await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
    await tester.pump();
    await tester.pumpAndSettle();

    verify(() => harness.externalSyncTask.runNow()).called(1);
    expect(find.byType(RefreshProgressIndicator), findsNothing);
    expect(find.text('Could not reach the server - please try again'), findsOneWidget);
  });

  testWidgets('empty-state refresh delegates to the same polling task', (tester) async {
    await harness.pumpExternal(tester, contacts: const [], status: ContactsExternalTabStatus.success);

    await tester.tap(find.text('Refresh'));
    await tester.pumpAndSettle();

    verify(() => harness.externalSyncTask.runNow()).called(1);
  });
}
