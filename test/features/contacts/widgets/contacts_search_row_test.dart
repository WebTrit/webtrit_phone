import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/contacts/contacts.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';

class _RememberedSourceType implements ActiveContactSourceTypeRepository {
  ContactSourceType _value = ContactSourceType.external;

  @override
  ContactSourceType getActiveContactSourceType({ContactSourceType defaultValue = ContactSourceType.external}) => _value;

  @override
  Future<void> setActiveContactSourceType(ContactSourceType value) async => _value = value;

  @override
  Future<void> clear() async {}
}

void main() {
  Future<ContactsBloc> pumpRow(WidgetTester tester) async {
    final bloc = ContactsBloc(activeContactSourceTypeRepository: _RememberedSourceType());
    addTearDown(bloc.close);

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // The field draws its clear button through the search decoration the
        // theme supplies; without it there is no suffix to look at.
        theme: ThemeData(
          extensions: const [InputDecorations(search: InputDecoration(), keypad: InputDecoration())],
        ),
        home: BlocProvider.value(
          value: bloc,
          child: const Scaffold(body: ContactsSearchRow()),
        ),
      ),
    );

    return bloc;
  }

  group('the contacts search row', () {
    testWidgets('keeps the identifiers automation reaches it by', (tester) async {
      final handle = tester.ensureSemantics();

      await pumpRow(tester);

      expect(find.bySemanticsIdentifier(contactsSearchInputId), findsOneWidget);

      handle.dispose();
    });

    testWidgets('hands what is typed to the screen that owns the list', (tester) async {
      final bloc = await pumpRow(tester);

      await tester.enterText(find.byType(TextField), 'branch');
      // The bloc debounces, so give it the moment it waits for.
      await tester.pump(const Duration(milliseconds: 500));

      expect(bloc.state.search, 'branch');
    });

    testWidgets('names its round button on the node that presses it', (tester) async {
      // The name and the press have to be the same node. Split between two -
      // which is what an identifier put inside the tap target does - a screen
      // reader announces a nameless control and automation finds a name it
      // cannot activate, while a test that only looks the identifier up stays
      // green.
      final handle = tester.ensureSemantics();
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContactsRoundButton(
              buttonKey: const Key('round'),
              identifier: 'contactsRoundButtonProbe',
              label: 'Search contacts',
              icon: Icons.search,
              onTap: () => pressed = true,
            ),
          ),
        ),
      );

      final named = find.bySemanticsIdentifier('contactsRoundButtonProbe');
      expect(named, findsOneWidget);
      expect(tester.getSemantics(named), isSemantics(hasTapAction: true, isButton: true, label: 'Search contacts'));

      await tester.tap(named);
      expect(pressed, isTrue);

      handle.dispose();
    });

    testWidgets('asks the app bar for the height the screen reserves', (tester) async {
      await pumpRow(tester);

      // The bar is sized from this number while the body is inset by it; the
      // two drifting apart is how a list ends up under the search field.
      expect(tester.getSize(find.byType(ContactsSearchRow)).height, ContactsSearchRow.height);
    });
  });
}
