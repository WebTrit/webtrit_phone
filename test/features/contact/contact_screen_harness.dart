import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/call_routing.dart';
import 'package:webtrit_phone/features/contact/contact.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

class MockContactBloc extends MockBloc<ContactEvent, ContactState> implements ContactBloc {}

class MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {}

class MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class MockCallRoutingCubit extends MockCubit<CallRoutingState?> implements CallRoutingCubit {}

/// Builds a contact the way the screen receives it from the backend.
Contact buildContact({
  String number = '1001',
  String label = 'ext',
  List<ContactEmail> emails = const [],
  List<SipSubscription> sipSubscriptions = const [],
  ContactSourceType sourceType = ContactSourceType.external,
}) {
  return Contact(
    id: 1,
    sourceType: sourceType,
    kind: ContactKind.visible,
    sourceId: 'user-1',
    userRegistered: true,
    isCurrentUser: false,
    firstName: 'Anna',
    lastName: 'Marchenko',
    phones: [ContactPhone(id: 1, number: number, label: label, favorite: false)],
    emails: emails,
    sipSubscriptions: sipSubscriptions,
  );
}

/// Everything the contact card needs around it: the blocs it reads, the call
/// controller its actions go through and the presence flags that decide
/// whether the options section exists at all.
class ContactScreenHarness {
  ContactScreenHarness() {
    when(() => userInfoCubit.state).thenReturn(const UserInfoState());
    when(() => callBloc.state).thenReturn(const CallState());
    when(() => callRoutingCubit.state).thenReturn(null);
  }

  final contactBloc = MockContactBloc();
  final userInfoCubit = MockUserInfoCubit();
  final callBloc = MockCallBloc();
  final callRoutingCubit = MockCallRoutingCubit();

  /// Numbers the account itself can send an SMS from.
  void withUserSmsNumbers(List<String> numbers) {
    when(() => userInfoCubit.state).thenReturn(
      UserInfoState(
        userInfo: UserInfo(numbers: Numbers(sms: numbers)),
      ),
    );
  }

  Future<void> pump(
    WidgetTester tester, {
    required Contact contact,
    bool presenceViaSip = false,
    bool dialogsViaSip = false,
    bool enableTileSms = true,
    bool enableTileEmail = true,
  }) async {
    whenListen(contactBloc, const Stream<ContactState>.empty(), initialState: ContactState(contact: contact));

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ContactBloc>.value(value: contactBloc),
            BlocProvider<UserInfoCubit>.value(value: userInfoCubit),
            BlocProvider<CallBloc>.value(value: callBloc),
            BlocProvider<CallRoutingCubit>.value(value: callRoutingCubit),
          ],
          child: CallControllerScope(
            controller: CallController(callBloc: callBloc),
            child: PresenceViewParams(
              hybridPresenceSupport: presenceViaSip || dialogsViaSip,
              blfViaSipSupport: dialogsViaSip,
              presenceViaSipSupport: presenceViaSip,
              child: ContactScreen(
                enableAppBarChat: true,
                enableTileFavorite: true,
                enableTileVoiceCall: true,
                enableTileVideoCall: true,
                enableTileSms: enableTileSms,
                enableTileChat: true,
                enableTileTransfer: false,
                enableTileCallLog: true,
                enableTileEmail: enableTileEmail,
                useCdrsForHistory: false,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }
}
