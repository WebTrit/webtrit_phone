import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/contacts/contacts.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';

class _MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class _MockSessionStatusCubit extends MockCubit<SessionStatusState> implements SessionStatusCubit {}

class _MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {}

class _MockMicrophoneStatusBloc extends MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>
    implements MicrophoneStatusBloc {}

class _RememberedSourceType implements ActiveContactSourceTypeRepository {
  _RememberedSourceType(this._value);

  ContactSourceType _value;

  @override
  ContactSourceType getActiveContactSourceType({ContactSourceType defaultValue = ContactSourceType.external}) => _value;

  @override
  Future<void> setActiveContactSourceType(ContactSourceType value) async => _value = value;

  @override
  Future<void> clear() async {}
}

void main() {
  const local = ContactsSourceSelection(ContactSourceType.local);
  const external = ContactsSourceSelection(ContactSourceType.external);
  const favorites = ContactsFavoritesSelection();

  late _MockCallBloc callBloc;
  late _MockSessionStatusCubit sessionStatusCubit;
  late _MockUserInfoCubit userInfoCubit;
  late _MockMicrophoneStatusBloc microphoneStatusBloc;

  setUp(() {
    callBloc = _MockCallBloc();
    sessionStatusCubit = _MockSessionStatusCubit();
    when(() => callBloc.state).thenReturn(const CallState());
    when(() => sessionStatusCubit.state).thenReturn(const SessionStatusState());
    userInfoCubit = _MockUserInfoCubit();
    when(() => userInfoCubit.state).thenReturn(const UserInfoState());
    microphoneStatusBloc = _MockMicrophoneStatusBloc();
    when(() => microphoneStatusBloc.state).thenReturn(const MicrophoneStatusState());
  });

  Future<ContactsBloc> pumpScreen(
    WidgetTester tester, {
    required List<ContactsListSelection> selections,
    ContactSourceType remembered = ContactSourceType.external,
  }) async {
    final contactsBloc = ContactsBloc(activeContactSourceTypeRepository: _RememberedSourceType(remembered));
    addTearDown(contactsBloc.close);

    await tester.pumpWidget(
      ThemeProvider(
        settings: const ThemeSettings(),
        lightDynamic: null,
        darkDynamic: null,
        child: MaterialApp(
          // The box draws its cross through the search decoration the theme
          // supplies; without it there is no suffix to press.
          theme: ThemeData(
            extensions: const [InputDecorations(search: InputDecoration(), keypad: InputDecoration())],
          ),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ContactsBloc>.value(value: contactsBloc),
              BlocProvider<CallBloc>.value(value: callBloc),
              BlocProvider<SessionStatusCubit>.value(value: sessionStatusCubit),
              BlocProvider<UserInfoCubit>.value(value: userInfoCubit),
              BlocProvider<MicrophoneStatusBloc>.value(value: microphoneStatusBloc),
            ],
            child: ContactsFilterScreen(
              selections: selections,
              sourceTypeWidgetBuilder: (context, sourceType, {bool markFavorites = false}) => Text(sourceType.name),
              favoritesWidgetBuilder: (context) => const Text('favorites'),
            ),
          ),
        ),
      ),
    );
    // The bar keeps a status indicator animating, so this never settles.
    await tester.pump(const Duration(milliseconds: 400));

    return contactsBloc;
  }

  /// Opens the chooser and waits out its growth.
  ///
  /// Two pumps, not one: the first only starts the route's ticker, and a menu
  /// still at the start of its growth is collapsed - a press lands on nothing.
  /// Not `pumpAndSettle`, because the bar keeps an indicator animating and this
  /// screen never settles.
  Future<void> openChooser(WidgetTester tester) async {
    await tester.tap(find.byKey(contactsSourcePickerKey));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  Future<void> pick(WidgetTester tester, Finder entry) async {
    await openChooser(tester);
    await tester.tap(entry);
    await tester.pump(const Duration(milliseconds: 400));
  }

  group('the chooser', () {
    testWidgets('starts on the remembered address book', (tester) async {
      await pumpScreen(tester, selections: const [external, favorites]);

      expect(find.text('external'), findsOneWidget);
      expect(find.text('favorites'), findsNothing);
    });

    testWidgets('offers favourites as one more entry rather than a control of its own', (tester) async {
      // The question a person is answering is the same either way - which list
      // do I want - and two controls asking it invite the combination nobody
      // meant: the favourites of one address book, under a header naming it.
      await pumpScreen(tester, selections: const [local, external, favorites]);

      await openChooser(tester);

      expect(find.byKey(contactsSourceFavoritesKey), findsOneWidget);
    });

    testWidgets('shows the favourites section own list when that entry is picked', (tester) async {
      await pumpScreen(tester, selections: const [local, external, favorites]);

      await pick(tester, find.byKey(contactsSourceFavoritesKey));

      expect(find.text('favorites'), findsOneWidget);
      expect(find.text('external'), findsNothing);
    });

    testWidgets('and says so in the closed control', (tester) async {
      // The control is the only thing on screen that names the list, so a
      // header still reading Cloud PBX over a list of favourites is the whole
      // of what a person has to go on being wrong.
      await pumpScreen(tester, selections: const [local, external, favorites]);

      await pick(tester, find.byKey(contactsSourceFavoritesKey));

      expect(
        find.descendant(of: find.byKey(contactsSourcePickerKey), matching: find.text('Favorites')),
        findsOneWidget,
      );
    });

    testWidgets('takes the search control away with favourites', (tester) async {
      // That list has never been searchable anywhere in the app, and a box
      // that takes text and changes nothing is worse than no box.
      await pumpScreen(tester, selections: const [local, external, favorites]);

      expect(find.byKey(contactsSearchOpenKey), findsOneWidget);

      await pick(tester, find.byKey(contactsSourceFavoritesKey));

      expect(find.byKey(contactsSearchOpenKey), findsNothing);
      expect(find.byKey(contactsSearchInputKey), findsNothing);
      expect(find.byKey(contactsSourcePickerKey), findsOneWidget);
    });

    testWidgets('leaves the chooser where it was, rather than sliding it to the middle', (tester) async {
      // Losing the search control must not re-lay the line out: a control that
      // jumps from the left edge to the middle and back as the list changes
      // reads as a different screen each time.
      await pumpScreen(tester, selections: const [local, external, favorites]);
      final before = tester.getRect(find.byKey(contactsSourcePickerKey));

      await pick(tester, find.byKey(contactsSourceFavoritesKey));

      expect(tester.getRect(find.byKey(contactsSourcePickerKey)).left, before.left);
    });

    testWidgets('comes back to the address book that was left behind', (tester) async {
      // Picking favourites states no address book, so nothing may overwrite
      // the one a person had chosen.
      final bloc = await pumpScreen(
        tester,
        selections: const [local, external, favorites],
        remembered: ContactSourceType.local,
      );

      await pick(tester, find.byKey(contactsSourceFavoritesKey));
      expect(bloc.state.sourceType, ContactSourceType.local);

      await pick(tester, find.text('Your phone').last);

      expect(find.text('local'), findsOneWidget);
    });

    testWidgets('keeps both lists alive rather than building one from nothing on every pick', (tester) async {
      // Each list is watched by a bloc of its own. Swapped in and out, a pick
      // would tear one down and build the other from scratch - a spinner where
      // a list already stood, in both directions.
      await pumpScreen(tester, selections: const [local, external, favorites]);
      final book = find.text('external', skipOffstage: false);
      final favouritesList = find.text('favorites', skipOffstage: false);

      final bookElement = tester.element(book);

      await pick(tester, find.byKey(contactsSourceFavoritesKey));

      final favouritesElement = tester.element(favouritesList);
      expect(tester.element(book), same(bookElement), reason: 'the address book was torn down');

      await pick(tester, find.text('Cloud PBX').last);
      await pick(tester, find.byKey(contactsSourceFavoritesKey));

      expect(tester.element(favouritesList), same(favouritesElement), reason: 'the favourites list was torn down');
    });

    testWidgets('lives on the line under the title, not on the title row', (tester) async {
      // Which list is shown is about the list, so it belongs where the list's
      // own controls are - not beside the avatar.
      await pumpScreen(tester, selections: const [external, favorites]);

      final picker = find.byKey(contactsSourcePickerKey);

      expect(find.descendant(of: find.byType(ContactsSearchRow), matching: picker), findsOneWidget);
      expect(find.descendant(of: find.byType(NavigationToolbar), matching: picker), findsNothing);
    });

    testWidgets('takes no line of its own, so the list starts higher', (tester) async {
      await pumpScreen(tester, selections: const [external, favorites]);

      expect(find.byType(ContactsSearchRow), findsOneWidget);
      expect(find.byType(ExtTabBar), findsNothing);
    });
  });

  group('a deployment that turns favourites off in this section', () {
    testWidgets('never offers the entry', (tester) async {
      await pumpScreen(tester, selections: const [local, external]);

      await openChooser(tester);

      expect(find.byKey(contactsSourceFavoritesKey), findsNothing);
    });

    testWidgets('and keeps the search control, because an address book is all there is', (tester) async {
      await pumpScreen(tester, selections: const [local, external]);

      expect(find.byKey(contactsSearchOpenKey), findsOneWidget);
    });
  });

  group('the room the header takes', () {
    testWidgets('is what a row of tabs takes on every other screen', (tester) async {
      // A person moving between sections should see the list start in the
      // same place, not a header that grows and shrinks under them.
      await pumpScreen(tester, selections: const [external, favorites]);

      final bar = tester.getRect(find.byType(AppBar));
      final title = tester.getRect(find.byType(NavigationToolbar));

      expect(bar.bottom - title.bottom, kMainAppBarBottomTabHeight);
    });

    testWidgets('without the controls sitting against the title above them', (tester) async {
      // The height is kept by splitting the row's own gap, not by pressing
      // the controls into the row above - which is where the avatar is.
      await pumpScreen(tester, selections: const [external]);

      final title = tester.getRect(find.byType(NavigationToolbar));
      final search = tester.getRect(find.byKey(contactsSearchInputKey));

      expect(search.top - title.bottom, greaterThanOrEqualTo(kMainAppBarBottomPaddingGap / 2));
    });

    testWidgets('and keeps the chooser off the button beside it', (tester) async {
      // Two controls a hair apart read as one.
      await pumpScreen(tester, selections: const [local, external]);

      final picker = tester.getRect(find.byKey(contactsSourcePickerKey));
      final search = tester.getRect(find.byKey(contactsSearchOpenKey));

      expect(search.left - picker.right, greaterThanOrEqualTo(8));
    });
  });

  group('the chooser and the search box share the line', () {
    testWidgets('and the chooser is not drawn when there is only one list', (tester) async {
      // Either way round: a deployment can be configured without the phone
      // book, and one without extensions loses the other entry the same way.
      for (final only in ContactSourceType.values) {
        await pumpScreen(tester, selections: [ContactsSourceSelection(only)]);

        expect(find.byKey(contactsSourcePickerKey), findsNothing, reason: 'only: ${only.name}');
        // With nothing to pick, the line is the search box and stays that
        // way: no button to open what is already open, and no cross to close
        // it into an empty line.
        expect(find.byKey(contactsSearchInputKey), findsOneWidget, reason: 'only: ${only.name}');
        expect(find.byKey(contactsSearchOpenKey), findsNothing, reason: 'only: ${only.name}');
        expect(find.byKey(contactsSearchInputClearKey), findsNothing, reason: 'only: ${only.name}');
      }
    });

    testWidgets('but is drawn for one address book plus favourites, which are two lists', (tester) async {
      // The rule is about how many lists there are to pick between, not how
      // many address books.
      await pumpScreen(tester, selections: const [local, favorites]);

      expect(find.byKey(contactsSourcePickerKey), findsOneWidget);
      expect(find.byKey(contactsSearchOpenKey), findsOneWidget);
    });

    testWidgets('takes the line when there are two, with search on a button', (tester) async {
      await pumpScreen(tester, selections: const [local, external]);

      expect(find.byKey(contactsSourcePickerKey), findsOneWidget);
      expect(find.byKey(contactsSearchOpenKey), findsOneWidget);
      expect(find.byKey(contactsSearchInputKey), findsNothing);
    });

    testWidgets('gives the line to the search box once it is opened', (tester) async {
      await pumpScreen(tester, selections: const [local, external]);

      await tester.tap(find.byKey(contactsSearchOpenKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byKey(contactsSearchInputKey), findsOneWidget);
      expect(find.byKey(contactsSourcePickerKey), findsNothing);
    });

    testWidgets('and the cross in the box is the way back out of it', (tester) async {
      // One control does both: it empties a search, and on a box that is
      // already empty it puts the chooser back.
      final bloc = await pumpScreen(tester, selections: const [local, external]);

      await tester.tap(find.byKey(contactsSearchOpenKey));
      await tester.pump(const Duration(milliseconds: 400));
      await tester.enterText(find.byKey(contactsSearchInputKey), 'branch');
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.byKey(contactsSearchInputClearKey));
      await tester.pump(const Duration(milliseconds: 500));

      expect(bloc.state.search, isEmpty);
      expect(find.byKey(contactsSearchInputKey), findsOneWidget);

      await tester.tap(find.byKey(contactsSearchInputClearKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byKey(contactsSourcePickerKey), findsOneWidget);
      expect(find.byKey(contactsSearchInputKey), findsNothing);
    });
  });

  group('a tab left with favourites and no address book', () {
    // Reachable without anyone meaning it: a contacts tab configured for
    // extensions, on a core that does not carry them, loses its only source.
    testWidgets('shows the favourites and nothing else', (tester) async {
      await pumpScreen(tester, selections: const [favorites]);

      expect(find.text('favorites'), findsOneWidget);
      expect(find.text('local'), findsNothing);
      expect(find.text('external'), findsNothing);
    });

    testWidgets('and never names an address book it was not given', (tester) async {
      // Falling back to some address book here would watch a phone book nobody
      // asked for and never show it.
      await pumpScreen(tester, selections: const [favorites], remembered: ContactSourceType.external);

      expect(find.byKey(contactsSourcePickerKey), findsNothing);
      expect(find.text('favorites'), findsOneWidget);
    });
  });

  group('a remembered address book this deployment no longer offers', () {
    testWidgets('does not decide what the list shows', (tester) async {
      // The choice outlives a change of configuration, and it starts out as a
      // default nobody picked.
      await pumpScreen(tester, selections: const [local], remembered: ContactSourceType.external);

      expect(find.text('local'), findsOneWidget);
    });

    testWidgets('and never opens on favourites by accident', (tester) async {
      // Favourites hold only the people someone starred, so opening on them
      // when nothing was chosen would greet a new account with an empty screen.
      await pumpScreen(tester, selections: const [favorites, local], remembered: ContactSourceType.external);

      expect(find.text('local'), findsOneWidget);
      expect(find.text('favorites'), findsNothing);
    });
  });
}
