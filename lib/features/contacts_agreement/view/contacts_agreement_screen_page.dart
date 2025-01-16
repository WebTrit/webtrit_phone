import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'contacts_agreement_screen.dart';

@RoutePage()
class ContactsAgreementScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ContactsAgreementScreenPage();

  @override
  Widget build(BuildContext context) {
    const screen = ContactsAgreementScreen();
    return screen;
  }
}
