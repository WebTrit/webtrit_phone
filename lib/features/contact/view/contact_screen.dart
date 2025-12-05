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
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/features/messaging/extensions/contact.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../contact.dart';

final _logger = Logger('ContactScreen');

class ContactScreen extends StatefulWidget {
  const ContactScreen({
    super.key,
    required this.enableAppBarChat,
    required this.enableTileFavorite,
    required this.enableTileVoiceCall,
    required this.enableTileVideoCall,
    required this.enableTileSms,
    required this.enableTileChat,
    required this.enableTileTransfer,
    required this.enableTileCallLog,
    required this.enableTileEmail,
    required this.useCdrsForHistory,
  });

  final bool enableAppBarChat;
  final bool enableTileFavorite;
  final bool enableTileVoiceCall;
  final bool enableTileVideoCall;
  final bool enableTileSms;
  final bool enableTileChat;
  final bool enableTileTransfer;
  final bool enableTileCallLog;
  final bool enableTileEmail;
  final bool useCdrsForHistory;

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late final CallController _callController = CallController(
    callBloc: context.read<CallBloc>(),
    callRoutingCubit: context.read<CallRoutingCubit>(),
    notificationsBloc: context.read<NotificationsBloc>(),
  );

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final presenceSource = PresenceViewParams.of(context).viewSource;

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
                          if (widget.enableAppBarChat && contact.canMessage)
                            IconButton(
                              icon: Icon(Icons.message, color: colorScheme.onSurface),
                              onPressed: () => _navigateToChatConversation(contact),
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
                              radius: 50,
                            ),
                          ),
                          Text(
                            contact.displayTitle,
                            style: themeData.textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          const Divider(height: 16),
                          SizedBox(
                            key: ValueKey(contact.mobilePhone),
                            child: ContactPhoneTile(
                              key: contactPhoneTileKey,
                              number: contact.mobilePhone?.number ?? 'Unknown',
                              label: contact.mobilePhone?.label ?? 'mobile',
                              favorite: contact.mobilePhone?.favorite ?? false,
                              callNumbers: callRoutingState?.allNumbers ?? [],
                              onFavoriteChanged: contact.mobilePhone != null && widget.favoriteEnabled
                                  ? (isFavorite) {
                                      toggleFavorite(isFavorite: isFavorite, contactPhone: contact.mobilePhone!);
                                    }
                                  : null,
                              onAudioPressed: contact.mobilePhone != null
                                  ? () => _callController.createCall(
                                      destination: contact.mobilePhone!.number,
                                      displayName: contact.maybeName,
                                      video: false,
                                    )
                                  : null,
                              onVideoPressed: contact.mobilePhone != null && widget.videoEnabled
                                  ? () => _callController.createCall(
                                      destination: contact.mobilePhone!.number,
                                      displayName: contact.maybeName,
                                      video: true,
                                    )
                                  : null,
                              onTransferPressed: contact.mobilePhone != null && widget.transferEnabled && hasActiveCall
                                  ? () {
                                      _callController.submitTransfer(contact.mobilePhone!.number);
                                      context.router.maybePop();
                                    }
                                  : null,
                              onInitiatedTransferPressed:
                                  contact.mobilePhone != null &&
                                      widget.transferEnabled &&
                                      callState.isBlingTransferInitiated
                                  ? () {
                                      _callController.submitTransfer(contact.mobilePhone!.number);
                                      context.router.maybePop();
                                    }
                                  : null,
                              onSendSmsPressed:
                                  contact.mobilePhone != null &&
                                      widget.smsEnabled &&
                                      contactSmsNumbers.contains(contact.mobilePhone!.number)
                                  ? () => sendSms(
                                      userSmsNumbers: userSmsNumbers,
                                      contactPhoneNumber: contact.mobilePhone!.number,
                                      contactSourceId: contactSourceId,
                                    )
                                  : null,
                              onCallLogPressed: contact.mobilePhone != null
                                  ? () => openCallLog(number: contact.mobilePhone!.number)
                                  : null,
                              onCallFrom: (fromNumber) => _callController.createCall(
                                destination: contact.mobilePhone!.number,
                                displayName: contact.maybeName,
                                fromNumber: fromNumber,
                              ),
                            ),
                          ),
                          for (final contactPhone in contact.additionalNumbers)
                            SizedBox(
                              key: ValueKey(contactPhone),
                              child: ContactPhoneTile(
                                key: contactPhoneTileKey,
                                number: contactPhone.number,
                                label: contactPhone.label,
                                favorite: contactPhone.favorite,
                                callNumbers: callRoutingState?.allNumbers ?? [],
                                onFavoriteChanged: widget.enableTileFavorite
                                    ? (isFavorite) => _onFavoriteChanged(isFavorite, contactPhone)
                                    : null,
                                onAudioPressed: widget.enableTileVoiceCall
                                    ? () => _onAudioPressed(contactPhone, contact)
                                    : null,
                                onVideoPressed: widget.enableTileVideoCall
                                    ? () => _onVideoPressed(contactPhone, contact)
                                    : null,
                                onTransferPressed: widget.enableTileTransfer && hasActiveCall
                                    ? () => _onTransferPressed(contactPhone)
                                    : null,
                                onInitiatedTransferPressed:
                                    widget.enableTileTransfer && callState.isBlingTransferInitiated
                                    ? () => _onTransferPressed(contactPhone)
                                    : null,
                                onSendSmsPressed:
                                    widget.enableTileSms && contactSmsNumbers.contains(contactPhone.number)
                                    ? () => _onSendSmsPressed(contactPhone, contactSourceId, userSmsNumbers)
                                    : null,
                                onMessagePressed: widget.enableTileChat && contact.canMessage
                                    ? () => _navigateToChatConversation(contact)
                                    : null,
                                onCallLogPressed: widget.enableTileCallLog
                                    ? () => _onCallLogPressed(contactPhone.number)
                                    : null,
                                onCallFrom: (fromNumber) => _onCallFromPressed(contactPhone, contact, fromNumber),
                              ),
                            ),
                          if (contact.extensionPhone != null)
                            SizedBox(
                              key: ValueKey(contact.extensionPhone),
                              child: ContactPhoneTile(
                                key: contactPhoneTileKey,
                                number: contact.extensionPhone!.number,
                                label: contact.extensionPhone!.label,
                                favorite: contact.extensionPhone!.favorite,
                                callNumbers: callRoutingState?.allNumbers ?? [],
                                onFavoriteChanged: widget.favoriteEnabled
                                    ? (isFavorite) {
                                        toggleFavorite(isFavorite: isFavorite, contactPhone: contact.extensionPhone!);
                                      }
                                    : null,
                                onAudioPressed: () => _callController.createCall(
                                  destination: contact.extensionPhone!.number,
                                  displayName: contact.maybeName,
                                  video: false,
                                ),
                                onVideoPressed: widget.videoEnabled
                                    ? () => _callController.createCall(
                                        destination: contact.extensionPhone!.number,
                                        displayName: contact.maybeName,
                                        video: true,
                                      )
                                    : null,
                                onTransferPressed: widget.transferEnabled && hasActiveCall
                                    ? () {
                                        _callController.submitTransfer(contact.extensionPhone!.number);
                                        context.router.maybePop();
                                      }
                                    : null,
                                onInitiatedTransferPressed: widget.transferEnabled && callState.isBlingTransferInitiated
                                    ? () {
                                        _callController.submitTransfer(contact.extensionPhone!.number);
                                        context.router.maybePop();
                                      }
                                    : null,
                                onSendSmsPressed:
                                    widget.smsEnabled && contactSmsNumbers.contains(contact.extensionPhone!.number)
                                    ? () => sendSms(
                                        userSmsNumbers: userSmsNumbers,
                                        contactPhoneNumber: contact.extensionPhone!.number,
                                        contactSourceId: contactSourceId,
                                      )
                                    : null,
                                onCallLogPressed: () => openCallLog(number: contact.extensionPhone!.number),
                                onCallFrom: (fromNumber) => _callController.createCall(
                                  destination: contact.extensionPhone!.number,
                                  displayName: contact.maybeName,
                                  fromNumber: fromNumber,
                                ),
                              ),
                            ),
                          for (final contactEmail in contact.emails)
                            ContactEmailTile(
                              address: contactEmail.address,
                              label: contactEmail.label,
                              onEmailPressed: widget.enableTileEmail ? () => _onEmailPressed(contactEmail) : null,
                            ),
                          if (presenceSource == PresenceViewSource.sipPresence &&
                              contact.sourceType == ContactSourceType.external) ...[
                            const Divider(),
                            PresenceInfoView(presenceInfo: contact.presenceInfo),
                          ],
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

  void _onFavoriteChanged(bool isFavorite, ContactPhone contactPhone) {
    if (isFavorite) {
      context.read<ContactBloc>().add(ContactAddedToFavorites(contactPhone));
    } else {
      context.read<ContactBloc>().add(ContactRemovedFromFavorites(contactPhone));
    }
  }

  void _onAudioPressed(ContactPhone phone, Contact contact) {
    _callController.createCall(destination: phone.number, displayName: contact.maybeName, video: false);
  }

  void _onVideoPressed(ContactPhone phone, Contact contact) {
    _callController.createCall(destination: phone.number, displayName: contact.maybeName, video: true);
  }

  void _onTransferPressed(ContactPhone phone) {
    _callController.submitTransfer(phone.number);
    context.router.maybePop();
  }

  void _onCallFromPressed(ContactPhone phone, Contact contact, String fromNumber) {
    _callController.createCall(destination: phone.number, displayName: contact.maybeName, fromNumber: fromNumber);
  }

  void _onSendSmsPressed(ContactPhone phone, String? contactSourceId, List<String> userSmsNumbers) {
    if (userSmsNumbers.isEmpty) return;

    final route = SmsConversationScreenPageRoute(
      firstNumber: userSmsNumbers.first,
      secondNumber: phone.number,
      recipientId: contactSourceId,
    );
    context.router.navigate(route);
  }

  void _onCallLogPressed(String number) {
    if (widget.useCdrsForHistory) {
      context.router.navigate(NumberCdrsScreenPageRoute(number: number));
    } else {
      context.router.navigate(CallLogScreenPageRoute(number: number));
    }
  }

  void _navigateToChatConversation(Contact contact) {
    context.router.navigate(ChatConversationScreenPageRoute(participantId: contact.sourceId));
  }

  void _onEmailPressed(ContactEmail email) {
    context.read<ContactBloc>().add(ContactEmailSend(email));
  }

  void _onContactDeleted() {
    _logger.info('Contact was deleted, popping screen');
    context.router.maybePop();
  }
}
