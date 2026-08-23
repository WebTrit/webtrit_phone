import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/call_routing.dart';
import 'package:webtrit_phone/features/contacts/contacts.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../helpers/feature_access_factories.dart';

class MockContactsExternalTabBloc extends MockBloc<ContactsExternalTabEvent, ContactsExternalTabState>
    implements ContactsExternalTabBloc {}

class MockContactsLocalTabBloc extends MockBloc<ContactsLocalTabEvent, ContactsLocalTabState>
    implements ContactsLocalTabBloc {}

class MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class MockCallRoutingCubit extends MockCubit<CallRoutingState?> implements CallRoutingCubit {}

/// A person in the list, favourite or not.
///
/// [favoriteNumber] marks the SECOND number rather than the first, because a
/// favourite is a number and the list is of people: a contact whose favourite
/// is not their first number has to count the same as one whose is.
Contact buildListContact({required int id, required String name, bool favoriteNumber = false}) => Contact(
  id: id,
  sourceType: ContactSourceType.external,
  kind: ContactKind.visible,
  sourceId: 'user-$id',
  firstName: name,
  phones: [
    ContactPhone(id: id * 10, number: '100$id', label: 'ext', favorite: false),
    if (favoriteNumber) ContactPhone(id: id * 10 + 1, number: '200$id', label: 'mobile', favorite: true),
  ],
);

/// Everything a contacts list needs around it to draw real rows: the tab's
/// bloc, the call blocs its actions go through, the call controller, and the
/// configuration the rows read their available actions from.
class ContactsTabHarness {
  ContactsTabHarness() {
    when(() => callBloc.state).thenReturn(const CallState());
    when(() => callRoutingCubit.state).thenReturn(null);
  }

  final externalBloc = MockContactsExternalTabBloc();
  final localBloc = MockContactsLocalTabBloc();
  final callBloc = MockCallBloc();
  final callRoutingCubit = MockCallRoutingCubit();

  Widget _around(Widget tab) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Provider<FeatureAccess>.value(
        value: featureAccessFor(createMockSystemInfo()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CallBloc>.value(value: callBloc),
            BlocProvider<CallRoutingCubit>.value(value: callRoutingCubit),
          ],
          child: CallControllerScope(
            controller: CallController(callBloc: callBloc),
            child: PresenceViewParams(
              hybridPresenceSupport: false,
              blfViaSipSupport: false,
              presenceViaSipSupport: false,
              child: Scaffold(body: tab),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpExternal(
    WidgetTester tester, {
    required List<Contact> contacts,
    bool favoritesOnly = false,
    bool markFavorites = false,
    ContactsExternalTabStatus status = ContactsExternalTabStatus.success,
  }) async {
    whenListen(
      externalBloc,
      const Stream<ContactsExternalTabState>.empty(),
      initialState: ContactsExternalTabState(status: status, contacts: contacts),
    );

    await tester.pumpWidget(
      _around(
        BlocProvider<ContactsExternalTabBloc>.value(
          value: externalBloc,
          child: ContactsExternalTab(favoritesOnly: favoritesOnly, markFavorites: markFavorites),
        ),
      ),
    );
    await tester.pump();
  }

  Future<void> pumpLocal(
    WidgetTester tester, {
    required List<Contact> contacts,
    bool favoritesOnly = false,
    bool markFavorites = false,
    ContactsLocalTabStatus status = ContactsLocalTabStatus.success,
  }) async {
    whenListen(
      localBloc,
      const Stream<ContactsLocalTabState>.empty(),
      initialState: ContactsLocalTabState(status: status, contacts: contacts),
    );

    await tester.pumpWidget(
      _around(
        BlocProvider<ContactsLocalTabBloc>.value(
          value: localBloc,
          child: ContactsLocalTab(favoritesOnly: favoritesOnly, markFavorites: markFavorites),
        ),
      ),
    );
    await tester.pump();
  }
}
