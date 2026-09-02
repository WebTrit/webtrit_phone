import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/avatar_status_badge.dart';
import 'package:webtrit_phone/widgets/leading_avatar.dart';
import 'package:webtrit_phone/widgets/safe_network_image.dart';

void main() {
  Widget wrap(Widget child, {NameColorsStyle? nameColors}) {
    return MaterialApp(
      // The status badge names its state from l10n, so the delegates have to
      // be here as they are in the app.
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
      home: Scaffold(body: child),
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

  group('LeadingAvatar photo resolution', () {
    testWidgets('asks Gravatar for a shared size that covers what it paints', (tester) async {
      // The test binding paints at 3.0, so a 74 px avatar is 222 real pixels, asked for
      // as the 256 every other avatar of about that size asks for.
      await tester.pumpWidget(
        wrap(
          LeadingAvatar(
            username: 'John Doe',
            thumbnailUrl: Uri.parse('https://www.gravatar.com/avatar/abc'),
            radius: 37,
          ),
        ),
      );

      final image = tester.widget<SafeNetworkImage>(find.byType(SafeNetworkImage));
      expect(Uri.parse(image.url).queryParameters['s'], '256');
    });

    testWidgets('keeps one url across nearby sizes, so the photo is downloaded once', (tester) async {
      final photo = Uri.parse('https://www.gravatar.com/avatar/abc');

      await tester.pumpWidget(wrap(LeadingAvatar(username: 'John Doe', thumbnailUrl: photo, radius: 37)));
      final requested = tester.widget<SafeNetworkImage>(find.byType(SafeNetworkImage)).url;

      await tester.pumpWidget(wrap(LeadingAvatar(username: 'John Doe', thumbnailUrl: photo, radius: 40)));

      expect(tester.widget<SafeNetworkImage>(find.byType(SafeNetworkImage)).url, requested);
    });

    testWidgets('leaves a non-Gravatar url alone', (tester) async {
      const url = 'https://example.com/photo.png';
      await tester.pumpWidget(wrap(LeadingAvatar(username: 'John Doe', thumbnailUrl: Uri.parse(url), radius: 37)));

      expect(tester.widget<SafeNetworkImage>(find.byType(SafeNetworkImage)).url, url);
    });
  });

  group('LeadingAvatar badge slot', () {
    testWidgets('renders the injected badge over the avatar', (tester) async {
      const badgeKey = Key('badge');

      await tester.pumpWidget(
        wrap(
          const LeadingAvatar(
            username: 'John Doe',
            badge: SizedBox(key: badgeKey),
          ),
        ),
      );

      expect(find.descendant(of: find.byType(LeadingAvatar), matching: find.byKey(badgeKey)), findsOneWidget);
    });

    testWidgets('hands the status badge the avatar diameter', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: PresenceViewParams(
              hybridPresenceSupport: false,
              blfViaSipSupport: false,
              presenceViaSipSupport: false,
              child: Center(
                child: LeadingAvatar(
                  username: 'John Doe',
                  radius: 20,
                  badge: AvatarStatusBadge.maybe(registered: true),
                ),
              ),
            ),
          ),
        ),
      );

      final dot = find.descendant(of: find.byType(AvatarStatusBadge), matching: find.byType(Container));
      final avatar = tester.getRect(find.byType(LeadingAvatar));

      // The slot hands over the whole avatar square: the dot is sized from it
      // and placed on its edge, which is only possible if it knows the size.
      expect(tester.getSize(dot), Size(avatar.width * 0.4, avatar.width * 0.4));
      final reach = (tester.getRect(dot).center - avatar.center).distance;
      expect(reach, closeTo(avatar.width / 2, 0.01));
      expect(tester.getRect(dot).right, greaterThan(avatar.right));
    });
  });
}
