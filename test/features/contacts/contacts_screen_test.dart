import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/contacts/contacts.dart';
import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
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

/// The screen draws its list BEHIND the app bar and tells it where to start
/// with a figure of its own. Everything the body places by that figure moves
/// with it - the first row, and the refresh spinner - so a figure taken from
/// anywhere but the bar itself puts both in the wrong place.
void main() {
  late double? listTopInset;
  late double? listBottomInset;

  /// What the shell's floating tab bar takes at the bottom of the screen. The
  /// shell hands it down as MediaQuery padding, and a screen inside it has to
  /// let that figure through - a list that loses it runs its last row under
  /// the bar.
  const shellBottomInset = 80.0;

  late _MockCallBloc callBloc;
  late _MockSessionStatusCubit sessionStatusCubit;
  late _MockUserInfoCubit userInfoCubit;
  late _MockMicrophoneStatusBloc microphoneStatusBloc;

  setUp(() {
    listTopInset = null;
    listBottomInset = null;
    callBloc = _MockCallBloc();
    sessionStatusCubit = _MockSessionStatusCubit();
    when(() => callBloc.state).thenReturn(const CallState());
    when(() => sessionStatusCubit.state).thenReturn(const SessionStatusState());
    userInfoCubit = _MockUserInfoCubit();
    when(() => userInfoCubit.state).thenReturn(const UserInfoState());
    microphoneStatusBloc = _MockMicrophoneStatusBloc();
    when(() => microphoneStatusBloc.state).thenReturn(const MicrophoneStatusState());
  });

  Future<void> pumpScreen(WidgetTester tester, {required List<ContactSourceType> sourceTypes}) async {
    final contactsBloc = ContactsBloc(activeContactSourceTypeRepository: _RememberedSourceType(sourceTypes.first));
    addTearDown(contactsBloc.close);

    await tester.pumpWidget(
      ThemeProvider(
        settings: const ThemeSettings(),
        lightDynamic: null,
        darkDynamic: null,
        child: MaterialApp(
          theme: ThemeData(
            extensions: const [InputDecorations(search: InputDecoration(), keypad: InputDecoration())],
          ),
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context).copyWith(padding: const EdgeInsets.only(bottom: shellBottomInset)),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<ContactsBloc>.value(value: contactsBloc),
                  BlocProvider<CallBloc>.value(value: callBloc),
                  BlocProvider<SessionStatusCubit>.value(value: sessionStatusCubit),
                  BlocProvider<UserInfoCubit>.value(value: userInfoCubit),
                  BlocProvider<MicrophoneStatusBloc>.value(value: microphoneStatusBloc),
                ],
                child: ContactsScreen(
                  sourceTypes: sourceTypes,
                  // Read from a context BELOW the screen's own: this screen hands
                  // the builder its outer context, while a real tab is built
                  // inside the body and sees the inset the body was given.
                  sourceTypeWidgetBuilder: (context, sourceType) => Builder(
                    builder: (context) {
                      final inset = MediaQuery.of(context).padding;
                      listTopInset = inset.top;
                      listBottomInset = inset.bottom;
                      return Text(sourceType.name);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // The bar keeps a status indicator animating, so this never settles.
    await tester.pump(const Duration(milliseconds: 400));
  }

  testWidgets('the list keeps the room the shell reserves for its bar', (tester) async {
    // The bar at the bottom belongs to the shell around this screen and floats
    // over the page. Scaffold hands the body no bottom inset of its own once it
    // is given a bottomNavigationBar, so a screen that declares one loses the
    // shell's figure and runs its last row underneath the bar.
    await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

    expect(listBottomInset, shellBottomInset);
  });

  testWidgets('the list starts exactly where the bar ends, with one address book', (tester) async {
    await pumpScreen(tester, sourceTypes: [ContactSourceType.external]);

    expect(listTopInset, tester.getRect(find.byType(AppBar)).bottom);
  });

  testWidgets('the list starts exactly where the bar ends, with a row of tabs above it', (tester) async {
    // The taller bar is the case worth pinning: it is the one where the list
    // has the most room to start in the wrong place.
    await pumpScreen(tester, sourceTypes: [ContactSourceType.local, ContactSourceType.external]);

    expect(listTopInset, tester.getRect(find.byType(AppBar)).bottom);
  });
}
