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

  /// The status bar the hosted variant pretends to have. Any non-zero figure
  /// does; a spinner placed by the screen edge fails the same way at 20 as at
  /// 47, and a fixed one keeps the assertion readable.
  static const hostStatusBarHeight = 47.0;

  /// The tab as its screens actually host it: the body runs BEHIND a
  /// translucent app bar, and the only thing telling anything inside where the
  /// bar ends is the top padding the screen puts on the body. Both contacts
  /// screens build it this way - see `contacts_screen.dart` and
  /// `contacts_filter_screen.dart`.
  Widget _behindAppBar(Widget tab, double appBarHeight) {
    final appBar = AppBar(toolbarHeight: appBarHeight, title: const Text('contacts'));

    return Builder(
      builder: (context) {
        final screen = MediaQuery.of(context).copyWith(padding: const EdgeInsets.only(top: hostStatusBarHeight));

        return MediaQuery(
          data: screen,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: appBar,
            body: MediaQuery(
              data: screen.copyWith(
                padding: screen.padding.copyWith(top: screen.padding.top + appBar.preferredSize.height),
              ),
              child: tab,
            ),
          ),
        );
      },
    );
  }

  Widget _around(Widget tab, {double? behindAppBarOfHeight}) {
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
              directPresenceEnabled: false,
              dialogsOverSipEnabled: false,
              presenceOverSipEnabled: false,
              child: behindAppBarOfHeight == null ? Scaffold(body: tab) : _behindAppBar(tab, behindAppBarOfHeight),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpExternal(
    WidgetTester tester, {
    required List<Contact> contacts,
    bool markFavorites = false,
    ContactsExternalTabStatus status = ContactsExternalTabStatus.success,

    /// Non-null hosts the tab behind an app bar of this height, the way the
    /// real screens do. Null keeps the bare host the older tests expect.
    double? behindAppBarOfHeight,

    /// What the bloc emits after the pump. Empty by default; a test that
    /// triggers a refresh needs at least one state, because the tab awaits the
    /// next one before it lets the spinner go.
    Stream<ContactsExternalTabState>? states,
  }) async {
    final initialState = ContactsExternalTabState(status: status, contacts: contacts);

    whenListen(externalBloc, states ?? const Stream<ContactsExternalTabState>.empty(), initialState: initialState);

    await tester.pumpWidget(
      _around(
        BlocProvider<ContactsExternalTabBloc>.value(
          value: externalBloc,
          child: ContactsExternalTab(markFavorites: markFavorites),
        ),
        behindAppBarOfHeight: behindAppBarOfHeight,
      ),
    );
    await tester.pump();
  }

  Future<void> pumpLocal(
    WidgetTester tester, {
    required List<Contact> contacts,
    bool markFavorites = false,
    ContactsLocalTabStatus status = ContactsLocalTabStatus.success,

    /// Non-null hosts the tab behind an app bar of this height, the way the
    /// real screens do. Null keeps the bare host the older tests expect.
    double? behindAppBarOfHeight,

    /// What the bloc emits after the pump. Empty by default; a test that
    /// triggers a refresh needs at least one state, because the tab awaits the
    /// next one before it lets the spinner go.
    Stream<ContactsLocalTabState>? states,
  }) async {
    final initialState = ContactsLocalTabState(status: status, contacts: contacts);

    whenListen(localBloc, states ?? const Stream<ContactsLocalTabState>.empty(), initialState: initialState);

    await tester.pumpWidget(
      _around(
        BlocProvider<ContactsLocalTabBloc>.value(
          value: localBloc,
          child: ContactsLocalTab(markFavorites: markFavorites),
        ),
        behindAppBarOfHeight: behindAppBarOfHeight,
      ),
    );
    await tester.pump();
  }
}
