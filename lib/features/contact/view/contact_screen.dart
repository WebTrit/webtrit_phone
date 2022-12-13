import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../contact.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen(
    this.contactId, {
    super.key,
  });

  final ContactId contactId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ContactBloc(
          contactId,
          contactsRepository: context.read<ContactsRepository>(),
        )..add(const ContactStarted());
      },
      child: const ContactScaffold(),
    );
  }
}
