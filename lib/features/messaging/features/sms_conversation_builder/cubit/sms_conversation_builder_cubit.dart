import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:equatable/equatable.dart';
import 'package:device_region/device_region.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';

import 'package:webtrit_phone/features/messaging/extensions/extensions.dart';
import 'package:webtrit_phone/models/contact.dart';
import 'package:webtrit_phone/models/contact_source_type.dart';
import 'package:webtrit_phone/repositories/contacts/contacts_repository.dart';
import 'package:webtrit_phone/repositories/sms/sms_repository.dart';

part 'sms_conversation_builder_state.dart';

final _logger = Logger('SmsConversationBuilderCubit');

class SmsConversationBuilderCubit extends Cubit<SmsCBState> {
  SmsConversationBuilderCubit(
    this.smsRepository,
    this.contactsRepository, {
    required this.openSmsDialog,
    this.contactfilter = _defaultFilter,
  }) : super(SmsCBState.initializing()) {
    // Initialize the contacts subscription.
    _contactsSub = _contactsSubFactory;

    // Get the SIM country code to use it in the phone number parsing.
    DeviceRegion.getSIMCountryCode().then(
      (value) => (!isClosed) ? _simCountryCode = value : _logger.warning('Cubit is closed'),
      onError: (e) => _logger.warning('Error getting simCountryCode: $e'),
    );
  }

  final SmsRepository smsRepository;
  final ContactsRepository contactsRepository;

  /// Calls when user decided to start dialog with the given [recipientNumber].
  /// and app should route user to appropriate dialog screen.
  final void Function(String userNumber, String recipientNumber, String? recipientId) openSmsDialog;

  /// The filter of contact that able to involve in the sms conversation.
  final bool Function(Contact) contactfilter;

  late final PhoneNumberUtil _phoneUtil = PhoneNumberUtil.instance;
  late final String? _simCountryCode;
  late final StreamSubscription _contactsSub;

  StreamSubscription get _contactsSubFactory {
    return contactsRepository.watchContacts('').debounce(const Duration(milliseconds: 250)).listen(
          (contacts) => _contactsUpdateHandler(contacts),
          onError: (error) => emit(SmsCBState.initializingError(error)),
        );
  }

  void _contactsUpdateHandler(List<Contact> contacts) {
    final state = this.state;
    final filtered = contacts.where(contactfilter).toList();

    /// Initialize builder state with the contacts list filtered by the provided filter
    /// If the state is already initialized update the contacts list using covariant copyWith method
    state is SmsCBCommon ? emit(state.copyWith(contacts: filtered)) : emit(SmsCBState.common(filtered));
  }

  /// Handles the change in the contact search filter.
  ///
  /// This method is triggered when the search filter is updated, allowing to filter
  /// the contact list based on the provided search criteria.
  ///
  /// [searchFilter] The new search filter string.
  void setSearchFilter(String searchFilter) {
    final state = this.state;
    if (state is! SmsCBCommon) return;

    // Try to regognize and validate the search filter for a phone number.
    // If user input a valid phone number, we will propose use it as a recipient number.
    String parsedNumber = '';
    try {
      final maybeNumber = _phoneUtil.parse(searchFilter, _simCountryCode?.toUpperCase());
      if (_phoneUtil.isValidNumber(maybeNumber)) {
        parsedNumber = _phoneUtil.format(maybeNumber, PhoneNumberFormat.e164);
      }
    } catch (e) {
      _logger.info('NumberParseException: $e');
    }

    emit(state.copyWith(searchFilter: searchFilter, parsedNumber: parsedNumber));
  }

  /// Handles the confirmation action by parsing the provided phone number.
  ///
  /// This method is typically called when the user confirms to use
  /// phone number that was parsed and validated from the search filter.
  void onConfirmByParsedNumber() {
    final state = this.state;
    if (state is SmsCBCommon) onConfirm(state.parsedNumber, null);
  }

  /// Handles the confirmation action for an SMS conversation.
  ///
  /// This method is triggered when the user confirms the recipient's number selection.
  ///
  /// Heads user to appropriate state based on choosen number. If user has multiple
  /// phone numbers, user will be asked to confirm which number to use.
  /// If the recipient number is invalid, user will be warned to enter a valid number.
  ///
  /// [recipientNumber] The phone number of the recipient.
  /// [recipientId] The optional ID of the recipient.
  void onConfirm(String recipientNumber, String? recipientId) async {
    final state = this.state;
    if (state is! SmsCBCommon) return;

    if (recipientNumber.isValidPhone) {
      final recipientE164 = recipientNumber.e164Phone!;
      final userNumbers = await smsRepository.getUserSmsNumbers();

      if (userNumbers.contains(recipientE164)) {
        emit(state.toWrongNumberSelected(recipientE164));
      } else if (userNumbers.length != 1) {
        emit(state.toUserNumberConfirmationNeeded((number: recipientE164, id: recipientId), userNumbers));
      } else {
        openSmsDialog(userNumbers.first, recipientE164, recipientId);
      }
    } else {
      emit(state.toWrongNumberSelected(recipientNumber));
    }
  }

  /// Handles the back action to the common state from [SmsCBCommon] substates.
  void onBackToCommon() {
    final state = this.state;
    if (state is SmsCBWrongNumberSelected) emit(state.toCommon());
    if (state is SmsCBUserNumberConfirmationNeeded) emit(state.toCommon());
  }

  /// Handles the confirmation of the user's selected phone number.
  ///
  /// This method is triggered when the user confirms their phone number selection
  /// after user headed to select which number to send the message
  /// in case when user has multiple phone numbers.
  ///
  /// [selectedNumber] The phone number selected by the user.
  void onConfirmUserNumber(String selectedNumber) {
    final state = this.state;
    if (state is! SmsCBUserNumberConfirmationNeeded) return;

    openSmsDialog(selectedNumber, state.recipientCreds.number, state.recipientCreds.id);
  }

  @override
  Future<void> close() {
    _contactsSub.cancel();
    return super.close();
  }
}

bool _defaultFilter(Contact contact) => contact.canSendSms;
