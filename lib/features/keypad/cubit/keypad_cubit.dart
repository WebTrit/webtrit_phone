import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/debounce.dart';

part 'keypad_state.dart';

part 'keypad_cubit.freezed.dart';

class KeypadCubit extends Cubit<KeypadState> {
  KeypadCubit(this._contactsRepository) : super(KeypadState());

  final ContactsRepository _contactsRepository;
  final _contactDebounce = Debounce();

  /// Sets current value and attempts to retrieve and update the contact matching the provided [number].
  ///
  /// Trims leading and trailing whitespace from [number].
  /// - If the cleaned number is empty, the contact state is reset to `null`.
  /// - Otherwise, delegates to [_fetchContact] to perform the asynchronous lookup.
  Future<void> setValue(String number) async {
    final cleanedNumber = number.trim();

    emit(state.copyWith(contact: null, value: number));
    if (cleanedNumber.isNotEmpty) _contactDebounce.schedule(() => _fetchContact(cleanedNumber));
  }

  /// Asynchronously fetches the contact from the repository.
  ///
  /// - On success: updates the state with the retrieved contact.
  /// - On error: resets the contact state to `null`.
  Future<void> _fetchContact(String number) async {
    final contact = await _contactsRepository.getContactByPhoneNumber(number);
    if (isClosed) return;

    emit(state.copyWith(contact: contact));
  }

  @override
  Future<void> close() {
    _contactDebounce.dispose();
    return super.close();
  }
}
