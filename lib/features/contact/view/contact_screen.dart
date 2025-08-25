import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
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

final _logger = Logger('ContactScreen');

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
  // TODO(Serdun): Think about moving this to a controller or bloc.
  late final CallController _callController = CallController(
    callBloc: context.read<CallBloc>(),
    callRoutingCubit: context.read<CallRoutingCubit>(),
    notificationsBloc: context.read<NotificationsBloc>(),
  );

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

        return BlocConsumer<ContactBloc, ContactState>(
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
                            SizedBox(
                              key: ValueKey(contactPhone),
                              child: ContactPhoneTile(
                                key: contactPhoneTileKey,
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
                                onAudioPressed: () => _callController.createCall(
                                  destination: contactPhone.number,
                                  displayName: contact.maybeName,
                                  video: false,
                                ),
                                onVideoPressed: widget.videoEnabled
                                    ? () => _callController.createCall(
                                          destination: contactPhone.number,
                                          displayName: contact.maybeName,
                                          video: true,
                                        )
                                    : null,
                                onTransferPressed: widget.transferEnabled && hasActiveCall
                                    ? () {
                                        _callController.submitTransfer(contactPhone.number);
                                        context.router.maybePop();
                                      }
                                    : null,
                                onInitiatedTransferPressed: widget.transferEnabled && callState.isBlingTransferInitiated
                                    ? () {
                                        _callController.submitTransfer(contactPhone.number);
                                        context.router.maybePop();
                                      }
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
                                onCallFrom: (fromNumber) => _callController.createCall(
                                  destination: contactPhone.number,
                                  displayName: contact.maybeName,
                                  fromNumber: fromNumber,
                                ),
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
          listener: (BuildContext context, ContactState state) {
            if (state.deleted) _onContactDeleted();
          },
        );
      },
    );
  }

  /// Called when the contact is deleted outside of the app.
  ///
  /// Logs the event and safely attempts to close the screen.
  void _onContactDeleted() {
    _logger.info('Contact was deleted, popping screen');
    context.router.maybePop();
  }
}
