import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/user_info/cubit/user_info_cubit.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/features/messaging/extensions/contact.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contact.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({
    super.key,
    required this.favoriteEnabled,
    required this.transferEnabled,
    required this.videoEnabled,
    required this.chatsEnabled,
    required this.smsEnabled,
  });

  final bool favoriteEnabled;
  final bool transferEnabled;
  final bool videoEnabled;
  final bool chatsEnabled;
  final bool smsEnabled;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;

    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, userInfoState) {
        final userSmsNumbers = userInfoState.userInfo?.numbers.sms ?? [];

        return BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            final contact = state.contact;
            if (contact == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
            final contactSourceId = contact.sourceId;
            final contactSmsNumbers = contact.smsNumbers;

            return BlocBuilder<CallBloc, CallState>(
              buildWhen: (previous, current) =>
                  previous.isBlingTransferInitiated != current.isBlingTransferInitiated ||
                  previous.activeCalls != current.activeCalls,
              builder: (context, callState) {
                final email = contact.emails.firstOrNull?.address;
                final hasActiveCall = callState.activeCalls.isNotEmpty;

                return Scaffold(
                  appBar: AppBar(
                    actions: [
                      if (chatsEnabled && contact.canMessage)
                        IconButton(
                          icon: Icon(
                            Icons.message,
                            color: colorScheme.onSurface,
                          ),
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
                      for (final contactPhone in contact.phones)
                        ContactPhoneTile(
                          key: contactPhoneTileKey,
                          number: contactPhone.number,
                          label: contactPhone.label,
                          favorite: contactPhone.favorite,
                          onFavoriteChanged: favoriteEnabled
                              ? (favorite) {
                                  if (favorite) {
                                    context.read<ContactBloc>().add(ContactAddedToFavorites(contactPhone));
                                  } else {
                                    context.read<ContactBloc>().add(ContactRemovedFromFavorites(contactPhone));
                                  }
                                }
                              : null,
                          onAudioPressed: () {
                            final callBloc = context.read<CallBloc>();
                            callBloc.add(CallControlEvent.started(
                              number: contactPhone.number,
                              displayName: contact.maybeName,
                              video: false,
                            ));
                            context.router.maybePop();
                          },
                          onVideoPressed: videoEnabled
                              ? () {
                                  final callBloc = context.read<CallBloc>();
                                  callBloc.add(CallControlEvent.started(
                                    number: contactPhone.number,
                                    displayName: contact.maybeName,
                                    video: true,
                                  ));
                                  context.router.maybePop();
                                }
                              : null,
                          onTransferPressed: transferEnabled && hasActiveCall
                              ? () {
                                  final callBloc = context.read<CallBloc>();
                                  callBloc.add(CallControlEvent.blindTransferSubmitted(
                                    number: contactPhone.number,
                                  ));
                                  context.router.maybePop();
                                }
                              : null,
                          onInitiatedTransferPressed: transferEnabled && callState.isBlingTransferInitiated
                              ? () {
                                  final callBloc = context.read<CallBloc>();
                                  callBloc.add(CallControlEvent.blindTransferSubmitted(
                                    number: contactPhone.number,
                                  ));
                                  context.router.maybePop();
                                }
                              : null,
                          onSendSmsPressed: smsEnabled && contactSmsNumbers.contains(contactPhone.number)
                              ? () {
                                  final route = SmsConversationScreenPageRoute(
                                    firstNumber: userSmsNumbers.first,
                                    secondNumber: contactPhone.number,
                                    recipientId: contactSourceId!,
                                  );
                                  context.router.navigate(route);
                                }
                              : null,
                          onCallLogPressed: () {
                            context.router.navigate(CallLogScreenPageRoute(number: contactPhone.number));
                          },
                        ),
                      for (final contactEmail in contact.emails)
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
          },
        );
      },
    );
  }
}
