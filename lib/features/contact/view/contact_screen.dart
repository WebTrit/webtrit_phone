import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/features/messaging/extensions/contact.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contact.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({
    super.key,
    required this.favoriteVisible,
    required this.transferVisible,
    required this.videoVisible,
    required this.chatsEnabled,
  });

  final bool favoriteVisible;
  final bool transferVisible;
  final bool videoVisible;
  final bool chatsEnabled;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        final contact = state.contact;
        final contactPhones = state.contactPhones;
        final contactEmails = state.contactEmails;
        if (contact == null || contactPhones == null || contactEmails == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return BlocBuilder<CallBloc, CallState>(
            buildWhen: (previous, current) => previous.isBlingTransferInitiated != current.isBlingTransferInitiated,
            builder: (context, callState) {
              final email = contactEmails.firstOrNull?.address;
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    if (chatsEnabled && contact.canMessage)
                      IconButton(
                        icon: const Icon(Icons.message),
                        onPressed: () {
                          context.router.navigate(ChatConversationScreenPageRoute(participantId: contact.sourceId));
                        },
                      ),
                  ],
                ),
                body: ListView(
                  children: [
                    Container(
                      padding: kAllPadding16,
                      alignment: Alignment.center,
                      child: LeadingAvatar(
                        username: contact.displayTitle,
                        thumbnail: contact.thumbnail,
                        thumbnailUrl: contact.thumbnailUrl ?? gravatarThumbnailUrl(email),
                        registered: contact.registered,
                        radius: 50,
                      ),
                    ),
                    Text(
                      contact.displayTitle,
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
                        favoriteVisible: favoriteVisible,
                        transferVisible: transferVisible,
                        videoVisible: videoVisible,
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
                            displayName: contact.maybeName,
                            video: false,
                          ));
                          context.router.maybePop();
                        },
                        onVideoPressed: () {
                          final callBloc = context.read<CallBloc>();
                          callBloc.add(CallControlEvent.started(
                            number: contactPhone.number,
                            displayName: contact.maybeName,
                            video: true,
                          ));
                          context.router.maybePop();
                        },
                        onTransferPressed: () {
                          final callBloc = context.read<CallBloc>();
                          callBloc.add(CallControlEvent.blindTransferSubmitted(
                            number: contactPhone.number,
                          ));
                          context.router.maybePop();
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
                ),
              );
            },
          );
        }
      },
    );
  }
}
