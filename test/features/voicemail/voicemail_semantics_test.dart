import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/voicemail/bloc/voicemail_playback_controller.dart';
import 'package:webtrit_phone/features/voicemail/models/voicemail_screen_context.dart';
import 'package:webtrit_phone/features/voicemail/widgets/audio_view.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

import '../../helpers/helpers.dart';

class _MockPlaybackController extends Mock implements VoicemailPlaybackController {}

class _MockScreenContext extends Mock implements VoicemailScreenContext {}

class _MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  const path = 'https://example.test/voicemail.mp3';

  late _MockPlaybackController controller;
  late _MockScreenContext screenContext;

  setUpAll(() {
    registerFallbackValue(Uri.parse(path));
  });

  setUp(() {
    controller = _MockPlaybackController();
    when(() => controller.isLoading).thenReturn(false);
    when(() => controller.error).thenReturn(null);
    when(() => controller.addListener(any())).thenReturn(null);
    when(() => controller.removeListener(any())).thenReturn(null);

    screenContext = _MockScreenContext();
    when(() => screenContext.mediaHeaders).thenReturn(const {});
    when(() => screenContext.mediaCacheBasePath).thenReturn('/tmp/vm-cache');
  });

  Widget wrap() {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<VoicemailPlaybackController>.value(value: controller),
            Provider<VoicemailScreenContext>.value(value: screenContext),
          ],
          child: const AudioView(path: path),
        ),
      ),
    );
  }

  AudioPlayer stubPlayer({required bool playing}) {
    final player = _MockAudioPlayer();
    when(() => player.positionStream).thenAnswer((_) => const Stream<Duration>.empty());
    when(() => player.duration).thenReturn(const Duration(seconds: 30));
    when(() => player.playing).thenReturn(playing);
    return player;
  }

  testWidgets('the idle play button is named and starts playback through semantics', (tester) async {
    final handle = tester.ensureSemantics();

    when(() => controller.activeId).thenReturn(null);
    when(
      () => controller.play(
        id: any(named: 'id'),
        uri: any(named: 'uri'),
        headers: any(named: 'headers'),
        cacheBasePath: any(named: 'cacheBasePath'),
        cacheKey: any(named: 'cacheKey'),
        isLocal: any(named: 'isLocal'),
      ),
    ).thenAnswer((_) async {});
    await tester.pumpWidget(wrap());

    final finder = find.bySemanticsIdentifier(voicemailPlaybackId);
    expectTapTargetSemantics(tester, finder, label: 'Play', identifier: voicemailPlaybackId, isButton: true);

    await tapViaSemantics(tester, finder);
    verify(
      () => controller.play(
        id: any(named: 'id'),
        uri: any(named: 'uri'),
        headers: any(named: 'headers'),
        cacheBasePath: any(named: 'cacheBasePath'),
        cacheKey: any(named: 'cacheKey'),
        isLocal: any(named: 'isLocal'),
      ),
    ).called(1);

    handle.dispose();
  });

  testWidgets('while playing, the same button is named "Pause", keeps its id and pauses through semantics', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();

    // Build the mock before stubbing: mocktail forbids `when` inside a stub.
    final player = stubPlayer(playing: true);
    when(() => controller.activeId).thenReturn(path);
    when(() => controller.player).thenReturn(player);
    when(() => controller.isPlaying).thenReturn(true);
    when(() => controller.pause()).thenAnswer((_) async {});
    await tester.pumpWidget(wrap());

    final finder = find.bySemanticsIdentifier(voicemailPlaybackId);
    expectTapTargetSemantics(tester, finder, label: 'Pause', identifier: voicemailPlaybackId, isButton: true);

    await tapViaSemantics(tester, finder);
    verify(() => controller.pause()).called(1);

    handle.dispose();
  });

  testWidgets('a paused message offers Play again and resumes through semantics', (tester) async {
    final handle = tester.ensureSemantics();

    final player = stubPlayer(playing: false);
    when(() => controller.activeId).thenReturn(path);
    when(() => controller.player).thenReturn(player);
    when(() => controller.isPlaying).thenReturn(false);
    when(() => controller.resume()).thenAnswer((_) async {});
    await tester.pumpWidget(wrap());

    final finder = find.bySemanticsIdentifier(voicemailPlaybackId);
    expectTapTargetSemantics(tester, finder, label: 'Play', identifier: voicemailPlaybackId, isButton: true);

    await tapViaSemantics(tester, finder);
    verify(() => controller.resume()).called(1);

    handle.dispose();
  });

  testWidgets('the loading state says what is happening instead of going silent', (tester) async {
    final handle = tester.ensureSemantics();

    when(() => controller.activeId).thenReturn(path);
    when(() => controller.isLoading).thenReturn(true);
    await tester.pumpWidget(wrap());

    // Activating play replaces the button with this view, so it must announce
    // itself - otherwise focus is dropped with nothing spoken.
    expect(tester.getSemantics(find.byType(AudioLoadingView)), isSemantics(label: 'Loading', isLiveRegion: true));

    handle.dispose();
  });

  testWidgets('a failed playback offers a named retry that works through semantics', (tester) async {
    final handle = tester.ensureSemantics();

    when(() => controller.activeId).thenReturn(path);
    when(() => controller.error).thenReturn(Exception('boom'));
    when(
      () => controller.play(
        id: any(named: 'id'),
        uri: any(named: 'uri'),
        headers: any(named: 'headers'),
        cacheBasePath: any(named: 'cacheBasePath'),
        cacheKey: any(named: 'cacheKey'),
        isLocal: any(named: 'isLocal'),
      ),
    ).thenAnswer((_) async {});
    await tester.pumpWidget(wrap());

    final finder = find.bySemanticsIdentifier(voicemailRetryId);
    expectTapTargetSemantics(tester, finder, label: 'Try again', identifier: voicemailRetryId, isButton: true);

    await tapViaSemantics(tester, finder);
    verify(
      () => controller.play(
        id: any(named: 'id'),
        uri: any(named: 'uri'),
        headers: any(named: 'headers'),
        cacheBasePath: any(named: 'cacheBasePath'),
        cacheKey: any(named: 'cacheKey'),
        isLocal: any(named: 'isLocal'),
      ),
    ).called(1);

    handle.dispose();
  });

  testWidgets('the idle placeholder slider is not offered as a control', (tester) async {
    final handle = tester.ensureSemantics();

    when(() => controller.activeId).thenReturn(null);
    await tester.pumpWidget(wrap());

    expect(find.byType(Slider), findsOneWidget);
    expect(find.semantics.byValue('0%'), findsNothing);

    handle.dispose();
  });
}
