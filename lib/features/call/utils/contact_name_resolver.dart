import 'package:webtrit_phone/repositories/contacts/contacts_repository.dart';

abstract class ContactNameResolver {
  Future<String?> resolveWithNumber(String? number);
}

class DefaultContactNameResolver implements ContactNameResolver {
  const DefaultContactNameResolver({required this.contactRepository});
  final ContactsRepository contactRepository;

  @override
  Future<String?> resolveWithNumber(String? number) async {
    if (number == null) return '';
    final contact = await contactRepository.getContactByPhoneNumber(number);
    return contact?.maybeName;
  }
}
