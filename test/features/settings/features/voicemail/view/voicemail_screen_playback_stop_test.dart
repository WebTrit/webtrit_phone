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
import 'package:webtrit_phone/features/settings/features/voicemail/bloc/bloc.dart';
import 'package:webtrit_phone/services/services.dart';
import 'package:webtrit_phone/features/settings/features/voicemail/models/models.dart';
import 'package:webtrit_phone/features/settings/features/voicemail/view/voicemail_screen.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/voicemail/user_voicemail.dart';
import 'package:webtrit_phone/utils/view_params/presence_view_params.dart';

class _MockVoicemailCubit extends MockCubit<VoicemailState> implements VoicemailCubit {}

class _MockTranscriptionModelService extends Mock implements TranscriptionModelService {}

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

TranscriptionModelService _modelService() {
  final modelService = _MockTranscriptionModelService();
  when(() => modelService.canSelectModel).thenReturn(false);
  when(() => modelService.modelDownloadState).thenReturn(ValueNotifier(const ModelDownloadIdle()));
  return modelService;
}

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
    when(() => player.playing).thenReturn(true);
    when(() => player.stop()).thenAnswer((_) async {});
    when(() => player.dispose()).thenAnswer((_) async {});
    when(() => player.setAudioSource(any())).thenAnswer((_) async => null);
    when(() => player.play()).thenAnswer((_) async {});
    when(() => player.positionStream).thenAnswer((_) => Stream.value(Duration.zero));
    when(() => player.duration).thenReturn(const Duration(seconds: 10));

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
          Provider<TranscriptionModelService>.value(value: _modelService()),
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

  testWidgets('stops playback when the active voicemail disappears from the list', (tester) async {
    final vm1 = _voicemail('vm-1');
    final vm2 = _voicemail('vm-2');

    whenListen(
      cubit,
      Stream.fromIterable([
        _loadedState([vm2]),
      ]),
      initialState: _loadedState([vm1, vm2]),
    );

    await controller.play(id: 'vm-1', uri: Uri.parse(vm1.url!), isLocal: true);
    expect(controller.activeId, 'vm-1');
    clearInteractions(player);

    await tester.pumpWidget(host());
    await tester.pump();

    expect(controller.activeId, isNull);
    verify(() => player.stop()).called(1);
  });

  testWidgets('keeps playback when a different voicemail is removed', (tester) async {
    final vm1 = _voicemail('vm-1');
    final vm2 = _voicemail('vm-2');

    whenListen(
      cubit,
      Stream.fromIterable([
        _loadedState([vm1]),
      ]),
      initialState: _loadedState([vm1, vm2]),
    );

    await controller.play(id: 'vm-1', uri: Uri.parse(vm1.url!), isLocal: true);
    clearInteractions(player);

    await tester.pumpWidget(host());
    await tester.pump();

    expect(controller.activeId, 'vm-1');
    verifyNever(() => player.stop());
  });
}
