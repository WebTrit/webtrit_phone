import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/messaging/extensions/contact.dart';
import 'package:webtrit_phone/features/user_info/cubit/user_info_cubit.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../favorites.dart';

class FavoritesScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: title,
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

                      return ListView.builder(
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          final favorite = favorites[index];
                          final contact = favorite.contact;
                          final contactSourceId = contact.sourceId;
                          final contactSmsNumbers = contact.smsNumbers;
                          final canSendSms = contactSmsNumbers.contains(favorite.number);

                          return FavoriteTile(
                            favorite: favorite,
                            onTap: blingTransferInitiated
                                ? () {
                                    final callBloc = context.read<CallBloc>();
                                    callBloc.add(CallControlEvent.blindTransferSubmitted(
                                      number: favorite.number,
                                    ));
                                  }
                                : () {
                                    final callBloc = context.read<CallBloc>();
                                    callBloc.add(CallControlEvent.started(
                                      number: favorite.number,
                                      displayName: favorite.name,
                                      video: false,
                                    ));
                                  },
                            onAudioCallPressed: () {
                              final callBloc = context.read<CallBloc>();
                              callBloc.add(CallControlEvent.started(
                                number: favorite.number,
                                displayName: favorite.name,
                                video: false,
                              ));
                            },
                            onVideoCallPressed: videoEnabled
                                ? () {
                                    final callBloc = context.read<CallBloc>();
                                    callBloc.add(CallControlEvent.started(
                                      number: favorite.number,
                                      displayName: favorite.name,
                                      video: true,
                                    ));
                                  }
                                : null,
                            onTransferPressed: transferEnabled && hasActiveCall
                                ? () {
                                    final callBloc = context.read<CallBloc>();
                                    callBloc.add(CallControlEvent.blindTransferSubmitted(
                                      number: favorite.number,
                                    ));
                                  }
                                : null,
                            onChatPressed: chatsEnabled && contact.canMessage
                                ? () {
                                    final route = ChatConversationScreenPageRoute(
                                      participantId: contactSourceId!,
                                    );
                                    context.router.navigate(route);
                                  }
                                : null,
                            onSendSmsPressed: smssEnabled && userSmsNumbers.isNotEmpty && canSendSms
                                ? () {
                                    final route = SmsConversationScreenPageRoute(
                                      firstNumber: userSmsNumbers.first,
                                      secondNumber: favorite.number,
                                      recipientId: contactSourceId!,
                                    );
                                    context.router.navigate(route);
                                  }
                                : null,
                            onViewContactPressed: () {
                              context.router.navigate(ContactScreenPageRoute(contactId: contact.id));
                            },
                            onCallLogPressed: () {
                              context.router.navigate(CallLogScreenPageRoute(number: favorite.number));
                            },
                            onDelete: () {
                              context.showSnackBar(context.l10n.favorites_SnackBar_deleted(favorite.name));
                              context.read<FavoritesBloc>().add(FavoritesRemoved(favorite: favorite));
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
