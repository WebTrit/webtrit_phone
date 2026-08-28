import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/settings/features/voicemail/bloc/voicemail_playback_controller.dart';
import 'package:webtrit_phone/features/settings/features/voicemail/models/voicemail_screen_context.dart';
import 'package:webtrit_phone/features/settings/features/voicemail/widgets/voicemail_tile.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../../../helpers/helpers.dart';

class _MockPlaybackController extends Mock implements VoicemailPlaybackController {}

void main() {
  final voicemail = Voicemail(
    'vm-1',
    '2026-08-12T08:17:00Z',
    4.2,
    '555002',
    'User 555002',
    '555001',
    ReadStatus.read,
    17,
    'voice',
    'https://example.test/vm-1.mp3',
  );

  late _MockPlaybackController controller;

  setUp(() {
    controller = _MockPlaybackController();
    when(() => controller.activeId).thenReturn(null);
    when(() => controller.isLoading).thenReturn(false);
    when(() => controller.error).thenReturn(null);
    when(() => controller.addListener(any())).thenReturn(null);
    when(() => controller.removeListener(any())).thenReturn(null);
  });

  Widget wrap({VoidCallback? onLongPress}) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        // The avatar reads presence params from the tree, and the row is laid
        // out for a phone-sized surface.
        body: PresenceViewParams(
          directPresenceEnabled: false,
          dialogsOverSipEnabled: false,
          presenceOverSipEnabled: false,
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<VoicemailPlaybackController>.value(value: controller),
              Provider<VoicemailScreenContext>.value(
                value: VoicemailScreenContext(
                  mediaCacheBasePath: '/tmp/vm-cache',
                  dateFormat: DateFormat('MMM d, y HH:mm'),
                  mediaHeaders: const {},
                ),
              ),
            ],
            child: VoicemailTile(
              voicemail: voicemail,
              displayName: 'User 555002',
              selected: false,
              onCall: (_) {},
              onDeleted: (_) {},
              onToggleSeenStatus: (_) {},
              onLongPress: (_) => onLongPress?.call(),
              onTap: (_) {},
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('the actions menu is named, targetable by id and opens', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap());

    final menu = find.bySemanticsIdentifier(voicemailMenuId);
    expectTapTargetSemantics(tester, menu, label: 'More', identifier: voicemailMenuId, isButton: true);

    await tapViaSemantics(tester, menu);
    await tester.pumpAndSettle();
    expect(find.text('Delete'), findsOneWidget);

    handle.dispose();
  });

  testWidgets('long-pressing the menu shows its own name and does not start selecting messages', (tester) async {
    var selectionStarted = false;
    await tester.pumpWidget(wrap(onLongPress: () => selectionStarted = true));

    await tester.longPress(find.byIcon(Icons.more_vert));
    await tester.pump(const Duration(seconds: 1));

    // The row's long press means "select this message"; the menu button must
    // not fall through to it, and the tooltip must name the button itself.
    expect(selectionStarted, isFalse);
    expect(find.text('More'), findsOneWidget);

    await tester.pumpAndSettle();
  });
}
