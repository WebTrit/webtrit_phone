import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

abstract class ContactResolver {
  Future<Contact?> resolve(String? number);
}

class DefaultContactResolver implements ContactResolver {
  const DefaultContactResolver({required this.contactsRepository});

  final ContactsRepository contactsRepository;

  @override
  Future<Contact?> resolve(String? number) async {
    if (number == null || number.isEmpty) return null;
    try {
      return await contactsRepository.getContactByPhoneNumber(number);
    } catch (_) {
      return null;
    }
  }
}
