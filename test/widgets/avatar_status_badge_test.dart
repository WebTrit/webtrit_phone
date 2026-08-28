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

  /// The share of the avatar a presence mark takes, as the app sets it in
  /// `LeadingAvatarStyle`. Named rather than spelled out at each expectation:
  /// the four copies of it went stale together the last time it changed.
  const markFactor = 0.4;

  Widget wrap(Widget badge, {required bool enabled}) {
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
          directPresenceEnabled: enabled,
          dialogsOverSipEnabled: false,
          presenceOverSipEnabled: false,
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
      find.descendant(of: find.byType(SipPresenceIndicator), matching: find.byType(Container)),
    );
    return (container.decoration! as BoxDecoration).color;
  }

  Container dotOf(WidgetTester tester) {
    return tester.widget<Container>(
      find.descendant(of: find.byType(AvatarStatusBadge), matching: find.byType(Container)),
    );
  }

  group('AvatarStatusBadge without hybrid presence', () {
    testWidgets('draws the registration dot at the presence-mark size, ringed', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(registered: true), enabled: false));

      final dot = dotOf(tester);
      final decoration = dot.decoration! as BoxDecoration;
      expect(decoration.color, registeredColor);
      expect(tester.getSize(find.byWidget(dot)), const Size(diameter * markFactor, diameter * markFactor));
      // The ring is what lets the dot straddle the avatar edge: without it,
      // the half hanging over the row background reads as a partial dot.
      expect(decoration.border!.top.width, diameter * markFactor * 0.1);
      expect(find.byType(SipPresenceIndicator), findsNothing);
    });

    testWidgets('sits the registration dot on the avatar edge', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(registered: true), enabled: false));

      final dot = tester.getRect(find.byWidget(dotOf(tester)));
      final avatar = tester.getRect(find.byType(AvatarStatusBadge));

      expect((dot.center - avatar.center).distance, closeTo(avatar.width / 2, 0.01));
      expect(dot.right, greaterThan(avatar.right));
    });

    testWidgets('colors the dot by registration state', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(registered: false), enabled: false));

      expect((dotOf(tester).decoration! as BoxDecoration).color, unregisteredColor);
    });

    testWidgets('shows nothing without registration data', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(), enabled: false));

      expect(find.descendant(of: find.byType(AvatarStatusBadge), matching: find.byType(Container)), findsNothing);
      expect(find.byType(SipPresenceIndicator), findsNothing);
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
      await tester.pumpWidget(wrap(AvatarStatusBadge(presenceInfo: [presence(available: true)]), enabled: true));

      expect(find.byType(SipPresenceIndicator), findsOneWidget);
      expect(
        tester.getSize(find.byType(SipPresenceIndicator)),
        const Size(diameter * markFactor, diameter * markFactor),
      );
    });

    testWidgets('sits the mark on the avatar edge with the glyph inside it', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.busy]),
            ],
          ),
          enabled: true,
        ),
      );

      final avatar = tester.getRect(find.byType(AvatarStatusBadge));
      final dot = tester.getRect(find.byType(SipPresenceIndicator));
      final icon = tester.getRect(find.descendant(of: find.byType(SipPresenceIndicator), matching: find.byType(Icon)));

      // The mark's centre sits ON the avatar's edge, so half of it hangs
      // outside the silhouette instead of covering the face; the glyph lives
      // inside the mark, because an icon laid over it would cut into the
      // outline and make the mark read smaller than it is.
      final avatarCentre = avatar.center;
      final radius = avatar.width / 2;
      final reach = (dot.center - avatarCentre).distance;
      expect(reach, closeTo(radius, 0.01));
      expect(dot.width, avatar.width * markFactor);
      expect(dot.right, greaterThan(avatar.right));
      expect(icon.left, greaterThanOrEqualTo(dot.left));
      expect(icon.top, greaterThanOrEqualTo(dot.top));
      expect(icon.right, lessThanOrEqualTo(dot.right));
      expect(icon.bottom, lessThanOrEqualTo(dot.bottom));
    });

    testWidgets('ignores registration data', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(registered: true), enabled: true));

      expect(find.descendant(of: find.byType(AvatarStatusBadge), matching: find.byType(Container)), findsNothing);
      expect(find.byType(SipPresenceIndicator), findsNothing);
    });
  });

  group('the mark colours whether the contact can be called now', () {
    testWidgets('do not disturb paints it busy', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.doNotDisturb]),
            ],
          ),
          enabled: true,
        ),
      );

      expect(markColor(tester), busyColor);
    });

    testWidgets('a published busy paints it busy as well', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.busy]),
            ],
          ),
          enabled: true,
        ),
      );

      expect(markColor(tester), busyColor);
    });

    testWidgets('an activity that is merely elsewhere stays available', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.vacation]),
            ],
          ),
          enabled: true,
        ),
      );

      expect(markColor(tester), availableColor);
    });

    testWidgets('a reported call leaves the colour alone, established or ringing', (tester) async {
      for (final state in [DialogState.confirmed, DialogState.early]) {
        await tester.pumpWidget(
          wrap(
            AvatarStatusBadge(presenceInfo: [presence(available: true)], dialogInfo: [dialog(state)]),
            enabled: true,
          ),
        );

        expect(markColor(tester), availableColor, reason: 'dialog state ${state.name}');
      }
    });

    testWidgets('a contact publishing on-the-phone keeps the reachable colour', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.onThePhone]),
            ],
          ),
          enabled: true,
        ),
      );

      expect(markColor(tester), availableColor);
    });

    testWidgets('an unreachable contact stays unavailable', (tester) async {
      await tester.pumpWidget(wrap(AvatarStatusBadge(presenceInfo: [presence(available: false)]), enabled: true));

      expect(markColor(tester), unavailableColor);
    });

    testWidgets('do not disturb outranks being unreachable', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: false, activities: const [PresenceActivity.doNotDisturb]),
            ],
          ),
          enabled: true,
        ),
      );

      expect(markColor(tester), busyColor);
    });
  });

  group('the mark says its state out loud', () {
    testWidgets('an established call is announced as a call', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(presenceInfo: [presence(available: true)], dialogInfo: [dialog(DialogState.confirmed)]),
          enabled: true,
        ),
      );

      expect(find.bySemanticsLabel('On a call'), findsOneWidget);
    });

    testWidgets('a phone that is only ringing is not announced as a call', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(presenceInfo: [presence(available: true)], dialogInfo: [dialog(DialogState.early)]),
          enabled: true,
        ),
      );

      expect(find.bySemanticsLabel('On a call'), findsNothing);
      expect(find.bySemanticsLabel('Available'), findsOneWidget);
    });

    testWidgets('a published activity is announced instead of the plain state', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.vacation]),
            ],
          ),
          enabled: true,
        ),
      );

      expect(find.bySemanticsLabel('On vacation'), findsOneWidget);
    });

    testWidgets('do not disturb is announced even though it only changes the colour', (tester) async {
      await tester.pumpWidget(
        wrap(
          AvatarStatusBadge(
            presenceInfo: [
              presence(available: true, activities: const [PresenceActivity.doNotDisturb]),
            ],
          ),
          enabled: true,
        ),
      );

      expect(find.bySemanticsLabel('Do not disturb'), findsOneWidget);
      expect(find.bySemanticsLabel('Available'), findsNothing);
    });

    testWidgets('a plain contact is announced as available or not', (tester) async {
      await tester.pumpWidget(wrap(AvatarStatusBadge(presenceInfo: [presence(available: true)]), enabled: true));
      expect(find.bySemanticsLabel('Available'), findsOneWidget);

      await tester.pumpWidget(wrap(AvatarStatusBadge(presenceInfo: [presence(available: false)]), enabled: true));
      expect(find.bySemanticsLabel('Unavailable'), findsOneWidget);
    });
  });

  group('the legacy registration dot says its state out loud', () {
    testWidgets('a registered contact is announced as registered', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(registered: true), enabled: false));

      expect(find.bySemanticsLabel('Registered'), findsOneWidget);
    });

    testWidgets('an unregistered contact is announced as not registered', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(registered: false), enabled: false));

      expect(find.bySemanticsLabel('Not registered'), findsOneWidget);
    });

    testWidgets('nothing is announced when there is no registration data', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(), enabled: false));

      expect(find.bySemanticsLabel('Registered'), findsNothing);
      expect(find.bySemanticsLabel('Not registered'), findsNothing);
    });
  });
}
