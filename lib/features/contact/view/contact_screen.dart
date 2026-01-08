import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';
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
import '../extensions/extensions.dart';

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

            final displayPhones = contact.displayPhones;

            return BlocBuilder<CallBloc, CallState>(
              buildWhen: (previous, current) =>
                  previous.isBlingTransferInitiated != current.isBlingTransferInitiated ||
                  previous.activeCalls != current.activeCalls,
              builder: (context, callState) {
                final email = contact.emails.firstOrNull?.address;
                final hasActiveCall = callState.activeCalls.isNotEmpty;
                final isBlingTransferInitiated = callState.isBlingTransferInitiated;

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
                          for (final contactPhone in displayPhones)
                            ContactPhoneTileAdapter(
                              contactPhone: contactPhone,
                              contact: contact,
                              enableTileFavorite: widget.enableTileFavorite,
                              enableTileVoiceCall: widget.enableTileVoiceCall,
                              enableTileVideoCall: widget.enableTileVideoCall,
                              enableTileSms: widget.enableTileSms,
                              enableTileChat: widget.enableTileChat,
                              enableTileTransfer: widget.enableTileTransfer,
                              enableTileCallLog: widget.enableTileCallLog,
                              contactSmsNumbers: contactSmsNumbers,
                              contactSourceId: contactSourceId,
                              userSmsNumbers: userSmsNumbers,
                              hasActiveCall: hasActiveCall,
                              isBlingTransferInitiated: isBlingTransferInitiated,
                              callRoutingState: callRoutingState,
                              onFavoriteChanged: _onFavoriteChanged,
                              onAudioPressed: _onAudioPressed,
                              onVideoPressed: _onVideoPressed,
                              onTransferPressed: _onTransferPressed,
                              onSendSmsPressed: _onSendSmsPressed,
                              onCallLogPressed: _onCallLogPressed,
                              onNavigateToChatConversation: _navigateToChatConversation,
                              onCallFromPressed: _onCallFromPressed,
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
