part of 'chat_conversation_builder_cubit.dart';

/// Represents the base state of the Chat Conversation Builder (ChatCB).
abstract class ChatCBState {
  ChatCBState();

  factory ChatCBState.initializing() => Initializing();
  factory ChatCBState.initializingError(Object error) => InitializingError(error);
  factory ChatCBState.initialized(List<Contact> contacts) => InitializedCommon.initialized(contacts);
}

/// State when the chat conversation builder is initializing.
class Initializing extends ChatCBState {
  Initializing();
}

/// State when there is an error during the initialization of the chat conversation builder.
class InitializingError extends ChatCBState with EquatableMixin {
  InitializingError(this.error);

  /// The error that occurred during initialization.
  final Object error;

  @override
  List<Object> get props => [error];

  @override
  bool get stringify => true;
}

/// Represents the common state for initialized chat conversation builder.
/// Uses as second hierarchy level containing the list of [contacts] that needed in child stages,
/// such as [DialogContactSelection], [GroupContactsSelection], and [GroupFillInfo].
/// Also, contains the [cameBack] flag that indicates if the user came back to previous stage.
sealed class InitializedCommon extends ChatCBState {
  InitializedCommon(this.contacts, {this.cameBack = false});

  /// The list of contacts that able to involve in the chat conversation.
  final List<Contact> contacts;

  /// Indicates if the user came back from the next stage.
  final bool cameBack;

  /// Creates an instance of default initialized state with the given list of [contacts].
  factory InitializedCommon.initialized(List<Contact> contacts) => DialogContactSelection(contacts);

  /// Creates a copy of this state with the given properties.
  ///
  /// The [contacts] parameter is optional and will replace the current list of contacts if provided.
  InitializedCommon copyWith({List<Contact>? contacts});
}

/// Represents the state when user has ability to
/// choose contact to start dialog with or switch to group creation form.
class DialogContactSelection extends InitializedCommon with EquatableMixin {
  DialogContactSelection(super.contacts, {super.cameBack, this.searchFilter = ''});

  /// The search filter applied to the contacts.
  final String searchFilter;

  /// List of contacts after applying the search filter.
  late final List<Contact> filteredContacts = searchFilter.trim().isEmpty
      ? contacts
      : contacts.where((contact) => contact.name.toLowerCase().contains(searchFilter.toLowerCase())).toList();

  /// Create next [GroupContactsSelection] stage from this state.
  GroupContactsSelection toGroupContactsSelection() {
    return GroupContactsSelection(contacts, searchFilter: searchFilter);
  }

  @override
  DialogContactSelection copyWith({List<Contact>? contacts, String? searchFilter}) {
    return DialogContactSelection(
      contacts ?? this.contacts,
      searchFilter: searchFilter ?? this.searchFilter,
    );
  }

  @override
  List<Object> get props => [contacts, cameBack, searchFilter];

  @override
  bool get stringify => true;
}

/// State for when the group contacts selection is active.
class GroupContactsSelection extends InitializedCommon with EquatableMixin {
  GroupContactsSelection(super.contacts, {super.cameBack, this.searchFilter = '', this.selectedContacts = const {}});

  /// The search filter applied to the contacts.
  final String searchFilter;

  /// List of contacts after applying the search filter.
  late final List<Contact> filteredContacts = searchFilter.trim().isEmpty
      ? contacts
      : contacts.where((contact) => contact.name.toLowerCase().contains(searchFilter.toLowerCase())).toList();

  /// Contacts that user selected for the group.
  final Set<Contact> selectedContacts;

  /// Create next [GroupFillInfo] stage from this state.
  GroupFillInfo toFillInfoStage() {
    return GroupFillInfo(contacts, selectedContacts);
  }

  /// Create previous [DialogContactSelection] stage from this state.
  DialogContactSelection toDialogContactStage() {
    return DialogContactSelection(contacts, searchFilter: searchFilter, cameBack: true);
  }

  @override
  GroupContactsSelection copyWith({List<Contact>? contacts, Set<Contact>? selectedContacts, String? searchFilter}) {
    return GroupContactsSelection(
      contacts ?? this.contacts,
      selectedContacts: selectedContacts ?? this.selectedContacts,
      searchFilter: searchFilter ?? this.searchFilter,
    );
  }

  @override
  List<Object> get props => [contacts, cameBack, searchFilter, selectedContacts];

  @override
  bool get stringify => true;
}

/// State for when the group info fill  is active.
class GroupFillInfo extends InitializedCommon with EquatableMixin {
  GroupFillInfo(super.contacts, this.selectedContacts, {this.name = '', this.processing = false});

  /// The list of chosen contacts.
  final Set<Contact> selectedContacts;

  /// The name of the group.
  final String name;

  /// Indicates if the group is being submitted to the server, and waiting for a response.
  final bool processing;

  /// Create previous [GroupContactsSelection] stage from this state.
  GroupContactsSelection toGroupContactsStage() {
    return GroupContactsSelection(contacts, selectedContacts: selectedContacts, cameBack: true);
  }

  @override
  GroupFillInfo copyWith({List<Contact>? contacts, Set<Contact>? selectedContacts, String? name, bool? processing}) {
    return GroupFillInfo(
      contacts ?? this.contacts,
      selectedContacts ?? this.selectedContacts,
      name: name ?? this.name,
      processing: processing ?? this.processing,
    );
  }

  @override
  List<Object> get props => [contacts, cameBack, selectedContacts, name, processing];

  @override
  bool get stringify => true;
}
