import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

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
            return BlocBuilder<CallBloc, CallState>(
              buildWhen: (previous, current) => previous.isBlingTransferInitiated != current.isBlingTransferInitiated,
              builder: (context, callState) {
                return ListView(
                  children: [
                    Padding(
                      padding: kAllPadding16,
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
                        number: contactPhone.number,
                        label: contactPhone.label,
                        favorite: contactPhone.favorite,
                        transfer: callState.isBlingTransferInitiated,
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
                          context.router.pop();
                        },
                        onVideoPressed: () {
                          final callBloc = context.read<CallBloc>();
                          callBloc.add(CallControlEvent.started(
                            number: contactPhone.number,
                            displayName: contact.name,
                            video: true,
                          ));
                          context.router.pop();
                        },
                        onTransferPressed: () {
                          final callBloc = context.read<CallBloc>();
                          callBloc.add(CallControlEvent.blindTransferSubmitted(
                            number: contactPhone.number,
                          ));
                          context.router.pop();
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
              },
            );
          }
        },
      ),
    );
  }
}
