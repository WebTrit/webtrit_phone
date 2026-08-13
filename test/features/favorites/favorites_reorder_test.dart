import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/call_routing.dart';
import 'package:webtrit_phone/features/favorites/favorites.dart';
import 'package:webtrit_phone/features/microphone_status/microphone_status.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../../helpers/helpers.dart';

class _MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState> implements FavoritesBloc {}

class _MockUserInfoCubit extends MockCubit<UserInfoState> implements UserInfoCubit {}

class _MockCallBloc extends MockBloc<CallEvent, CallState> implements CallBloc {}

class _MockCallRoutingCubit extends MockCubit<CallRoutingState?> implements CallRoutingCubit {}

class _MockSessionStatusCubit extends MockCubit<SessionStatusState> implements SessionStatusCubit {}

class _MockMicrophoneStatusBloc extends MockBloc<MicrophoneStatusEvent, MicrophoneStatusState>
    implements MicrophoneStatusBloc {}

/// Room the app shell takes at the bottom of every tab page: its tab bar plus
/// the system inset underneath it.
const _shellBarRoom = 80.0;

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
          number: '100$i',
          sourceType: FavoriteSourceType.pbx,
          sourceId: '$i',
          label: 'work',
          position: i,
        ),
        contact: null,
      ),
  ];

  setUpAll(() {
    registerFallbackValue(
      const FavoritesShifted(
        favorite: Favorite(number: '0', sourceType: FavoriteSourceType.pbx, sourceId: '0', label: 'work', position: 0),
        position: 0,
      ),
    );
  });

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

  Future<void> pumpScreen(WidgetTester tester, {int count = 3, Stream<FavoritesState>? updates}) async {
    whenListen(
      favoritesBloc,
      updates ?? const Stream<FavoritesState>.empty(),
      initialState: FavoritesState(favorites: favorites(count)),
    );

    await tester.pumpWidget(
      // The app shell floats its tab bar over the page and reports the room it
      // takes as bottom padding; without that here the page cannot know about
      // the bar at all.
      MediaQuery(
        data: const MediaQueryData(padding: EdgeInsets.only(bottom: _shellBarRoom)),
        child: ThemeProvider(
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
      ),
    );
    await tester.pump();
  }

  testWidgets('the rearrange button says what it will do', (tester) async {
    final handle = tester.ensureSemantics();

    await pumpScreen(tester);

    // Only the icon carried this before, and the icon means two different
    // things depending on whether rearranging is already under way.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(favoritesReorderId),
      label: 'Reorder favorites',
      identifier: favoritesReorderId,
    );

    await tapViaSemantics(tester, find.bySemanticsIdentifier(favoritesReorderId));
    await tester.pump();

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(favoritesReorderId),
      label: 'Finish reordering',
      identifier: favoritesReorderId,
    );

    handle.dispose();
  });

  testWidgets('the rearrange button stays clear of the tab bar', (tester) async {
    await pumpScreen(tester);

    // The tab bar of the main screen floats over this page. Without room kept
    // for it the button is drawn underneath: nothing is visible and every tap
    // goes to the tab bar instead - which is exactly how it shipped.
    final button = tester.getRect(find.byType(FloatingActionButton));
    final screenBottom = tester.getSize(find.byType(FavoritesScreen)).height;

    expect(screenBottom - button.bottom, greaterThanOrEqualTo(_shellBarRoom));
  });

  testWidgets('a pair of favorites can be rearranged', (tester) async {
    // Swapping two rows is the one case where rearranging is the whole task,
    // and the screen used to refuse it: the button appeared from three up.
    await pumpScreen(tester, count: 2);

    expect(find.byType(FloatingActionButton), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.byIcon(Icons.drag_handle), findsNWidgets(2));
  });

  testWidgets('the rearranging mode ends when the list gets too short for it', (tester) async {
    final updates = StreamController<FavoritesState>();
    addTearDown(updates.close);

    await pumpScreen(tester, count: 2, updates: updates.stream);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.byIcon(Icons.drag_handle), findsWidgets);

    // The button is the only way out of the mode, and it is not offered on a
    // list this short - so the screen has to leave the mode by itself, or the
    // rows stay locked with the tile actions hidden.
    updates.add(FavoritesState(favorites: favorites(1)));
    await tester.pump();
    await tester.pump();

    expect(find.byIcon(Icons.drag_handle), findsNothing);

    // And it really left it, rather than only hiding the handles: the button
    // comes back offering to START rearranging.
    updates.add(FavoritesState(favorites: favorites(2)));
    await tester.pump();
    await tester.pump();

    expect(find.byIcon(Icons.edit_note_outlined), findsOneWidget);
  });

  testWidgets('moving a row without a drag really moves it', (tester) async {
    final handle = tester.ensureSemantics();

    await pumpScreen(tester);

    // Dragging is the only way a sighted user reorders, and it is not
    // available to a screen reader; the list offers move actions instead, and
    // those had been wired to nothing.
    final row = tester.getSemantics(find.byType(FavoriteTile).first);
    final actions = row
        .getSemanticsData()
        .customSemanticsActionIds!
        .map(CustomSemanticsAction.getAction)
        .map((action) => action!.label)
        .toList();
    expect(actions, contains('Move down'));

    final moveDown = CustomSemanticsAction.getIdentifier(
      row
          .getSemanticsData()
          .customSemanticsActionIds!
          .map(CustomSemanticsAction.getAction)
          .firstWhere((action) => action!.label == 'Move down')!,
    );
    row.owner!.performAction(row.id, SemanticsAction.customAction, moveDown);
    await tester.pump();

    final shifted = verify(() => favoritesBloc.add(captureAny(that: isA<FavoritesShifted>()))).captured;
    expect(shifted, hasLength(1));
    expect((shifted.single as FavoritesShifted).position, 1);

    handle.dispose();
  });
}
