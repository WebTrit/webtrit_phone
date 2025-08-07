import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/notifications/bloc/notifications_bloc.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/cubit/call_routing_cubit.dart';
import 'package:webtrit_phone/features/messaging/extensions/contact.dart';
import 'package:webtrit_phone/features/user_info/cubit/user_info_cubit.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/favorite.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../favorites.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    super.key,
    this.title,
    required this.transferEnabled,
    required this.videoEnabled,
    required this.chatsEnabled,
    required this.smssEnabled,
  });

  final Widget? title;
  final bool transferEnabled;
  final bool videoEnabled;
  final bool chatsEnabled;
  final bool smssEnabled;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // TODO(Serdun): Think about moving this to a controller or bloc.
  late final CallController _callController = CallController(
    callBloc: context.read<CallBloc>(),
    callRoutingCubit: context.read<CallRoutingCubit>(),
    notificationsBloc: context.read<NotificationsBloc>(),
  );

  void submitTransfer({required String destination}) {
    _callController.submitTransfer(destination);
    context.router.maybePop();
  }

  void openChat(String userId) {
    final route = ChatConversationScreenPageRoute(
      participantId: userId,
    );
    context.router.navigate(route);
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

  void openContact({required int contactId}) {
    context.router.navigate(ContactScreenPageRoute(contactId: contactId));
  }

  void openCallLog({required String number}) {
    context.router.navigate(CallLogScreenPageRoute(number: number));
  }

  void delete({required Favorite favorite}) {
    context.showSnackBar(context.l10n.favorites_SnackBar_deleted(favorite.name));
    context.read<FavoritesBloc>().add(FavoritesRemoved(favorite: favorite));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: widget.title,
        context: context,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final favorites = state.favorites;
          if (favorites == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (favorites.isEmpty) {
              return NoDataPlaceholder(
                content: Text(context.l10n.favorites_BodyCenter_empty),
              );
            } else {
              return BlocBuilder<UserInfoCubit, UserInfoState>(
                builder: (context, userInfoState) {
                  final userSmsNumbers = userInfoState.userInfo?.numbers.sms ?? [];

                  return BlocBuilder<CallBloc, CallState>(
                    buildWhen: (previous, current) =>
                        previous.isBlingTransferInitiated != current.isBlingTransferInitiated ||
                        previous.activeCalls != current.activeCalls,
                    builder: (context, callState) {
                      final blingTransferInitiated = callState.isBlingTransferInitiated;
                      final hasActiveCall = callState.activeCalls.isNotEmpty;

                      return BlocBuilder<CallRoutingCubit, CallRoutingState?>(
                        builder: (context, callRoutingState) {
                          return ListView.builder(
                            itemCount: favorites.length,
                            itemBuilder: (context, index) {
                              final favorite = favorites[index];
                              final contact = favorite.contact;
                              final contactSourceId = contact.sourceId;
                              final contactSmsNumbers = contact.smsNumbers;
                              final canSendSms = contactSmsNumbers.contains(favorite.number);

                              return FavoriteTile(
                                key: favoriteTileKey,
                                favorite: favorite,
                                callNumbers: callRoutingState?.allNumbers ?? [],
                                onTap: blingTransferInitiated
                                    ? () {
                                        submitTransfer(destination: favorite.number);
                                      }
                                    : () {
                                        _callController.createCall(
                                            destination: favorite.number, displayName: favorite.name);
                                      },
                                onAudioCallPressed: () {
                                  _callController.createCall(
                                      destination: favorite.number, displayName: favorite.name, video: false);
                                },
                                onVideoCallPressed: widget.videoEnabled
                                    ? () {
                                        _callController.createCall(
                                            destination: favorite.number, displayName: favorite.name, video: true);
                                      }
                                    : null,
                                onTransferPressed: widget.transferEnabled && hasActiveCall
                                    ? () {
                                        submitTransfer(destination: favorite.number);
                                      }
                                    : null,
                                onChatPressed: widget.chatsEnabled && contact.canMessage
                                    ? () {
                                        openChat(contactSourceId!);
                                      }
                                    : null,
                                onSendSmsPressed: widget.smssEnabled && userSmsNumbers.isNotEmpty && canSendSms
                                    ? () {
                                        sendSms(
                                          userSmsNumbers: userSmsNumbers,
                                          contactPhoneNumber: favorite.number,
                                          contactSourceId: contactSourceId,
                                        );
                                      }
                                    : null,
                                onViewContactPressed: () => openContact(contactId: contact.id),
                                onCallLogPressed: () => openCallLog(number: favorite.number),
                                onDelete: () => delete(favorite: favorite),
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
        },
      ),
      bottomNavigationBar: BlocBuilder<CallBloc, CallState>(
        buildWhen: (previous, current) => previous.isBlingTransferInitiated != current.isBlingTransferInitiated,
        builder: (context, callState) {
          if (callState.isBlingTransferInitiated) {
            return TransferBottomNavigationBar(context.l10n.favorites_Text_blingTransferInitiated);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
