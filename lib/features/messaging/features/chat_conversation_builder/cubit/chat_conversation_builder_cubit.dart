import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:phoenix_socket/phoenix_socket.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/messaging/extensions/contact.dart';
import 'package:webtrit_phone/features/messaging/extensions/phoenix_socket.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'chat_conversation_builder_state.dart';

final _logger = Logger('ChatConversationBuilderCubit');

class ChatConversationBuilderCubit extends Cubit<ChatCBState> {
  ChatConversationBuilderCubit(
    this.client,
    this.chatsRepository,
    this.contactsRepository, {
    required this.openDialog,
    required this.openGroup,
    required this.submitNotification,
    this.contactfilter = _defaultContactFilter,
  }) : super(ChatCBState.initializing()) {
    /// Initialize the contacts subscription.
    _contactsSub = _contactsSubFactory;
  }

  final PhoenixSocket client;
  final ChatsRepository chatsRepository;
  final ContactsRepository contactsRepository;

  /// Calls when user decided to start dialog with the given [Contact].
  /// and app should route user to appropriate dialog screen.
  final void Function(Contact) openDialog;

  /// Calls when user created a group successfully
  /// and app should route user to the group chat screen by the given [id].
  final void Function(int id) openGroup;

  /// Submits local notification to the notification system.
  final void Function(Notification) submitNotification;

  /// The filter of contact that able to involve in the chat conversation or invite to the group.
  final bool Function(Contact) contactfilter;

  late final StreamSubscription _contactsSub;

  StreamSubscription get _contactsSubFactory {
    return contactsRepository
        .watchContacts('', ContactSourceType.external)
        .debounce(const Duration(milliseconds: 250))
        .listen(
          (contacts) => _contactsUpdateHandler(contacts),
          onError: (error) => emit(ChatCBState.initializingError(error)),
        );
  }

  void _contactsUpdateHandler(List<Contact> contacts) {
    final state = this.state;
    final filtered = contacts.where(contactfilter).toList();

    /// Initialize builder state with the contacts list filtered by the provided filter
    /// If the state is already initialized update the contacts list using covariant copyWith method
    state is ChatCBCommon ? emit(state.copyWith(contacts: filtered)) : emit(ChatCBState.common(filtered));
  }

  /// Handles the confirmation of dialog creation for a given contact.
  ///
  /// This method is triggered when a dialog creation is confirmed.
  ///
  /// Parameters:
  /// - [contact]: The contact for whom the dialog is being created.
  void onDialogCreateConfirm(Contact contact) {
    openDialog(contact);
  }

  /// Handles the change in the search filter.
  ///
  /// This method is triggered when the search filter is updated, allowing to filter
  /// the contact list based on the provided search criteria.
  ///
  /// [searchFilter] The new search filter string.
  void onSearchFilterChange(String searchFilter) {
    final state = this.state;
    switch (state) {
      case ChatCBDialogContactSelection state:
        emit(state.copyWith(searchFilter: searchFilter));
      case ChatCBGroupContactsSelection state:
        emit(state.copyWith(searchFilter: searchFilter));
      default:
    }
  }

  /// Handles the event when a group creation stage is chosen.
  void onGroupCreateStageChoosen() {
    final currentState = state;
    if (currentState is! ChatCBDialogContactSelection) return;
    emit(currentState.toGroupContactsSelection());
  }

  /// Handles the event when contact is selected.
  ///
  /// [contact] The contact that has been selected for invite to group.
  void onGroupContactSelected(Contact contact) {
    final currentState = state;
    if (currentState is! ChatCBGroupContactsSelection) return;
    emit(currentState.copyWith(selectedContacts: {...currentState.selectedContacts, contact}));
  }

  /// Handles the event when a group contact is deselected.
  ///
  /// [contact] The contact that was deselected for invite to group.
  void onGroupContactDeselected(Contact contact) {
    final currentState = state;
    if (currentState is! ChatCBGroupContactsSelection) return;
    emit(currentState.copyWith(selectedContacts: {...currentState.selectedContacts}..remove(contact)));
  }

  /// Handles the event when the group fill info stage is chosen.
  void onGroupFillInfoStageChoosen() {
    final currentState = state;
    if (currentState is! ChatCBGroupContactsSelection) return;
    emit(currentState.toFillInfoStage());
  }

  /// Handles the event when the group name changes.
  ///
  /// This method is triggered whenever the group name is updated by the user.
  /// It takes the new group name as a parameter and processes it accordingly.
  ///
  /// [name] The new name of the group.
  void onGroupNameChange(String name) {
    final currentState = state;
    if (currentState is! ChatCBGroupFillInfo) return;
    emit(currentState.copyWith(name: name));
  }

  /// Handles the action of navigating back to the previous stage in the chat conversation builder.
  /// This method is typically called when the user wants to return to the previous step in the conversation setup process.
  void onBackToPrevStage() {
    final state = this.state;
    if (state is ChatCBGroupContactsSelection) emit(state.toDialogContactStage());
    if (state is ChatCBGroupFillInfo) emit(state.toGroupContactsStage());
  }

  /// Handles the confirmation action for creating a new group chat.
  ///
  /// This method is triggered when the user confirms the creation of a new group.
  /// It performs the necessary actions to finalize the group creation process.
  ///
  /// The method is asynchronous and may involve network requests or other
  /// asynchronous operations.
  void onGroupCreateConfirm() async {
    final state = this.state;
    if (state is! ChatCBGroupFillInfo) return;

    final userChannel = client.userChannel;
    if (userChannel == null || userChannel.state != PhoenixChannelState.joined) return;

    try {
      emit(state.copyWith(processing: true));

      final selectedContacts = state.selectedContacts
          .map((contact) => contact.sourceId)
          .where((sourceId) => sourceId != null && sourceId.isNotEmpty)
          .cast<String>()
          .toList();

      final group = await userChannel.newGroup(state.name, selectedContacts);
      await chatsRepository.upsertChat(group);
      openGroup(group.id);
    } catch (e, s) {
      submitNotification(DefaultErrorNotification(e));
      _logger.warning('onGroupCreateConfirm failed', e, s);
    } finally {
      emit(state.copyWith(processing: false));
    }
  }

  @override
  Future<void> close() {
    _contactsSub.cancel();
    return super.close();
  }
}

bool _defaultContactFilter(Contact contact) => contact.canMessage;
