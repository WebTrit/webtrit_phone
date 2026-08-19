import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  const registeredColor = Color(0xFF00AA00);
  const unregisteredColor = Color(0xFF888888);
  const diameter = 40.0;

  Widget wrap(Widget badge, {required bool hybridPresenceSupport}) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [
          RegisteredStatusStyles(
            primary: RegisteredStatusStyle(registered: registeredColor, unregistered: unregisteredColor),
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

  PresenceInfo presence({required bool available}) {
    return PresenceInfo(
      id: 'id',
      number: 'number',
      available: available,
      note: '',
      statusIcon: null,
      device: null,
      timeOffsetMin: null,
      timestamp: null,
      activities: const [],
      source: PresenceInfoSource.sip,
      arrivalTime: DateTime(2026),
    );
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
      expect(find.byType(SipPresenceIndicator), findsNothing);
    });

    testWidgets('colors the dot by registration state', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(registered: false), hybridPresenceSupport: false));

      expect((dotOf(tester).decoration! as BoxDecoration).color, unregisteredColor);
    });

    testWidgets('shows nothing without registration data', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(), hybridPresenceSupport: false));

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
      await tester.pumpWidget(
        wrap(AvatarStatusBadge(presenceInfo: [presence(available: true)]), hybridPresenceSupport: true),
      );

      expect(find.byType(SipPresenceIndicator), findsOneWidget);
      expect(tester.getSize(find.byType(SipPresenceIndicator)), const Size(diameter * 0.325, diameter * 0.325));
    });

    testWidgets('ignores registration data', (tester) async {
      await tester.pumpWidget(wrap(const AvatarStatusBadge(registered: true), hybridPresenceSupport: true));

      expect(find.descendant(of: find.byType(AvatarStatusBadge), matching: find.byType(Container)), findsNothing);
      expect(find.byType(SipPresenceIndicator), findsNothing);
    });
  });
}
