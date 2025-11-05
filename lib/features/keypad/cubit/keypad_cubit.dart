import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'keypad_state.dart';

part 'keypad_cubit.freezed.dart';

class KeypadCubit extends Cubit<KeypadState> {
  final ContactsRepository _contactsRepository;

  KeypadCubit(ContactsRepository contactsRepository)
    : _contactsRepository = contactsRepository,
      super(const KeypadState());

  void getContactByPhoneNumber(String number) async {
    final contact = await _contactsRepository.getContactByPhoneNumber(number);
    emit(KeypadState(contact: contact));
  }
}
