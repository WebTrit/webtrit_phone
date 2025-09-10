import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/notifications/bloc/notifications_bloc.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call_routing/cubit/call_routing_cubit.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/features/user_info/cubit/user_info_cubit.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../call/call.dart';
import '../recents.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({
    super.key,
    this.recentsFilters = const [RecentsVisibilityFilter.all, RecentsVisibilityFilter.missed],
    this.title,
    required this.transferEnabled,
    required this.videoEnabled,
    required this.chatsEnabled,
    required this.smssEnabled,
  });

  final List<RecentsVisibilityFilter> recentsFilters;
  final bool transferEnabled;
  final bool videoEnabled;
  final bool chatsEnabled;
  final bool smssEnabled;

  final Widget? title;

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen> with SingleTickerProviderStateMixin {
  // TODO(Serdun): Think about moving this to a controller or bloc.
  late final CallController _callController = CallController(
    callBloc: context.read<CallBloc>(),
    callRoutingCubit: context.read<CallRoutingCubit>(),
    notificationsBloc: context.read<NotificationsBloc>(),
  );
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    final activeFilter = context.read<RecentsBloc>().state.filter;
    final initialRecentsFiltersIndex = widget.recentsFilters.indexOf(activeFilter);

    _tabController = TabController(
      initialIndex: initialRecentsFiltersIndex == -1 ? 0 : initialRecentsFiltersIndex,
      length: widget.recentsFilters.length,
      vsync: this,
    );
    _tabController.addListener(_tabControllerListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabControllerListener);
    _tabController.dispose();
    super.dispose();
  }

  void _tabControllerListener() {
    if (!_tabController.indexIsChanging) {
      final filter = widget.recentsFilters[_tabController.index];
      context.read<RecentsBloc>().add(RecentsFiltered(filter));
    }
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
    context.router.navigate(CallLogScreenPageRoute(number: number));
  }

  void delete({required Recent recent}) {
    context.showSnackBar(context.l10n.recents_snackBar_deleted(recent.name));
    context.read<RecentsBloc>().add(RecentsDeleted(recent));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      appBar: MainAppBar(
        title: widget.title,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kMainAppBarBottomTabHeight),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: kMainAppBarBottomPaddingGap,
            ),
            child: ExtTabBar(
              width: mediaQueryData.size.width * 0.75,
              height: kMainAppBarBottomTabHeight - kMainAppBarBottomPaddingGap,
              tabs: [
                for (final recentsFilter in widget.recentsFilters) Tab(text: recentsFilter.l10n(context)),
              ],
              controller: _tabController,
            ),
          ),
        ),
        context: context,
      ),
      body: BlocBuilder<RecentsBloc, RecentsState>(
        builder: (context, state) {
          final recents = state.recents;
          if (recents == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final recentsFiltered = state.recentsFiltered!; // can not be null if state.recents is not null
            if (recentsFiltered.isEmpty) {
              final String filterL10n;
              if (state.filter == RecentsVisibilityFilter.all) {
                filterL10n = '';
              } else {
                filterL10n = '${state.filter.l10nPreposit(context)} ';
              }
              return NoDataPlaceholder(
                content: Text(context.l10n.recents_BodyCenter_empty(filterL10n)),
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
                      final transfer = callState.isBlingTransferInitiated;
                      final hasActiveCall = callState.activeCalls.isNotEmpty;

                      return BlocBuilder<CallRoutingCubit, CallRoutingState?>(
                        builder: (context, callRoutingState) {
                          return ListView.builder(
                            itemCount: recentsFiltered.length,
                            itemBuilder: (context, index) {
                              final recent = recentsFiltered[index];
                              final callLogEntry = recent.callLogEntry;
                              final contact = recent.contact;
                              final contactSourceId = contact?.sourceId;
                              final contactSmsNumbers = contact?.smsNumbers ?? [];
                              final canSendSms = contactSmsNumbers.contains(callLogEntry.number);

                              return PresenceInfoBuilder(
                                contact: contact,
                                builder: (context, presenceInfo) {
                                  return RecentTile(
                                    key: recentsTileKey,
                                    recent: recent,
                                    callNumbers: callRoutingState?.allNumbers ?? [],
                                    dateFormat: context.read<RecentsBloc>().dateFormat,
                                    onTap: transfer
                                        ? () {
                                            submitTransfer(destination: callLogEntry.number);
                                          }
                                        : () {
                                            _callController.createCall(
                                              destination: callLogEntry.number,
                                              displayName: contact?.maybeName,
                                              video: callLogEntry.video && widget.videoEnabled,
                                            );
                                          },
                                    onAudioCallPressed: () => _callController.createCall(
                                      destination: callLogEntry.number,
                                      displayName: contact?.maybeName,
                                      video: false,
                                    ),
                                    onVideoCallPressed: widget.videoEnabled
                                        ? () => _callController.createCall(
                                              destination: callLogEntry.number,
                                              displayName: contact?.maybeName,
                                              video: true,
                                            )
                                        : null,
                                    onTransferPressed: widget.transferEnabled && hasActiveCall
                                        ? () {
                                            submitTransfer(destination: callLogEntry.number);
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
                                              contactPhoneNumber: callLogEntry.number,
                                              contactSourceId: contactSourceId,
                                            );
                                          }
                                        : null,
                                    onViewContactPressed: contact != null
                                        ? () {
                                            openContact(contactId: contact.id);
                                          }
                                        : null,
                                    onCallLogPressed: () => openCallLog(number: callLogEntry.number),
                                    onDelete: () => delete(recent: recent),
                                    onCallFrom: (fromNumber) => _callController.createCall(
                                      destination: callLogEntry.number,
                                      displayName: contact?.maybeName,
                                      fromNumber: fromNumber,
                                      video: false,
                                    ),
                                    presenceInfo: presenceInfo,
                                  );
                                },
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
            return TransferBottomNavigationBar(context.l10n.recents_Text_blingTransferInitiated);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
