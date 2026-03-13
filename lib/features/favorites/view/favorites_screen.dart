import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
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
  late final _callController = context.read<CallController>();
  bool isReorderMode = false;
  int? draggingIndex;

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

  void onReorderEnd(int index) {
    if (draggingIndex == null) return;
    if (index > draggingIndex!) index -= 1;
    final favorites = context.read<FavoritesBloc>().state.favorites;
    final favorite = favorites?[draggingIndex!].favorite;
    if (favorite == null) return;
    context.read<FavoritesBloc>().add(FavoritesShifted(favorite: favorite, position: index));
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
      applyToAppBar: effectiveStyle?.applyToAppBar ?? false,
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(
        title: widget.title,
        context: context,
        flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
      ),
      floatingActionButton: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final favorites = state.favorites;
          if (favorites == null || favorites.length < 3) {
            return const SizedBox.shrink();
          }
          return FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: toggleReorderMode,
            child: Icon(isReorderMode ? Icons.check : Icons.edit_note_outlined),
          );
        },
      ),
      body: BlocConsumer<FavoritesBloc, FavoritesState>(
        listenWhen: (previous, current) => previous.favorites != current.favorites,
        listener: (context, state) {
          // Exit reorder mode if favorites were updated while reordering
          if (draggingIndex != null) {
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
                              onReorder: (oldIndex, newIndex) {},
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
                                          key: favoriteTileKey,
                                          gesturesEnabled: !isReorderMode,
                                          favorite: favorite,
                                          contact: contact,
                                          callNumbers: callRoutingState?.allNumbers ?? [],
                                          onTap: blingTransferInitiated
                                              ? () {
                                                  submitTransfer(destination: favorite.number);
                                                }
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
                                        ),
                                      ),

                                      const SizedBox(width: 8),
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
