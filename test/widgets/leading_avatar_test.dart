import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/leading_avatar.dart';

void main() {
  Widget wrap(Widget child, {NameColorsStyle? nameColors}) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [
          LeadingAvatarStyles(
            primary: LeadingAvatarStyle(
              backgroundColor: const Color(0xFFEEF3F6),
              initialsTextStyle: const TextStyle(color: Color(0xFF1F618F)),
              nameColors: nameColors,
            ),
          ),
        ],
      ),
      home: Scaffold(
        body: PresenceViewParams(
          hybridPresenceSupport: false,
          blfViaSipSupport: false,
          presenceViaSipSupport: false,
          child: child,
        ),
      ),
    );
  }

  Color backgroundOf(WidgetTester tester) {
    final container = tester.widget<Container>(
      find.descendant(of: find.byType(LeadingAvatar), matching: find.byType(Container)).first,
    );
    return (container.decoration! as BoxDecoration).color!;
  }

  Color initialsColorOf(WidgetTester tester) {
    return tester
        .widget<Text>(find.descendant(of: find.byType(LeadingAvatar), matching: find.byType(Text)))
        .style!
        .color!;
  }

  group('LeadingAvatar name colors', () {
    testWidgets('derives the background from the username', (tester) async {
      await tester.pumpWidget(wrap(const LeadingAvatar(username: 'John Doe'), nameColors: const NameColorsStyle()));

      expect(backgroundOf(tester), AvatarColors.background('John Doe', Brightness.light));
    });

    testWidgets('gives different names different backgrounds', (tester) async {
      await tester.pumpWidget(wrap(const LeadingAvatar(username: 'John Doe'), nameColors: const NameColorsStyle()));
      final first = backgroundOf(tester);

      await tester.pumpWidget(wrap(const LeadingAvatar(username: 'Jane Roe'), nameColors: const NameColorsStyle()));

      expect(backgroundOf(tester), isNot(first));
    });

    testWidgets('contrasts the initials with the derived background', (tester) async {
      await tester.pumpWidget(wrap(const LeadingAvatar(username: 'John Doe'), nameColors: const NameColorsStyle()));

      expect(initialsColorOf(tester), AvatarColors.foreground(backgroundOf(tester), Brightness.light));
    });

    testWidgets('keeps the themed colors when disabled', (tester) async {
      await tester.pumpWidget(
        wrap(const LeadingAvatar(username: 'John Doe'), nameColors: const NameColorsStyle(enabled: false)),
      );

      expect(backgroundOf(tester), const Color(0xFFEEF3F6));
      expect(initialsColorOf(tester), const Color(0xFF1F618F));
    });

    testWidgets('is on when the theme has no nameColors block', (tester) async {
      await tester.pumpWidget(wrap(const LeadingAvatar(username: 'John Doe')));

      expect(backgroundOf(tester), AvatarColors.background('John Doe', Brightness.light));
    });

    testWidgets('keeps the themed background when there is no name', (tester) async {
      await tester.pumpWidget(wrap(const LeadingAvatar(username: null), nameColors: const NameColorsStyle()));

      expect(backgroundOf(tester), const Color(0xFFEEF3F6));
    });
  });
}
