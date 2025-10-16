import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'cdr_tile.dart';

class MissedRecentCdrsList extends StatefulWidget {
  const MissedRecentCdrsList({
    this.title,
    required this.transferEnabled,
    required this.videoEnabled,
    required this.chatsEnabled,
    required this.smssEnabled,
    super.key,
  });

  final bool transferEnabled;
  final bool videoEnabled;
  final bool chatsEnabled;
  final bool smssEnabled;

  final Widget? title;

  @override
  State<MissedRecentCdrsList> createState() => _MissedRecentCdrsListState();
}

class _MissedRecentCdrsListState extends State<MissedRecentCdrsList> {
  late final cubit = context.read<MissedRecentCdrsCubit>();
  late final CallController _callController = CallController(
    callBloc: context.read<CallBloc>(),
    callRoutingCubit: context.read<CallRoutingCubit>(),
    notificationsBloc: context.read<NotificationsBloc>(),
  );
  late final scrollController = ScrollController();

  bool scrolledAway = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final position = scrollController.position.pixels;
      final scrollRemaining = maxScroll - position;

      const hystoryFetchScrollThreshold = 500.0;
      final shouldFetch = scrollRemaining < hystoryFetchScrollThreshold;
      final canFetch = !cubit.state.historyEndReached && !cubit.state.fetchingHistory;
      if (shouldFetch && canFetch) cubit.fetchHistory();

      const scrolledThreshold = 1000;
      final scrolledAway = position > scrolledThreshold;
      if (this.scrolledAway != scrolledAway) setState(() => this.scrolledAway = scrolledAway);
    });
  }

  void scrollToTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 600), curve: Curves.easeInOutExpo);
  }

  void submitTransfer({required String destination}) {
    final callBloc = context.read<CallBloc>();
    callBloc.add(CallControlEvent.blindTransferSubmitted(number: destination));
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
    context.router.navigate(NumberCdrsScreenPageRoute(number: number));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MissedRecentCdrsCubit, MissedRecentCdrsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.records.isEmpty) {
          return const Center(child: Text('No CDRs available'));
        }

        return BlocBuilder<UserInfoCubit, UserInfoState>(
          buildWhen: (previous, current) => previous.userInfo?.numbers.sms != current.userInfo?.numbers.sms,
          builder: (context, userInfoState) {
            final userSmsNumbers = userInfoState.userInfo?.numbers.sms ?? [];

            return BlocBuilder<CallBloc, CallState>(
              buildWhen: (previous, current) =>
                  previous.isBlingTransferInitiated != current.isBlingTransferInitiated ||
                  previous.activeCalls != current.activeCalls,
              builder: (context, callState) {
                final transfer = callState.isBlingTransferInitiated;
                final hasActiveCall = callState.activeCalls.isNotEmpty;

                return BlocBuilder<CallRoutingCubit, CallRoutingState?>(
                  buildWhen: (previous, current) => previous?.allNumbers != current?.allNumbers,
                  builder: (context, callRoutingState) {
                    final callNumbers = callRoutingState?.allNumbers ?? [];

                    return ScrollToTopOverlay(
                      scrolledAway: scrolledAway,
                      onScrollToTop: scrollToTop,
                      child: ListView.builder(
                        controller: scrollController,
                        cacheExtent: 500,
                        shrinkWrap: true,
                        itemCount: state.records.length + 1,
                        itemBuilder: (context, index) {
                          final historyIndicatorPosition = state.records.length;
                          if (index == historyIndicatorPosition) return HistoryFetchIndicator(state.fetchingHistory);
                          final cdr = state.records[index];
                          final participant = cdr.participant;
                          final participantNumber = cdr.participantNumber;

                          return FadeIn(
                            child: SizedBox(
                              key: Key(cdr.callId.toString()),
                              child: ContactInfoBuilder(
                                  source: ContactSourcePhone(participantNumber ?? participant),
                                  builder: (context, contact) {
                                    final contactSourceId = contact?.sourceId;
                                    final contactSmsNumbers = contact?.smsNumbers ?? [];
                                    final canSendSms = contactSmsNumbers.contains(participantNumber);

                                    return CdrTile(
                                      cdr: cdr,
                                      contact: contact,
                                      callNumbers: callNumbers,
                                      onTap: () {
                                        if (participantNumber == null) return;

                                        if (transfer) {
                                          submitTransfer(destination: participantNumber);
                                        } else {
                                          _callController.createCall(
                                            destination: participantNumber,
                                            displayName: contact?.maybeName,
                                          );
                                        }
                                      },
                                      onAudioCallPressed: participantNumber != null
                                          ? () => _callController.createCall(
                                                destination: participantNumber,
                                                displayName: contact?.maybeName,
                                                video: false,
                                              )
                                          : null,
                                      onVideoCallPressed: participantNumber != null && widget.videoEnabled
                                          ? () => _callController.createCall(
                                                destination: participantNumber,
                                                displayName: contact?.maybeName,
                                                video: true,
                                              )
                                          : null,
                                      onTransferPressed:
                                          participantNumber != null && widget.transferEnabled && hasActiveCall
                                              ? () {
                                                  submitTransfer(destination: participantNumber);
                                                }
                                              : null,
                                      onChatPressed: widget.chatsEnabled && (contact?.canMessage == true)
                                          ? () {
                                              openChat(contactSourceId!);
                                            }
                                          : null,
                                      onSendSmsPressed: participantNumber != null &&
                                              widget.smssEnabled &&
                                              userSmsNumbers.isNotEmpty &&
                                              canSendSms
                                          ? () {
                                              sendSms(
                                                userSmsNumbers: userSmsNumbers,
                                                contactPhoneNumber: participantNumber,
                                                contactSourceId: contactSourceId,
                                              );
                                            }
                                          : null,
                                      onViewContactPressed: contact != null
                                          ? () {
                                              openContact(contactId: contact.id);
                                            }
                                          : null,
                                      onCallLogPressed: participantNumber != null
                                          ? () => openCallLog(number: participantNumber)
                                          : null,
                                      onCallFrom: participantNumber != null
                                          ? (fromNumber) => _callController.createCall(
                                                destination: participantNumber,
                                                displayName: contact?.maybeName,
                                                fromNumber: fromNumber,
                                                video: false,
                                              )
                                          : null,
                                    );
                                  }),
                            ),
                          );
                        },
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
