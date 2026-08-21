import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/contacts/contacts.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
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
  late List<({ContactSourceType sourceType, bool favoritesOnly})> mounted;

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

  Future<void> pumpScreen(
    WidgetTester tester, {
    required List<ContactSourceType> sourceTypes,
    ContactSourceType remembered = ContactSourceType.external,
  }) async {
    await tester.pumpWidget(
      ThemeProvider(
        settings: const ThemeSettings(),
        lightDynamic: null,
        darkDynamic: null,
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ContactsBloc(activeContactSourceTypeRepository: _RememberedSourceType(remembered)),
              ),
              BlocProvider<CallBloc>.value(value: callBloc),
              BlocProvider<SessionStatusCubit>.value(value: sessionStatusCubit),
              BlocProvider<UserInfoCubit>.value(value: userInfoCubit),
              BlocProvider<MicrophoneStatusBloc>.value(value: microphoneStatusBloc),
            ],
            child: ContactsFilterScreen(
              sourceTypes: sourceTypes,
              sourceTypeWidgetBuilder: (context, sourceType, {bool favoritesOnly = false}) {
                mounted.add((sourceType: sourceType, favoritesOnly: favoritesOnly));
                return Text('${sourceType.name} ${favoritesOnly ? 'favorites' : 'all'}');
              },
            ),
          ),
        ),
      ),
    );
    // The bar keeps a status indicator animating, so this never settles.
    await tester.pump(const Duration(milliseconds: 400));
  }

  group('the filter control', () {
    testWidgets('starts on the whole address book', (tester) async {
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      expect(mounted.last.favoritesOnly, isFalse);
    });

    testWidgets('marks the chosen side with more than a colour', (tester) async {
      // The two sides are the same shape and differ only in their word, so
      // colour alone would leave them apart for nobody who cannot see it.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      final onAll = find.descendant(of: find.byKey(contactsFilterAllKey), matching: find.byIcon(Icons.check_rounded));
      final onFavorites = find.descendant(
        of: find.byKey(contactsFilterFavoritesKey),
        matching: find.byIcon(Icons.check_rounded),
      );

      expect(onAll, findsOneWidget);
      expect(onFavorites, findsNothing);

      await tester.tap(find.byKey(contactsFilterFavoritesKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(onFavorites, findsOneWidget);
      expect(onAll, findsNothing);
    });

    testWidgets('narrows the list to favourites when picked', (tester) async {
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      await tester.tap(find.byKey(contactsFilterFavoritesKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(mounted.last.favoritesOnly, isTrue);
    });

    testWidgets('keeps the same list rather than fetching it again', (tester) async {
      // The list is watched per address book; switching the control decides
      // how much of it is shown, so tearing it down would refetch and flash a
      // spinner on every tap.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);
      final listElement = tester.element(find.text('external all'));

      await tester.tap(find.byKey(contactsFilterFavoritesKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(tester.element(find.text('external favorites')), same(listElement));
    });
  });

  group('the address book picker', () {
    testWidgets('is not drawn when there is only one to pick from', (tester) async {
      await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

      expect(find.byKey(contactsSourcePickerKey), findsNothing);
    });

    testWidgets('is drawn beside the search box when there are two', (tester) async {
      await pumpScreen(tester, sourceTypes: [ContactSourceType.local, ContactSourceType.external]);

      expect(find.byKey(contactsSourcePickerKey), findsOneWidget);
      expect(find.byKey(contactsSearchInputKey), findsOneWidget);
    });

    testWidgets('offers every address book and says which one is showing', (tester) async {
      await pumpScreen(tester, sourceTypes: [ContactSourceType.local, ContactSourceType.external]);

      await tester.tap(find.byKey(contactsSourcePickerKey));
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('Your phone'), findsWidgets);
      expect(find.text('Cloud PBX'), findsWidgets);
    });
  });

  group('a remembered address book this deployment no longer offers', () {
    testWidgets('does not decide what the list shows', (tester) async {
      // The choice outlives a change of configuration, and it starts out as a
      // default nobody picked - so it can name an address book that is not on
      // offer here.
      await pumpScreen(tester, sourceTypes: [ContactSourceType.local], remembered: ContactSourceType.external);

      expect(mounted.last.sourceType, ContactSourceType.local);
    });
  });
}
