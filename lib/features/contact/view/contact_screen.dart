import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone_number/webtrit_phone_number.dart';

import '../../call/call.dart';
import '../contact.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          final contact = state.contact;
          final contactPhones = state.contactPhones;
          final contactEmails = state.contactEmails;
          if (contact == null || contactPhones == null || contactEmails == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final themeData = Theme.of(context);
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LeadingAvatar(
                    username: contact.name,
                    radius: 50,
                  ),
                ),
                Text(
                  contact.name,
                  style: themeData.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const Divider(
                  height: 16,
                ),
                for (final contactPhone in contactPhones)
                  ContactPhoneTile(
                    number: PhoneParser.normalize(contactPhone.number),
                    label: contactPhone.label,
                    favorite: contactPhone.favorite,
                    onFavoriteChanged: (favorite) {
                      if (favorite) {
                        context.read<ContactBloc>().add(ContactAddedToFavorites(contactPhone));
                      } else {
                        context.read<ContactBloc>().add(ContactRemovedFromFavorites(contactPhone));
                      }
                    },
                    onAudioPressed: () {
                      final callBloc = context.read<CallBloc>();
                      callBloc.add(CallControlEvent.started(
                        number: contactPhone.number,
                        displayName: contact.name,
                        video: false,
                      ));
                      context.pop();
                    },
                    onVideoPressed: () {
                      final callBloc = context.read<CallBloc>();
                      callBloc.add(CallControlEvent.started(
                        number: contactPhone.number,
                        displayName: contact.name,
                        video: true,
                      ));
                      context.pop();
                    },
                  ),
                for (final contactEmail in contactEmails)
                  ContactEmailTile(
                    address: contactEmail.address,
                    label: contactEmail.label,
                    onEmailPressed: () {
                      context.read<ContactBloc>().add(ContactEmailSend(contactEmail));
                    },
                  )
              ],
            );
          }
        },
      ),
    );
  }
}
