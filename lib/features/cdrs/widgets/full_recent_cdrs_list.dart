import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'cdr_tile.dart';

class FullRecentCdrsList extends StatefulWidget {
  const FullRecentCdrsList({
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
  State<FullRecentCdrsList> createState() => _FullRecentCdrsListState();
}

class _FullRecentCdrsListState extends State<FullRecentCdrsList> {
  late final cubit = context.read<FullRecentCdrsCubit>();
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
    return BlocBuilder<FullRecentCdrsCubit, FullRecentCdrsState>(
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
                          final number = cdr.participant;

                          return FadeIn(
                            child: SizedBox(
                              key: Key(cdr.callId.toString()),
                              child: ContactInfoBuilder(
                                  source: ContactSourcePhone(number),
                                  builder: (context, contact) {
                                    final contactSourceId = contact?.sourceId;
                                    final contactSmsNumbers = contact?.smsNumbers ?? [];
                                    final canSendSms = contactSmsNumbers.contains(number);

                                    return CdrTile(
                                      cdr: cdr,
                                      contact: contact,
                                      callNumbers: callNumbers,
                                      onTap: () {
                                        if (transfer) {
                                          submitTransfer(destination: number);
                                        } else {
                                          _callController.createCall(
                                            destination: number,
                                            displayName: contact?.maybeName,
                                          );
                                        }
                                      },
                                      onAudioCallPressed: () => _callController.createCall(
                                        destination: number,
                                        displayName: contact?.maybeName,
                                        video: false,
                                      ),
                                      onVideoCallPressed: widget.videoEnabled
                                          ? () => _callController.createCall(
                                                destination: number,
                                                displayName: contact?.maybeName,
                                                video: true,
                                              )
                                          : null,
                                      onTransferPressed: widget.transferEnabled && hasActiveCall
                                          ? () {
                                              submitTransfer(destination: number);
                                            }
                                          : null,
                                      onChatPressed: widget.chatsEnabled && (contact?.canMessage == true)
                                          ? () {
                                              openChat(contactSourceId!);
                                            }
                                          : null,
                                      onSendSmsPressed: widget.smssEnabled && userSmsNumbers.isNotEmpty && canSendSms
                                          ? () {
                                              sendSms(
                                                userSmsNumbers: userSmsNumbers,
                                                contactPhoneNumber: number,
                                                contactSourceId: contactSourceId,
                                              );
                                            }
                                          : null,
                                      onViewContactPressed: contact != null
                                          ? () {
                                              openContact(contactId: contact.id);
                                            }
                                          : null,
                                      onCallLogPressed: () => openCallLog(number: number),
                                      onCallFrom: (fromNumber) => _callController.createCall(
                                        destination: number,
                                        displayName: contact?.maybeName,
                                        fromNumber: fromNumber,
                                        video: false,
                                      ),
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
