import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/voicemail/bloc/bloc.dart';
import 'package:webtrit_phone/features/voicemail/models/models.dart';
import 'package:webtrit_phone/features/voicemail/view/voicemail_screen.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/voicemail/user_voicemail.dart';
import 'package:webtrit_phone/utils/view_params/presence_view_params.dart';

class _MockVoicemailCubit extends MockCubit<VoicemailState> implements VoicemailCubit {}

class _MockAudioPlayer extends Mock implements AudioPlayer {}

Voicemail _voicemail(String id) => Voicemail(
  id,
  '2026-07-06 10:00:00',
  10.0,
  '555001',
  'User 555001',
  '555002',
  ReadStatus.read,
  1024,
  'voicemail',
  'https://example.com/vm/$id.mp3',
);

VoicemailState _loadedState(List<Voicemail> items) =>
    const VoicemailState().copyWith(items: items, status: VoicemailStatus.loaded);

void main() {
  setUpAll(() {
    registerFallbackValue(AudioSource.uri(Uri.parse('file:///fallback')));
  });

  late _MockVoicemailCubit cubit;
  late _MockAudioPlayer player;
  late StreamController<PlayerState> playerStateController;
  late VoicemailPlaybackController controller;

  setUp(() {
    cubit = _MockVoicemailCubit();
    player = _MockAudioPlayer();
    playerStateController = StreamController<PlayerState>.broadcast(sync: true);

    when(() => player.playerStateStream).thenAnswer((_) => playerStateController.stream);
    when(() => player.playing).thenReturn(false);
    when(() => player.stop()).thenAnswer((_) async {});
    when(() => player.dispose()).thenAnswer((_) async {});
    when(() => player.positionStream).thenAnswer((_) => Stream.value(Duration.zero));
    when(() => player.duration).thenReturn(const Duration(seconds: 10));
    when(() => cubit.fetchVoicemails()).thenAnswer((_) async {});

    controller = VoicemailPlaybackController(player: player, setupAudioSession: () async {});
  });

  tearDown(() async {
    await playerStateController.close();
  });

  Widget host() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiProvider(
        providers: [
          BlocProvider<VoicemailCubit>.value(value: cubit),
          Provider<AppCacheManager>(create: (_) => AppCacheManager(sections: const [])),
          Provider<VoicemailScreenContext>(
            create: (_) => VoicemailScreenContext(
              mediaCacheBasePath: '/tmp/vm-cache',
              dateFormat: DateFormat('yyyy-MM-dd HH:mm'),
              mediaHeaders: const {},
            ),
          ),
          ChangeNotifierProvider<VoicemailPlaybackController>.value(value: controller),
        ],
        child: const PresenceViewParams(
          hybridPresenceSupport: false,
          blfViaSipSupport: false,
          presenceViaSipSupport: false,
          child: VoicemailScreen(),
        ),
      ),
    );
  }

  Future<void> pullDown(WidgetTester tester) async {
    await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
    await tester.pumpAndSettle();
  }

  // A mailbox short enough to have nothing to scroll is the case that breaks
  // first: a list that cannot scroll swallows the drag unless it is told to
  // accept one anyway.
  testWidgets('pulling a list too short to scroll fetches the mailbox again', (tester) async {
    whenListen(cubit, const Stream<VoicemailState>.empty(), initialState: _loadedState([_voicemail('vm-1')]));

    await tester.pumpWidget(host());
    await pullDown(tester);

    verify(() => cubit.fetchVoicemails()).called(1);
  });

  testWidgets('pulling an empty mailbox fetches it again', (tester) async {
    whenListen(cubit, const Stream<VoicemailState>.empty(), initialState: _loadedState([]));

    await tester.pumpWidget(host());
    await pullDown(tester);

    verify(() => cubit.fetchVoicemails()).called(1);
  });
}
