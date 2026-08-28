import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/call_routing.dart';
import 'package:webtrit_phone/features/favorites/favorites.dart';
import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';

class _MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState> implements FavoritesBloc {}

class _MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {}

class _MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class _MockCallRoutingCubit extends MockCubit<CallRoutingState?> implements CallRoutingCubit {}

class _MockSessionStatusCubit extends MockCubit<SessionStatusState> implements SessionStatusCubit {}

class _MockMicrophoneStatusBloc extends MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>
    implements MicrophoneStatusBloc {}

/// Favourites are watched from the database, so the list needs no prompting to
/// redraw. Pulling it is about the address book behind it, which otherwise only
/// arrives on the polling interval.
void main() {
  late _MockFavoritesBloc favoritesBloc;
  late _MockUserInfoCubit userInfoCubit;
  late _MockCallBloc callBloc;
  late _MockCallRoutingCubit callRoutingCubit;
  late _MockSessionStatusCubit sessionStatusCubit;
  late _MockMicrophoneStatusBloc microphoneStatusBloc;

  List<FavoriteWithContact> favorites(int count) => [
    for (var i = 0; i < count; i++)
      (
        favorite: Favorite(
          number: '10$i',
          sourceType: FavoriteSourceType.pbx,
          sourceId: '$i',
          label: 'work',
          position: i,
        ),
        contact: null,
      ),
  ];

  setUp(() {
    favoritesBloc = _MockFavoritesBloc();
    userInfoCubit = _MockUserInfoCubit();
    callBloc = _MockCallBloc();
    callRoutingCubit = _MockCallRoutingCubit();
    sessionStatusCubit = _MockSessionStatusCubit();
    microphoneStatusBloc = _MockMicrophoneStatusBloc();

    when(() => userInfoCubit.state).thenReturn(const UserInfoState());
    when(() => callBloc.state).thenReturn(const CallState());
    when(() => callRoutingCubit.state).thenReturn(null);
    when(() => sessionStatusCubit.state).thenReturn(const SessionStatusState());
    when(() => microphoneStatusBloc.state).thenReturn(const MicrophoneStatusState());
  });

  Future<void> pumpScreen(WidgetTester tester, {Stream<FavoritesState>? updates}) async {
    whenListen(
      favoritesBloc,
      updates ?? const Stream<FavoritesState>.empty(),
      initialState: FavoritesState(favorites: favorites(12)),
    );

    await tester.pumpWidget(
      ThemeProvider(
        settings: const ThemeSettings(),
        lightDynamic: null,
        darkDynamic: null,
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PresenceViewParams(
            hybridPresenceSupport: false,
            blfViaSipSupport: false,
            presenceViaSipSupport: false,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<FavoritesBloc>.value(value: favoritesBloc),
                BlocProvider<UserInfoCubit>.value(value: userInfoCubit),
                BlocProvider<CallBloc>.value(value: callBloc),
                BlocProvider<CallRoutingCubit>.value(value: callRoutingCubit),
                BlocProvider<SessionStatusCubit>.value(value: sessionStatusCubit),
                BlocProvider<MicrophoneStatusBloc>.value(value: microphoneStatusBloc),
              ],
              child: const FavoritesScreen(
                transferEnabled: false,
                videoEnabled: false,
                chatsEnabled: false,
                smssEnabled: false,
                cdrsEnabled: false,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 400));
  }

  Future<void> pullDown(WidgetTester tester) async {
    await tester.fling(find.byType(ReorderableListView), const Offset(0, 300), 1000);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  testWidgets('pulling the list asks the address book for a fresh copy', (tester) async {
    final updates = StreamController<FavoritesState>.broadcast();
    addTearDown(updates.close);

    await pumpScreen(tester, updates: updates.stream);
    await pullDown(tester);

    verify(() => favoritesBloc.add(const FavoritesRefreshed())).called(1);

    // Let the spinner go: the widget holds it until the bloc says the fetch is
    // done, which a mock will never say on its own.
    updates.add(FavoritesState(favorites: favorites(12)));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('the spinner is drawn below the app bar, not behind it', (tester) async {
    final updates = StreamController<FavoritesState>.broadcast();
    addTearDown(updates.close);

    await pumpScreen(tester, updates: updates.stream);
    await pullDown(tester);

    final spinner = find.byType(RefreshProgressIndicator);
    expect(spinner, findsOneWidget);
    expect(tester.getTopLeft(spinner).dy, greaterThanOrEqualTo(tester.getRect(find.byType(AppBar)).bottom));

    updates.add(FavoritesState(favorites: favorites(12)));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
  });
}
