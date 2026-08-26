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
  late List<String> mounted;

  late _MockCallBloc callBloc;
  late _MockSessionStatusCubit sessionStatusCubit;
  late _MockUserInfoCubit userInfoCubit;
  late _MockMicrophoneStatusBloc microphoneStatusBloc;

  setUp(() {
    mounted = [];
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
    required List<ContactSourceType> sourceTypes,
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
              sourceTypes: sourceTypes,
              sourceTypeWidgetBuilder: (context, sourceType, {bool markFavorites = false}) {
                mounted.add(sourceType.name);
                return Text(sourceType.name);
              },
              favoritesWidgetBuilder: (context) {
                mounted.add('favorites');
                return const Text('favorites');
              },
            ),
          ),
        ),
      ),
    );
    // The bar keeps a status indicator animating, so this never settles.
    await tester.pump(const Duration(milliseconds: 400));

    return contactsBloc;
  }

  group('the filter control', () {
    testWidgets('starts on the whole address book', (tester) async {
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      expect(mounted.last, 'external');
    });

    testWidgets('is a star that says whether it is on, and not by colour alone', (tester) async {
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      final button = find.byKey(contactsFilterFavoritesKey);
      expect(find.descendant(of: button, matching: find.byIcon(Icons.star_border)), findsOneWidget);

      await tester.tap(button);
      await tester.pump(const Duration(milliseconds: 400));

      // Filled rather than outlined: the shape changes, not only the colour.
      expect(find.descendant(of: button, matching: find.byIcon(Icons.star)), findsOneWidget);
      expect(find.descendant(of: button, matching: find.byIcon(Icons.star_border)), findsNothing);
    });

    testWidgets('leaves the chooser where it was, rather than sliding it to the middle', (tester) async {
      // Taking the search control away must not re-lay the line out: a control
      // that jumps from the left edge to the middle and back as the list
      // changes reads as a different screen each time.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.local, ContactSourceType.external]);
      final before = tester.getRect(find.byKey(contactsSourcePickerKey));

      await tester.tap(find.byKey(contactsFilterFavoritesKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(tester.getRect(find.byKey(contactsSourcePickerKey)).left, before.left);
    });

    testWidgets('takes no line of its own, so the list starts higher', (tester) async {
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      // One line under the title, and no strip of its own for the filter.
      expect(find.byType(ContactsSearchRow), findsOneWidget);
      expect(find.byType(ExtTabBar), findsNothing);
    });

    testWidgets('sits with the controls of the screen, not with the list', (tester) async {
      // What the filter narrows is the whole screen, and the line under the
      // title is about the list: which address book it draws and how it is
      // searched. Put there, the filter reads as one more of those.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      final filter = find.byKey(contactsFilterFavoritesKey);

      expect(find.descendant(of: find.byType(NavigationToolbar), matching: filter), findsOneWidget);
      expect(find.descendant(of: find.byType(ContactsSearchRow), matching: filter), findsNothing);
    });

    testWidgets('says it is on to a screen reader as well', (tester) async {
      // The colour and the fill are the whole of it on screen, and neither
      // reaches someone listening to the screen.
      final handle = tester.ensureSemantics();
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      final filter = find.byKey(contactsFilterFavoritesKey);
      expect(tester.getSemantics(filter), isSemantics(isSelected: false, isButton: true));

      await tester.tap(filter);
      await tester.pump(const Duration(milliseconds: 400));

      expect(tester.getSemantics(filter), isSemantics(isSelected: true, isButton: true));
      handle.dispose();
    });

    testWidgets('shows the favourites section own list when picked', (tester) async {
      // Not this screen's list narrowed down: the favourites a person keeps
      // are one list, kept in one place, and deriving them again from the
      // contacts table is how two answers to one question drift apart.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      await tester.tap(find.byKey(contactsFilterFavoritesKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(mounted.last, 'favorites');
    });

    testWidgets('and takes the search control away with it', (tester) async {
      // That list has never been searchable anywhere in the app, and a box
      // that takes text and changes nothing is worse than no box.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.local, ContactSourceType.external]);

      expect(find.byKey(contactsSearchOpenKey), findsOneWidget);

      await tester.tap(find.byKey(contactsFilterFavoritesKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byKey(contactsSearchOpenKey), findsNothing);
      expect(find.byKey(contactsSearchInputKey), findsNothing);
      expect(find.byKey(contactsSourcePickerKey), findsOneWidget);
    });
  });

  group('the room the header takes', () {
    testWidgets('is what a row of tabs takes on every other screen', (tester) async {
      // A person moving between sections should see the list start in the
      // same place, not a header that grows and shrinks under them - and the
      // saving this screen makes comes from dropping a row, not from
      // squeezing the one it keeps.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      final bar = tester.getRect(find.byType(AppBar));
      final title = tester.getRect(find.byType(NavigationToolbar));

      expect(bar.bottom - title.bottom, kMainAppBarBottomTabHeight);
    });

    testWidgets('without the controls sitting against the title above them', (tester) async {
      // The height is kept by splitting the row's own gap, not by pressing
      // the controls into the row above - which is where the avatar is.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      final title = tester.getRect(find.byType(NavigationToolbar));
      final search = tester.getRect(find.byKey(contactsSearchInputKey));

      expect(search.top - title.bottom, greaterThanOrEqualTo(kMainAppBarBottomPaddingGap / 2));
    });

    testWidgets('and keeps the chooser off the button beside it', (tester) async {
      // Two controls a hair apart read as one.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.local, ContactSourceType.external]);

      final picker = tester.getRect(find.byKey(contactsSourcePickerKey));
      final search = tester.getRect(find.byKey(contactsSearchOpenKey));

      expect(search.left - picker.right, greaterThanOrEqualTo(8));
    });
  });

  group('the address book picker', () {
    testWidgets('is not drawn when there is only one to pick from', (tester) async {
      // Either way round: a deployment can be configured without the phone
      // book, and one without extensions loses the other entry the same way.
      for (final only in ContactSourceType.values) {
        await pumpScreen(tester, sourceTypes: [only]);

        expect(find.byKey(contactsSourcePickerKey), findsNothing, reason: 'only: ${only.name}');
        // With nothing to pick, the line is the search box and stays that
        // way: no button to open what is already open, and no cross to close
        // it into an empty line.
        expect(find.byKey(contactsSearchInputKey), findsOneWidget, reason: 'only: ${only.name}');
        expect(find.byKey(contactsSearchOpenKey), findsNothing, reason: 'only: ${only.name}');
        expect(find.byKey(contactsSearchInputClearKey), findsNothing, reason: 'only: ${only.name}');
      }
    });

    testWidgets('takes the line when there are two, with search on a button', (tester) async {
      await pumpScreen(tester, sourceTypes: [ContactSourceType.local, ContactSourceType.external]);

      expect(find.byKey(contactsSourcePickerKey), findsOneWidget);
      expect(find.byKey(contactsSearchOpenKey), findsOneWidget);
      expect(find.byKey(contactsSearchInputKey), findsNothing);
    });

    testWidgets('gives the line to the search box once it is opened', (tester) async {
      await pumpScreen(tester, sourceTypes: [ContactSourceType.local, ContactSourceType.external]);

      await tester.tap(find.byKey(contactsSearchOpenKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byKey(contactsSearchInputKey), findsOneWidget);
      expect(find.byKey(contactsSourcePickerKey), findsNothing);
    });

    testWidgets('and the cross in the box is the way back out of it', (tester) async {
      // One control does both: it empties a search, and on a box that is
      // already empty it puts the chooser back.
      final bloc = await pumpScreen(tester, sourceTypes: [ContactSourceType.local, ContactSourceType.external]);

      await tester.tap(find.byKey(contactsSearchOpenKey));
      await tester.pump(const Duration(milliseconds: 400));
      await tester.enterText(find.byKey(contactsSearchInputKey), 'branch');
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.byKey(contactsSearchInputClearKey));
      await tester.pump(const Duration(milliseconds: 500));

      // First press empties it and leaves it open.
      expect(bloc.state.search, isEmpty);
      expect(find.byKey(contactsSearchInputKey), findsOneWidget);

      await tester.tap(find.byKey(contactsSearchInputClearKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.byKey(contactsSourcePickerKey), findsOneWidget);
      expect(find.byKey(contactsSearchInputKey), findsNothing);
    });
  });

  group('a remembered address book this deployment no longer offers', () {
    testWidgets('does not decide what the list shows', (tester) async {
      // The choice outlives a change of configuration, and it starts out as a
      // default nobody picked - so it can name an address book that is not on
      // offer here.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.local], remembered: ContactSourceType.external);

      expect(mounted.last, 'local');
    });
  });
}
