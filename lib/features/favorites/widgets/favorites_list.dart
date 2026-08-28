import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

/// The list of favourites, and everything a row of it can do.
///
/// A widget of its own because two screens draw the same list: the favourites
/// section of the bottom bar, and the contacts section of a deployment that
/// offers favourites as one more entry of its list chooser. Left inside the
/// first screen, the second would need a copy of the row wiring - the calls,
/// the chat, the SMS, the call log, the delete - and the copies would drift.
///
/// Rearranging belongs to the screen that offers it, so this takes the mode
/// rather than owning it; a screen that never rearranges passes nothing and
/// the rows simply do not drag.
class FavoritesList extends StatefulWidget {
  /// Rearranging is offered from two favourites up. Named here because every
  /// screen that offers it needs the same figure - the button it puts up, and
  /// leaving the mode when the list drops below it.
  static const reorderMinimum = 2;

  const FavoritesList({
    super.key,
    required this.transferEnabled,
    required this.videoEnabled,
    required this.chatsEnabled,
    required this.smssEnabled,
    required this.cdrsEnabled,
    this.reorderMode = false,
    this.onReorderStart,
    this.onReorderEnd,
    this.topPadding,
  });

  final bool transferEnabled;
  final bool videoEnabled;
  final bool chatsEnabled;
  final bool smssEnabled;
  final bool cdrsEnabled;

  /// Whether the rows can be dragged. Off, they still build the same way -
  /// one list, not two - and only the drag handles are inert.
  final bool reorderMode;

  final void Function(int index)? onReorderStart;
  final void Function(int index)? onReorderEnd;

  /// What the list leaves clear at the top for a bar drawn over it.
  ///
  /// Null means take it from [MediaQuery], which is how a screen that draws
  /// its own bar over the body states the inset. Naming a padding at all
  /// overrides what a scrolling list would otherwise inherit, so a list that
  /// hard-coded zero here slid under the bar of any screen but the one it was
  /// written for.
  final double? topPadding;

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  late final _callController = CallControllerScope.of(context);

  String? _expandedFavoriteId;

  void _toggleExpanded(String favoriteId) {
    setState(() => _expandedFavoriteId = _expandedFavoriteId == favoriteId ? null : favoriteId);
  }

  void submitTransfer({required String destination}) {
    _callController.submitTransfer(destination);
    context.router.maybePop();
  }

  void openChat(String userId) {
    final route = ChatConversationScreenPageRoute(participantId: userId);
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
    if (widget.cdrsEnabled) {
      context.router.navigate(NumberCdrsScreenPageRoute(number: number));
    } else {
      context.router.navigate(CallLogScreenPageRoute(number: number));
    }
  }

  void delete({required Favorite favorite}) {
    context.showSnackBar(context.l10n.favorites_SnackBar_deleted(favorite.number));
    context.read<FavoritesBloc>().add(FavoritesRemoved(favorite: favorite));
  }

  Future<void> _refresh() async {
    final bloc = context.read<FavoritesBloc>();
    bloc.add(const FavoritesRefreshed());
    // Held until the bloc says the fetch is done rather than until the list
    // changes: a fetch that finds nothing new changes nothing, and a spinner
    // waiting on the list would never stop.
    await bloc.stream.firstWhere((state) => !state.refreshing);
  }

  void reorder({required List<FavoriteWithContact> favorites, required int oldIndex, required int newIndex}) {
    var targetIndex = newIndex;
    if (targetIndex > oldIndex) {
      targetIndex -= 1;
    }
    if (targetIndex == oldIndex) {
      return;
    }
    context.read<FavoritesBloc>().add(FavoritesShifted(favorite: favorites[oldIndex].favorite, position: targetIndex));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final favorites = state.favorites;
        if (favorites == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (favorites.isEmpty) {
          return NoDataPlaceholder(content: Text(context.l10n.favorites_BodyCenter_empty));
        }

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
                    return SizedBox.expand(
                      // Not while rows are being rearranged: both start with a
                      // drag downwards, and pulling on the top row would ask
                      // for a refresh instead of picking the row up.
                      child: RefreshIndicator(
                        onRefresh: _refresh,
                        notificationPredicate: (_) => !widget.reorderMode,
                        // The list runs behind the app bar, so the spinner
                        // takes the same inset the first row does or it is
                        // drawn out of sight behind it.
                        edgeOffset: widget.topPadding ?? MediaQuery.of(context).padding.top,
                        child: ReorderableListView.builder(
                          padding: EdgeInsets.only(top: widget.topPadding ?? MediaQuery.of(context).padding.top),
                          itemCount: favorites.length,
                          // TODO: migrate to onReorderItem (deprecated after Flutter 3.41.0-0.0.pre)
                          // ignore: deprecated_member_use
                          onReorder: (oldIndex, newIndex) =>
                              reorder(favorites: favorites, oldIndex: oldIndex, newIndex: newIndex),
                          onReorderStart: widget.onReorderStart,
                          onReorderEnd: widget.onReorderEnd,
                          buildDefaultDragHandles: false,
                          itemBuilder: (context, index) {
                            final favorite = favorites[index].favorite;
                            final contact = favorites[index].contact;

                            final contactSourceId = contact?.sourceId;
                            final contactSmsNumbers = contact?.smsNumbers ?? [];
                            final canSendSms = contactSmsNumbers.contains(favorite.number);

                            return ReorderableDragStartListener(
                              key: ValueKey('${favorite.number}_${favorite.sourceType.name}_$index'),
                              index: index,
                              enabled: widget.reorderMode,
                              child: Row(
                                children: [
                                  if (widget.reorderMode) ...[SizedBox(width: 4), const Icon(Icons.drag_handle)],
                                  Expanded(
                                    child: FavoriteTile(
                                      gesturesEnabled: !widget.reorderMode,
                                      favorite: favorite,
                                      contact: contact,
                                      callNumbers: callRoutingState?.allNumbers ?? [],
                                      onTap: blingTransferInitiated
                                          ? () => submitTransfer(destination: favorite.number)
                                          : () => _toggleExpanded('${favorite.number}_${favorite.sourceType.name}'),
                                      expanded:
                                          !blingTransferInitiated &&
                                          !widget.reorderMode &&
                                          _expandedFavoriteId == '${favorite.number}_${favorite.sourceType.name}',
                                      onDialPressed: blingTransferInitiated
                                          ? null
                                          : () {
                                              _callController.createCall(
                                                destination: favorite.number,
                                                displayName: contact?.maybeName ?? favorite.number,
                                              );
                                            },
                                      onAudioCallPressed: () {
                                        _callController.createCall(
                                          destination: favorite.number,
                                          displayName: contact?.maybeName ?? favorite.number,
                                          video: false,
                                        );
                                      },
                                      onVideoCallPressed: widget.videoEnabled
                                          ? () {
                                              _callController.createCall(
                                                destination: favorite.number,
                                                displayName: contact?.maybeName ?? favorite.number,
                                                video: true,
                                              );
                                            }
                                          : null,
                                      onTransferPressed: widget.transferEnabled && hasActiveCall
                                          ? () {
                                              submitTransfer(destination: favorite.number);
                                            }
                                          : null,
                                      onChatPressed: widget.chatsEnabled && contact?.canMessage == true
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
                                      onViewContactPressed: contact != null
                                          ? () => openContact(contactId: contact.id)
                                          : null,
                                      onCallLogPressed: () => openCallLog(number: favorite.number),
                                      onDelete: () => delete(favorite: favorite),
                                      onCallFrom: (fromNumber) => _callController.createCall(
                                        destination: favorite.number,
                                        displayName: contact?.maybeName ?? favorite.number,
                                        fromNumber: fromNumber,
                                        video: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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
