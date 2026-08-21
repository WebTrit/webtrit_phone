import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  const registeredColor = Color(0xFF00AA00);
  const unregisteredColor = Color(0xFF888888);
  const availableColor = Color(0xFF11AA11);
  const unavailableColor = Color(0xFF999999);
  const busyColor = Color(0xFFCC2222);
  const diameter = 40.0;

  Widget wrap(Widget badge, {required bool hybridPresenceSupport}) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        extensions: [
          RegisteredStatusStyles(
            primary: RegisteredStatusStyle(registered: registeredColor, unregistered: unregisteredColor),
          ),
          const LeadingAvatarStyles(
            primary: LeadingAvatarStyle(
              presenceBadge: PresenceBadgeStyle(
                availableColor: availableColor,
                unavailableColor: unavailableColor,
                busyColor: busyColor,
              ),
            ),
          ),
        ],
      ),
      home: Scaffold(
        body: PresenceViewParams(
          hybridPresenceSupport: hybridPresenceSupport,
          blfViaSipSupport: false,
          presenceViaSipSupport: false,
          child: Center(
            child: SizedBox(
              width: diameter,
              height: diameter,
              child: Stack(children: [Positioned.fill(child: badge)]),
            ),
          ),
        ),
      ),
    );
  }

  PresenceInfo presence({required bool available, List<PresenceActivity> activities = const []}) {
    return PresenceInfo(
      id: 'id',
      number: 'number',
      available: available,
      note: '',
      statusIcon: null,
      device: null,
      timeOffsetMin: null,
      timestamp: null,
      activities: activities,
      source: PresenceInfoSource.sip,
      arrivalTime: DateTime(2026),
    );
  }

  DialogInfo dialog(DialogState state) => DialogInfo(
    id: 'dlg-${state.name}',
    entityNumber: 'number',
    state: state,
    callId: 'call',
    direction: DialogDirection.recipient,
    localTag: 'lt',
    localNumber: 'number',
    localDisplayName: null,
    remoteTag: 'rt',
    remoteNumber: 'other',
    remoteDisplayName: null,
    arrivalVersion: '1',
    arrivalTime: DateTime(2026),
  );

  Color? markColor(WidgetTester tester) {
    final container = tester.widget<Container>(
      find.descendant(of: find.byType(PresenceMark), matching: find.byType(Container)),
    );
    return (container.decoration! as BoxDecoration).color;
  }

  Container dotOf(WidgetTester tester) {
    return tester.widget<Container>(
      find.descendant(of: find.byType(AvatarStatusBadge), matching: find.byType(Container)),
    );
  }

  group('AvatarStatusBadge without hybrid presence', () {
    testWidgets('shows the registration dot at the legacy size', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(registered: true), hybridPresenceSupport: false));

      final dot = dotOf(tester);
      expect((dot.decoration! as BoxDecoration).color, registeredColor);
      expect(tester.getSize(find.byWidget(dot)), const Size(diameter * 0.2, diameter * 0.2));
      expect(find.byType(PresenceMark), findsNothing);
    });

    testWidgets('colors the dot by registration state', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(registered: false), hybridPresenceSupport: false));

      expect((dotOf(tester).decoration! as BoxDecoration).color, unregisteredColor);
    });

    testWidgets('shows nothing without registration data', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(), hybridPresenceSupport: false));

      expect(find.descendant(of: find.byType(AvatarStatusBadge), matching: find.byType(Container)), findsNothing);
      expect(find.byType(PresenceMark), findsNothing);
    });
  });

  group('AvatarStatusBadge.maybe', () {
    test('is null when there is no status data', () {
      expect(AvatarStatusBadge.maybe(), isNull);
    });

    test('is a badge when any input is present', () {
      expect(AvatarStatusBadge.maybe(registered: false), isA<AvatarStatusBadge>());
      expect(AvatarStatusBadge.maybe(presenceInfo: const []), isA<AvatarStatusBadge>());
      expect(AvatarStatusBadge.maybe(dialogInfo: const []), isA<AvatarStatusBadge>());
    });
  });

  group('AvatarStatusBadge with hybrid presence', () {
    testWidgets('shows the presence indicator at the hybrid size', (tester) async {
      await tester.pumpWidget(
        wrap(AvatarStatusBadge(presenceInfo: [presence(available: true)]), hybridPresenceSupport: true),
      );

      expect(find.byType(PresenceMark), findsOneWidget);
      expect(tester.getSize(find.byType(PresenceMark)), const Size(diameter * 0.5, diameter * 0.5));
    });

    testWidgets('sits the mark on the avatar edge with the glyph inside it', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.busy]),
            ],
          ),
          hybridPresenceSupport: true,
        ),
      );

      final avatar = tester.getRect(find.byType(AvatarStatusBadge));
      final dot = tester.getRect(find.byType(PresenceMark));
      final icon = tester.getRect(find.descendant(of: find.byType(PresenceMark), matching: find.byType(Icon)));

      // The mark's centre sits ON the avatar's edge, so half of it hangs
      // outside the silhouette instead of covering the face; the glyph lives
      // inside the mark, because an icon laid over it would cut into the
      // outline and make the mark read smaller than it is.
      final avatarCentre = avatar.center;
      final radius = avatar.width / 2;
      final reach = (dot.center - avatarCentre).distance;
      expect(reach, closeTo(radius, 0.01));
      expect(dot.width, avatar.width * 0.5);
      expect(dot.right, greaterThan(avatar.right));
      expect(icon.left, greaterThanOrEqualTo(dot.left));
      expect(icon.top, greaterThanOrEqualTo(dot.top));
      expect(icon.right, lessThanOrEqualTo(dot.right));
      expect(icon.bottom, lessThanOrEqualTo(dot.bottom));
    });

    testWidgets('lets a published status outrank registration', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(registered: true, presenceInfo: [presence(available: false)]),
          hybridPresenceSupport: true,
        ),
      );

      // The status mark, at its own size - not the small registration dot.
      expect(find.byType(PresenceMark), findsOneWidget);
      expect(tester.getSize(find.byType(PresenceMark)), const Size(diameter * 0.5, diameter * 0.5));
    });
  });

  group('with no status published, registration takes over', () {
    testWidgets('an unregistered contact gets a mark of the same size, not silence', (tester) async {
      await tester.pumpWidget(
        wrap(const AvatarStatusBadge(registered: false, presenceInfo: []), hybridPresenceSupport: true),
      );

      expect(find.byType(PresenceMark), findsOneWidget);
      expect(tester.getSize(find.byType(PresenceMark)), const Size(diameter * 0.5, diameter * 0.5));
      expect(markColor(tester), unavailableColor);
      expect(find.byIcon(Icons.power_settings_new_rounded), findsOneWidget);
      expect(find.bySemanticsLabel('Unavailable'), findsOneWidget);
    });

    testWidgets('a registered one gets the reachable mark', (tester) async {
      await tester.pumpWidget(
        wrap(const AvatarStatusBadge(registered: true, presenceInfo: []), hybridPresenceSupport: true),
      );

      expect(tester.getSize(find.byType(PresenceMark)), const Size(diameter * 0.5, diameter * 0.5));
      expect(markColor(tester), availableColor);
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
      expect(find.bySemanticsLabel('Available'), findsOneWidget);
    });

    testWidgets('and a published status still wins over registration', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            registered: true,
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.doNotDisturb]),
            ],
          ),
          hybridPresenceSupport: true,
        ),
      );

      expect(markColor(tester), busyColor);
      expect(find.byIcon(Icons.remove_rounded), findsOneWidget);
    });
  });

  group('nothing known, nothing drawn', () {
    testWidgets('a contact nobody published anything about gets no mark', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(presenceInfo: []), hybridPresenceSupport: true));

      expect(find.byType(PresenceMark), findsNothing);
    });

    testWidgets('nor does a phone that is merely ringing, with nothing else known', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(presenceInfo: const [], dialogInfo: [dialog(DialogState.early)]),
          hybridPresenceSupport: true,
        ),
      );

      expect(find.byType(PresenceMark), findsNothing);
    });

    testWidgets('but an established call is worth a mark on its own', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(presenceInfo: const [], dialogInfo: [dialog(DialogState.confirmed)]),
          hybridPresenceSupport: true,
        ),
      );

      expect(find.byType(PresenceMark), findsOneWidget);
      expect(find.byIcon(Icons.phone_in_talk_rounded), findsOneWidget);
    });
  });

  group('no mark is left blank', () {
    testWidgets('a contact who says they are not reachable is crossed out, not empty', (tester) async {
      await tester.pumpWidget(
        wrap(AvatarStatusBadge(presenceInfo: [presence(available: false)]), hybridPresenceSupport: true),
      );

      expect(markColor(tester), unavailableColor);
      expect(find.byIcon(Icons.power_settings_new_rounded), findsOneWidget);
    });

    testWidgets('and every state the mark can show carries a glyph', (tester) async {
      final cases = <String, AvatarStatusBadge>{
        'available': AvatarStatusBadge(presenceInfo: [presence(available: true)]),
        'unavailable': AvatarStatusBadge(presenceInfo: [presence(available: false)]),
        'busy': AvatarStatusBadge(
          presenceInfo: [
            presence(available: true, activities: const [PresenceActivity.doNotDisturb]),
          ],
        ),
        'away': AvatarStatusBadge(
          presenceInfo: [
            presence(available: true, activities: const [PresenceActivity.vacation]),
          ],
        ),
        'on a call': AvatarStatusBadge(
          presenceInfo: [presence(available: true)],
          dialogInfo: [dialog(DialogState.confirmed)],
        ),
        'from registration alone': const AvatarStatusBadge(registered: false, presenceInfo: []),
      };

      for (final entry in cases.entries) {
        await tester.pumpWidget(wrap(entry.value, hybridPresenceSupport: true));

        expect(
          find.descendant(of: find.byType(PresenceMark), matching: find.byType(Icon)),
          findsOneWidget,
          reason: '${entry.key} drew a blank mark',
        );
      }
    });
  });

  group('the mark draws three classes, not twelve activities', () {
    testWidgets('being in a call is a handset', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(presenceInfo: [presence(available: true)], dialogInfo: [dialog(DialogState.confirmed)]),
          hybridPresenceSupport: true,
        ),
      );

      expect(find.byIcon(Icons.phone_in_talk_rounded), findsOneWidget);
    });

    testWidgets('asking not to be called is one glyph for both ways of saying it', (tester) async {
      for (final activity in [PresenceActivity.doNotDisturb, PresenceActivity.busy]) {
        await tester.pumpWidget(
          wrap(
            AvatarStatusBadge(
              presenceInfo: [
                presence(available: true, activities: [activity]),
              ],
            ),
            hybridPresenceSupport: true,
          ),
        );

        expect(find.byIcon(Icons.remove_rounded), findsOneWidget, reason: '${activity.name} drew something else');
      }
    });

    testWidgets('every way of being elsewhere shares one glyph', (tester) async {
      for (final activity in [
        PresenceActivity.away,
        PresenceActivity.vacation,
        PresenceActivity.meeting,
        PresenceActivity.sleeping,
      ]) {
        await tester.pumpWidget(
          wrap(
            AvatarStatusBadge(
              presenceInfo: [
                presence(available: true, activities: [activity]),
              ],
            ),
            hybridPresenceSupport: true,
          ),
        );

        expect(find.byIcon(Icons.schedule_rounded), findsOneWidget, reason: '${activity.name} drew something else');
        expect(markColor(tester), unavailableColor, reason: '${activity.name} claimed the reachable colour');
      }
    });

    testWidgets('and being reachable is a tick, so no filled mark is left blank', (tester) async {
      await tester.pumpWidget(
        wrap(AvatarStatusBadge(presenceInfo: [presence(available: true)]), hybridPresenceSupport: true),
      );

      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    });
  });

  group('the mark colours whether the contact can be called now', () {
    testWidgets('an established call paints it busy', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(presenceInfo: [presence(available: true)], dialogInfo: [dialog(DialogState.confirmed)]),
          hybridPresenceSupport: true,
        ),
      );

      expect(markColor(tester), busyColor);
    });

    testWidgets('a phone that is only ringing leaves it available', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(presenceInfo: [presence(available: true)], dialogInfo: [dialog(DialogState.early)]),
          hybridPresenceSupport: true,
        ),
      );

      expect(markColor(tester), availableColor);
    });

    testWidgets('do not disturb paints it busy as well', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.doNotDisturb]),
            ],
          ),
          hybridPresenceSupport: true,
        ),
      );

      expect(markColor(tester), busyColor);
    });

    testWidgets('an activity that is merely elsewhere takes the quiet colour', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.vacation]),
            ],
          ),
          hybridPresenceSupport: true,
        ),
      );

      expect(markColor(tester), unavailableColor);
    });

    testWidgets('a contact who only says they are on the phone is not painted as certain', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.onThePhone]),
            ],
          ),
          hybridPresenceSupport: true,
        ),
      );

      // Same glyph as a proven call, deliberately not the same colour.
      expect(find.byIcon(Icons.phone_in_talk_rounded), findsOneWidget);
      expect(markColor(tester), availableColor);
    });
  });

  group('the mark says its state out loud', () {
    testWidgets('an established call is announced as a call', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(presenceInfo: [presence(available: true)], dialogInfo: [dialog(DialogState.confirmed)]),
          hybridPresenceSupport: true,
        ),
      );

      expect(find.bySemanticsLabel('On a call'), findsOneWidget);
    });

    testWidgets('a published activity is announced instead of the plain state', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.vacation]),
            ],
          ),
          hybridPresenceSupport: true,
        ),
      );

      expect(find.bySemanticsLabel('On vacation'), findsOneWidget);
    });

    testWidgets('a plain contact is announced as available or not', (tester) async {
      await tester.pumpWidget(
        wrap(AvatarStatusBadge(presenceInfo: [presence(available: true)]), hybridPresenceSupport: true),
      );
      expect(find.bySemanticsLabel('Available'), findsOneWidget);

      await tester.pumpWidget(
        wrap(AvatarStatusBadge(presenceInfo: [presence(available: false)]), hybridPresenceSupport: true),
      );
      expect(find.bySemanticsLabel('Unavailable'), findsOneWidget);
    });
  });
}
