import 'package:flutter/material.dart';
import 'package:webtrit_phone/app/keys.dart';

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
import 'favorites_screen_style.dart';
import 'favorites_screen_styles.dart';

/// Rearranging is offered from two favorites up. The screen used to ask for
/// three, which locked out the one case where rearranging IS the whole task -
/// swapping a pair. Named because two places depend on it: the button, and
/// leaving the mode when the list drops below it.
const _reorderMinimum = 2;

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    super.key,
    this.title,
    required this.transferEnabled,
    required this.videoEnabled,
    required this.chatsEnabled,
    required this.smssEnabled,
    required this.cdrsEnabled,
    this.style,
  });

  final Widget? title;
  final bool transferEnabled;
  final bool videoEnabled;
  final bool chatsEnabled;
  final bool smssEnabled;
  final bool cdrsEnabled;
  final FavoritesScreenStyle? style;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final _callController = CallControllerScope.of(context);
  bool isReorderMode = false;
  int? draggingIndex;
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

  void toggleReorderMode() => setState(() => isReorderMode = !isReorderMode);

  void onReorderStart(int index) {
    draggingIndex = index;
  }

  /// Clears the drag marker. The move itself is sent from the list's
  /// `onReorder` callback, which fires for a finished drag and for the move
  /// actions the list offers to a screen reader alike, so both take one path.
  void onReorderEnd(int index) {
    draggingIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final effectiveStyle = widget.style ?? themeData.extension<FavoritesScreenStyles>()?.primary;
    final mediaQueryData = MediaQuery.of(context);
    final topPadding = kToolbarHeight + mediaQueryData.padding.top;

    return ThemedScaffold(
      background: effectiveStyle?.background,
      contentThemeOverride: effectiveStyle?.contentThemeOverride ?? ThemeMode.system,
      applyToAppBar: effectiveStyle?.applyToAppBar ?? true,
      appBarTheme: effectiveStyle?.appBarTheme,
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(
        title: widget.title,
        context: context,
        flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
      ),
      floatingActionButton: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final favorites = state.favorites;
          if (favorites == null || favorites.length < _reorderMinimum) {
            return const SizedBox.shrink();
          }
          // The padding is what makes the button pressable at all: the tab bar
          // of the main screen floats over the page, and without it the button
          // is drawn underneath - invisible, and every tap goes to the bar.
          return Padding(
            // Exactly the room the bar takes, whatever the device: the shell
            // reports it to the page as bottom padding (its own height plus
            // the system inset underneath). Scaffold does not apply it to the
            // button, so the page does - adding the bar height on top of it
            // would push the button a bar's height too high.
            padding: EdgeInsets.only(bottom: mediaQueryData.padding.bottom),
            // Only the icon said what this does, and it says two different
            // things depending on whether rearranging is already under way.
            child: SemanticAction(
              label: isReorderMode
                  ? context.l10n.favorites_SemanticsLabel_reorderDone
                  : context.l10n.favorites_SemanticsLabel_reorder,
              identifier: favoritesReorderId,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: toggleReorderMode,
                child: Icon(isReorderMode ? Icons.check : Icons.edit_note_outlined),
              ),
            ),
          );
        },
      ),
      body: BlocConsumer<FavoritesBloc, FavoritesState>(
        listenWhen: (previous, current) => previous.favorites != current.favorites,
        listener: (context, state) {
          // Two reasons to leave the rearranging mode, both about a list that
          // changed underneath: a move that landed while a row was being
          // dragged, and a list that became too short to rearrange - the
          // button is the only way out of the mode and it is not offered
          // below the minimum, so the rows would stay locked.
          final tooShortToReorder = (state.favorites?.length ?? 0) < _reorderMinimum;
          if (draggingIndex != null || (isReorderMode && tooShortToReorder)) {
            setState(() {
              isReorderMode = false;
              draggingIndex = null;
            });
          }
        },
        builder: (context, state) {
          final favorites = state.favorites;
          if (favorites == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (favorites.isEmpty) {
              return NoDataPlaceholder(content: Text(context.l10n.favorites_BodyCenter_empty));
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
                          return SizedBox.expand(
                            child: ReorderableListView.builder(
                              padding: EdgeInsets.only(top: topPadding),
                              itemCount: favorites.length,
                              // TODO: migrate to onReorderItem (deprecated after Flutter 3.41.0-0.0.pre)
                              // ignore: deprecated_member_use
                              onReorder: (oldIndex, newIndex) =>
                                  reorder(favorites: favorites, oldIndex: oldIndex, newIndex: newIndex),
                              onReorderStart: onReorderStart,
                              onReorderEnd: onReorderEnd,
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
                                  enabled: isReorderMode,
                                  child: Row(
                                    children: [
                                      if (isReorderMode) ...[SizedBox(width: 4), const Icon(Icons.drag_handle)],
                                      Expanded(
                                        child: FavoriteTile(
                                          gesturesEnabled: !isReorderMode,
                                          favorite: favorite,
                                          contact: contact,
                                          callNumbers: callRoutingState?.allNumbers ?? [],
                                          onTap: blingTransferInitiated
                                              ? () => submitTransfer(destination: favorite.number)
                                              : () => _toggleExpanded('${favorite.number}_${favorite.sourceType.name}'),
                                          expanded:
                                              !blingTransferInitiated &&
                                              !isReorderMode &&
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
                                          onSendSmsPressed:
                                              widget.smssEnabled && userSmsNumbers.isNotEmpty && canSendSms
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
