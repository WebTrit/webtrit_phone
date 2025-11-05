part of 'sms_conversation_builder_cubit.dart';

/// Represents the base state of the sms conversation builder (next SmsCB).
sealed class SmsCBState with EquatableMixin {
  const SmsCBState();

  factory SmsCBState.initializing() => const SmsCBInitializing();
  factory SmsCBState.initializingError(Object error) => SmsCBInitializingError(error);
  factory SmsCBState.common(List<Contact> contacts) => SmsCBCommon(contacts);
}

/// Represents state when the SMS conversation builder is initializing.
/// loading contacts, parsing, filtering etc.
final class SmsCBInitializing extends SmsCBState {
  const SmsCBInitializing();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

/// Represents state when there is an error during the initialization of the sms conversation builder.
final class SmsCBInitializingError extends SmsCBState {
  const SmsCBInitializingError(this.error) : assert(error is Error || error is Exception);

  /// The error that occurred during initialization,
  /// can be error-contanted object, such as [Error], [Exception], or custom exception.
  final Object error;

  @override
  List<Object?> get props => [error];

  @override
  bool get stringify => true;
}

/// Represents a common state for the SMS Conversation Builder feature.
/// were user can select number from a contact, search, or enter a number manually.
class SmsCBCommon extends SmsCBState {
  SmsCBCommon(this.contacts, {this.searchFilter = '', this.parsedNumber = ''});

  /// The list of contacts that able to involve in the SMS conversation.
  final List<Contact> contacts;

  /// The search filter that used to filter contacts.
  /// Can be part of contact attribute, or full number.
  /// If it's a valid to use number, it will be parsed to the [parsedNumber].
  final String searchFilter;

  /// The parsed number from the [searchFilter].
  final String parsedNumber;

  /// Computed lists of contacts based on the search filter.
  late final filteredContacts = contacts.where((c) => _searchMatcher(c, searchFilter));

  /// Computed sub-lists of local contacts based on the search filter.
  late final localContacts = filteredContacts.where((c) => c.sourceType == ContactSourceType.local);

  /// Computed sub-lists of external contacts based on the search filter.
  late final externalContacts = filteredContacts.where((c) => c.sourceType == ContactSourceType.external);

  /// Create next [SmsCBWrongNumberSelected] stage from this state.
  SmsCBWrongNumberSelected toWrongNumberSelected(
    String recipientNumber,
  ) {
    return SmsCBWrongNumberSelected(this, recipientNumber);
  }

  /// Create next [SmsCBUserNumberConfirmationNeeded] stage from this state.
  SmsCBUserNumberConfirmationNeeded toUserNumberConfirmationNeeded(
    RecipientCreds recipientCreds,
    List<String> userNumbers,
  ) {
    return SmsCBUserNumberConfirmationNeeded(this, recipientCreds, userNumbers);
  }

  SmsCBCommon copyWith({
    List<Contact>? contacts,
    String? searchFilter,
    String? parsedNumber,
  }) {
    return SmsCBCommon(
      contacts ?? this.contacts,
      searchFilter: searchFilter ?? this.searchFilter,
      parsedNumber: parsedNumber ?? this.parsedNumber,
    );
  }

  @override
  List<Object?> get props => [contacts, searchFilter, parsedNumber];

  @override
  bool get stringify => true;
}

/// Represents sub-common state when the user selected a wrong number.
/// eg. non-e164 number, or himself.
final class SmsCBWrongNumberSelected extends SmsCBCommon {
  SmsCBWrongNumberSelected(SmsCBCommon state, this.recipientNumber)
      : super(state.contacts, searchFilter: state.searchFilter, parsedNumber: state.parsedNumber);

  /// The number that user selected to send the message to.
  final String recipientNumber;

  /// Restore previous [SmsCBCommon] stage from this state.
  SmsCBCommon toCommon() {
    return SmsCBCommon(contacts, searchFilter: searchFilter, parsedNumber: parsedNumber);
  }

  @override
  List<Object?> get props => [recipientNumber, contacts, searchFilter, parsedNumber];

  @override
  bool get stringify => true;
}

/// Represents sub-common state when the user needs to confirm the number.
/// eg. user has multiple numbers linked with him account and should select one
/// or has no numbers associated with him account.
final class SmsCBUserNumberConfirmationNeeded extends SmsCBCommon {
  SmsCBUserNumberConfirmationNeeded(SmsCBCommon state, this.recipientCreds, this.userNumbers)
      : super(state.contacts, searchFilter: state.searchFilter, parsedNumber: state.parsedNumber);

  /// The number that user selected to send the message to.
  final RecipientCreds recipientCreds;

  /// The list of numbers that user has associated with him account.
  final List<String> userNumbers;

  /// Restore previous [SmsCBCommon] stage from this state.
  SmsCBCommon toCommon() {
    return SmsCBCommon(contacts, searchFilter: searchFilter, parsedNumber: parsedNumber);
  }

  @override
  List<Object?> get props => [recipientCreds, userNumbers, contacts, searchFilter, parsedNumber];

  @override
  bool get stringify => true;
}

typedef RecipientCreds = ({String number, String? id});

bool _searchMatcher(Contact contact, String searchFilterValue) {
  if (searchFilterValue.isEmpty) return true;
  matchName() => contact.maybeName?.toLowerCase().contains(searchFilterValue.toLowerCase()) ?? false;
  matchPhone() => contact.phones.any((phone) => phone.number.contains(searchFilterValue));
  return matchName() || matchPhone();
}
