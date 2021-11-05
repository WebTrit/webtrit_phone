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

  void getContactPhones() async {
    final phones = await contactsRepository.getContactPhones(state.contact);
    emit(ContactSuccess(contact: state.contact, phones: phones));
  }
}
