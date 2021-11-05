import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../contact.dart';

class ContactPage extends StatelessWidget {
  const ContactPage(this.contact, {Key? key}) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ContactCubit(
          contact,
          contactsRepository: context.read<ContactsRepository>(),
        )..getContactPhones();
      },
      child: const ContactScaffold(),
    );
  }
}
