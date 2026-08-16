import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/contact/contact.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'contact_screen_harness.dart';

void main() {
  late ContactScreenHarness harness;

  setUp(() => harness = ContactScreenHarness());

  Future<void> openPhoneMenu(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
  }

  group('sending an SMS from the contact card', () {
    testWidgets('is offered when both sides have a number for it', (tester) async {
      harness.withUserSmsNumbers(['2002']);

      await harness.pump(
        tester,
        contact: buildContact(number: '1001', label: 'sms'),
      );
      await openPhoneMenu(tester);

      expect(find.text('Send sms message'), findsOneWidget);
    });

    testWidgets('is not offered when the account has no number to send from', (tester) async {
      // The action used to be listed anyway and simply did nothing when
      // pressed: the screen dropped the request because there was no sender.
      await harness.pump(
        tester,
        contact: buildContact(number: '1001', label: 'sms'),
      );
      await openPhoneMenu(tester);

      expect(find.text('Send sms message'), findsNothing);
    });
  });

  group('options of the contact card', () {
    testWidgets('are hidden while the backend offers no subscription', (tester) async {
      await harness.pump(tester, contact: buildContact());

      expect(find.byType(ContactSipSubscriptionOption), findsNothing);
    });

    testWidgets('a press anywhere on the row turns the option on', (tester) async {
      // Only the small box answered a press before, so the caption next to it
      // looked switchable and was not.
      await harness.pump(tester, contact: buildContact(), dialogsViaSip: true);

      await tester.tap(find.text('Subscribe to active calls via SIP (BLF/Dialogs)'));
      await tester.pump();

      verify(
        () => harness.contactBloc.add(const ContactSipSubscriptionToggled(true, SipSubscriptionType.blf)),
      ).called(1);
    });

    testWidgets('a press on a row already on turns it off', (tester) async {
      final contact = buildContact(
        sipSubscriptions: [
          SipSubscription(
            type: SipSubscriptionType.blf,
            number: '1001',
            contactUserId: 'user-1',
            subscribedAt: DateTime(2024),
          ),
        ],
      );

      await harness.pump(tester, contact: contact, dialogsViaSip: true);

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      verify(
        () => harness.contactBloc.add(const ContactSipSubscriptionToggled(false, SipSubscriptionType.blf)),
      ).called(1);
    });

    testWidgets('the row is tall enough to be hit', (tester) async {
      await harness.pump(tester, contact: buildContact(), dialogsViaSip: true);

      // The whole row answers the press, so its height is the target height.
      expect(tester.getSize(find.byType(AgreementCheckbox)).height, greaterThanOrEqualTo(48));
    });

    testWidgets('the info button opens the explanation and keeps it up', (tester) async {
      await harness.pump(tester, contact: buildContact(), presenceViaSip: true);

      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();

      // The explanation used to be a tooltip that took itself away after ten
      // seconds; it now waits to be dismissed, and says which option it is about.
      expect(find.text('Subscribe to user status via SIP (Presence)'), findsWidgets);
      expect(find.textContaining('subscribe via SIP-Presence'), findsOneWidget);

      await tester.pump(const Duration(seconds: 30));
      expect(find.textContaining('subscribe via SIP-Presence'), findsOneWidget);

      await tester.tap(find.text('Ok'));
      await tester.pumpAndSettle();
      expect(find.textContaining('subscribe via SIP-Presence'), findsNothing);
    });
  });
}
