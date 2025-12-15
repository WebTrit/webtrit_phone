part of 'chat_conversation_builder_cubit.dart';

/// Represents the base state of the chat conversation builder (next ChatCB).
abstract class ChatCBState with EquatableMixin {
  ChatCBState();

  factory ChatCBState.initializing() => ChatCBInitializing();

  factory ChatCBState.initializingError(Object error) => ChatCBInitializingError(error);

  factory ChatCBState.common(List<Contact> contacts, {bool enableGroupChats = true}) =>
      ChatCBCommon.initialized(contacts, enableGroupChats: enableGroupChats);
}

/// Represents state when the chat conversation builder is initializing.
/// loading contacts, parsing, filtering etc.
class ChatCBInitializing extends ChatCBState {
  ChatCBInitializing();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

/// Represents state when there is an error during the initialization of the chat conversation builder.
class ChatCBInitializingError extends ChatCBState {
  ChatCBInitializingError(this.error) : assert(error is Error || error is Exception);

  /// The error that occurred during initialization,
  /// can be error-contanted object, such as [Error], [Exception], or custom exception.
  final Object error;

  @override
  List<Object?> get props => [error];

  @override
  bool get stringify => true;
}

/// Represents the common state for initialized chat conversation builder.
/// Uses as second hierarchy level containing the list of [contacts] that needed in child stages,
/// such as [ChatCBDialogContactSelection], [ChatCBGroupContactsSelection], and [ChatCBGroupFillInfo].
/// Also, contains the [cameBack] flag that indicates if the user came back to previous stage.
sealed class ChatCBCommon extends ChatCBState {
  ChatCBCommon(this.contacts, {this.cameBack = false});

  /// The list of contacts that able to involve in the chat conversation.
  final List<Contact> contacts;

  /// Indicates if the user came back from the next stage.
  final bool cameBack;

  /// Creates an instance of default initialized state with the given list of [contacts].
  factory ChatCBCommon.initialized(List<Contact> contacts, {bool enableGroupChats = true}) =>
      ChatCBDialogContactSelection(contacts, enableGroupChats: enableGroupChats);

  /// Creates a copy of this state with the given properties.
  ///
  /// The [contacts] parameter is optional and will replace the current list of contacts if provided.
  ChatCBCommon copyWith({List<Contact>? contacts});
}

/// Represents the state when user has ability to
/// choose contact to start dialog with or switch to group creation form.
class ChatCBDialogContactSelection extends ChatCBCommon {
  ChatCBDialogContactSelection(super.contacts, {super.cameBack, this.searchFilter = '', this.enableGroupChats = true});

  /// The search filter applied to the contacts.
  final String searchFilter;

  /// Computed lists of contacts based on the search filter.
  late final filteredContacts = contacts.where((c) => _searchMatcher(c, searchFilter));

  /// Indicates if group chats are enabled and user can create them.
  final bool enableGroupChats;

  /// Create next [ChatCBGroupContactsSelection] stage from this state.
  ChatCBGroupContactsSelection toGroupContactsSelection() {
    return ChatCBGroupContactsSelection(contacts, searchFilter: searchFilter);
  }

  @override
  ChatCBDialogContactSelection copyWith({List<Contact>? contacts, String? searchFilter, bool? enableGroupChats}) {
    return ChatCBDialogContactSelection(
      contacts ?? this.contacts,
      searchFilter: searchFilter ?? this.searchFilter,
      enableGroupChats: enableGroupChats ?? this.enableGroupChats,
    );
  }

  @override
  List<Object?> get props => [contacts, cameBack, searchFilter];

  @override
  bool get stringify => true;
}

/// Represents state for when the group contacts selection is active.
class ChatCBGroupContactsSelection extends ChatCBCommon {
  ChatCBGroupContactsSelection(
    super.contacts, {
    super.cameBack,
    this.searchFilter = '',
    this.selectedContacts = const {},
  });

  /// The search filter applied to the contacts.
  final String searchFilter;

  /// Contacts that user selected for the group.
  final Set<Contact> selectedContacts;

  /// Computed lists of contacts based on the search filter.
  late final filteredContacts = contacts.where((c) => _searchMatcher(c, searchFilter));

  /// Create next [ChatCBGroupFillInfo] stage from this state.
  ChatCBGroupFillInfo toFillInfoStage() {
    return ChatCBGroupFillInfo(contacts, selectedContacts);
  }

  /// Restore previous [ChatCBDialogContactSelection] stage from this state.
  ChatCBDialogContactSelection toDialogContactStage() {
    return ChatCBDialogContactSelection(contacts, searchFilter: searchFilter, cameBack: true);
  }

  @override
  ChatCBGroupContactsSelection copyWith({
    List<Contact>? contacts,
    String? searchFilter,
    Set<Contact>? selectedContacts,
  }) {
    return ChatCBGroupContactsSelection(
      contacts ?? this.contacts,
      searchFilter: searchFilter ?? this.searchFilter,
      selectedContacts: selectedContacts ?? this.selectedContacts,
    );
  }

  @override
  List<Object?> get props => [contacts, cameBack, searchFilter, selectedContacts];

  @override
  bool get stringify => true;
}

/// Represents state for when the group info fill is active.
class ChatCBGroupFillInfo extends ChatCBCommon {
  ChatCBGroupFillInfo(super.contacts, this.selectedContacts, {this.name = '', this.processing = false});

  /// The list of chosen contacts.
  final Set<Contact> selectedContacts;

  /// The name of the group.
  final String name;

  /// Indicates if the group is being submitted to the server, and waiting for a response.
  final bool processing;

  /// Restore previous [ChatCBGroupContactsSelection] stage from this state.
  ChatCBGroupContactsSelection toGroupContactsStage() {
    return ChatCBGroupContactsSelection(contacts, selectedContacts: selectedContacts, cameBack: true);
  }

  @override
  ChatCBGroupFillInfo copyWith({
    List<Contact>? contacts,
    Set<Contact>? selectedContacts,
    String? name,
    bool? processing,
  }) {
    return ChatCBGroupFillInfo(
      contacts ?? this.contacts,
      selectedContacts ?? this.selectedContacts,
      name: name ?? this.name,
      processing: processing ?? this.processing,
    );
  }

  @override
  List<Object?> get props => [contacts, cameBack, selectedContacts, name, processing];

  @override
  bool get stringify => true;
}

bool _searchMatcher(Contact contact, String searchFilterValue) {
  if (searchFilterValue.isEmpty) return true;
  matchName() => contact.maybeName?.toLowerCase().contains(searchFilterValue.toLowerCase()) ?? false;
  matchPhone() => contact.phones.any(
    (phone) => phone.rawNumber.contains(searchFilterValue) || phone.sanitizedNimber.contains(searchFilterValue),
  );
  return matchName() || matchPhone();
}
