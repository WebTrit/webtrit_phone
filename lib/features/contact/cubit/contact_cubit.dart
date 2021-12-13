import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit(
    Contact contact, {
    required this.contactsRepository,
  }) : super(ContactInitial(contact: contact));

  final ContactsRepository contactsRepository;

  Future<void> getContactPhones() async {
    final phones = await contactsRepository.getContactPhones(state.contact);
    emit(ContactSuccess(contact: state.contact, phones: phones));
  }

  Future<void> addToFavorites(ContactPhone contactPhone) async {
    contactsRepository.addContactPhoneToFavorites(contactPhone);

    await getContactPhones();
  }

  Future<void> removeFromFavorites(ContactPhone contactPhone) async {
    contactsRepository.removeContactPhoneFromFavorites(contactPhone);

    await getContactPhones();
  }
}
