import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'keypad_state.dart';

part 'keypad_cubit.freezed.dart';

class KeypadCubit extends Cubit<KeypadState> {
  final ContactsRepository _contactsRepository;

  KeypadCubit(this._contactsRepository) : super(const KeypadState());

  /// Attempts to retrieve and update the contact matching the provided [number].
  ///
  /// Trims leading and trailing whitespace from [number].
  /// - If the cleaned number is empty, the contact state is reset to `null`.
  /// - Otherwise, delegates to [_fetchContact] to perform the asynchronous lookup.
  Future<void> getContactByPhoneNumber(String number) async {
    final cleanedNumber = number.trim();

    if (cleanedNumber.isEmpty) {
      emit(state.copyWith(contact: null));
    } else {
      await _fetchContact(cleanedNumber);
    }
  }

  /// Asynchronously fetches the contact from the repository.
  ///
  /// - On success: updates the state with the retrieved contact.
  /// - On error: resets the contact state to `null`.
  Future<void> _fetchContact(String number) async {
    try {
      final contact = await _contactsRepository.getContactByPhoneNumber(number);
      if (isClosed) return;
      emit(state.copyWith(contact: contact));
    } catch (_) {
      if (isClosed) return;
      emit(state.copyWith(contact: null));
    }
  }
}
