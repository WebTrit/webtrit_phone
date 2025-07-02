import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/bloc/notifications_bloc.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/cubit/call_routing_cubit.dart';
import 'package:webtrit_phone/features/user_info/cubit/user_info_cubit.dart';
import 'package:webtrit_phone/models/contact_phone.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/features/messaging/extensions/contact.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contact.dart';

class ContactScreen extends StatefulWidget {
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
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  void toggleFavorite({
    required bool isFavorite,
    required ContactPhone contactPhone,
  }) {
    if (isFavorite) {
      context.read<ContactBloc>().add(ContactAddedToFavorites(contactPhone));
    } else {
      context.read<ContactBloc>().add(ContactRemovedFromFavorites(contactPhone));
    }
  }

  void createCall({
    required String destination,
    String? displayName,
    bool video = false,
    String? fromNumber,
  }) {
    final callRoutingCubit = context.read<CallRoutingCubit>();
    final callRoutingState = callRoutingCubit.state;
    if (callRoutingState == null) return;

    /// For cases when user sets additional number for outgoing calls by default
    /// and wants to call from main number explicitly using dropdown menu.
    final shouldUseMainLine = fromNumber == callRoutingState.mainNumber;
    if (shouldUseMainLine) {
      fromNumber = null;
    } else {
      // Apply caller ID settings to determine the `from` number if not specified.
      fromNumber ??= callRoutingCubit.getFromNumber(destination);
    }

    final hasIdleMainLine = callRoutingState.hasIdleMainLine;
    final hasIdleGuestLine = callRoutingState.hasIdleGuestLine;
    if ((fromNumber == null && !hasIdleMainLine) || (fromNumber != null && !hasIdleGuestLine)) {
      final notificationsBloc = context.read<NotificationsBloc>();
      const notification = CallUndefinedLineNotification();
      notificationsBloc.add(const NotificationsSubmitted(notification));
      return;
    }

    final callBloc = context.read<CallBloc>();
    callBloc.add(CallControlEvent.started(
      number: destination,
      video: video,
      displayName: displayName,
      fromNumber: fromNumber,
    ));
  }

  void submitTransfer({required String destination}) {
    final callBloc = context.read<CallBloc>();
    callBloc.add(CallControlEvent.blindTransferSubmitted(number: destination));
    context.router.maybePop();
  }

  void sendSms({
    required List<String> userSmsNumbers,
    required String contactPhoneNumber,
    required String? contactSourceId,
  }) {
    final route = SmsConversationScreenPageRoute(
      firstNumber: userSmsNumbers.first,
      secondNumber: contactPhoneNumber,
      recipientId: contactSourceId!,
    );
    context.router.navigate(route);
  }

  void openCallLog({required String number}) {
    context.router.navigate(CallLogScreenPageRoute(number: number));
  }

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

                return BlocBuilder<CallRoutingCubit, CallRoutingState?>(
                  builder: (context, callRoutingState) {
                    return Scaffold(
                      appBar: AppBar(
                        actions: [
                          if (widget.chatsEnabled && contact.canMessage)
                            IconButton(
                              icon: Icon(
                                Icons.message,
                                color: colorScheme.onSurface,
                              ),
                              onPressed: () {
                                context.router
                                    .navigate(ChatConversationScreenPageRoute(participantId: contact.sourceId));
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
                              number: contactPhone.number,
                              label: contactPhone.label,
                              favorite: contactPhone.favorite,
                              callNumbers: callRoutingState?.allNumbers ?? [],
                              onFavoriteChanged: widget.favoriteEnabled
                                  ? (isFavorite) {
                                      toggleFavorite(
                                        isFavorite: isFavorite,
                                        contactPhone: contactPhone,
                                      );
                                    }
                                  : null,
                              onAudioPressed: () => createCall(
                                destination: contactPhone.number,
                                displayName: contact.maybeName,
                                video: false,
                              ),
                              onVideoPressed: widget.videoEnabled
                                  ? () => createCall(
                                        destination: contactPhone.number,
                                        displayName: contact.maybeName,
                                        video: true,
                                      )
                                  : null,
                              onTransferPressed: widget.transferEnabled && hasActiveCall
                                  ? () => submitTransfer(
                                        destination: contactPhone.number,
                                      )
                                  : null,
                              onInitiatedTransferPressed: widget.transferEnabled && callState.isBlingTransferInitiated
                                  ? () => submitTransfer(
                                        destination: contactPhone.number,
                                      )
                                  : null,
                              onSendSmsPressed: widget.smsEnabled && contactSmsNumbers.contains(contactPhone.number)
                                  ? () => sendSms(
                                        userSmsNumbers: userSmsNumbers,
                                        contactPhoneNumber: contactPhone.number,
                                        contactSourceId: contactSourceId,
                                      )
                                  : null,
                              onCallLogPressed: () => openCallLog(
                                number: contactPhone.number,
                              ),
                              onCallFrom: (fromNumber) => createCall(
                                destination: contactPhone.number,
                                displayName: contact.maybeName,
                                fromNumber: fromNumber,
                              ),
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
      },
    );
  }
}
