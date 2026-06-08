import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

abstract class ContactResolver {
  Future<Contact?> resolve(String? number);
}

class DefaultContactResolver implements ContactResolver {
  const DefaultContactResolver({required this.contactsRepository, required this.userRepository});

  final ContactsRepository contactsRepository;
  final UserRepository userRepository;

  @override
  Future<Contact?> resolve(String? number) async {
    if (number == null || number.isEmpty) return null;

    // Self-call: the current user is excluded from the synced PBX contacts, so for
    // our own number only a stale local phonebook entry could match and it would
    // override our identity on the call screen. Skip resolution and let the caller
    // fall back to the signaling-provided name.
    if (_isOwnNumber(number)) return null;

    try {
      return await contactsRepository.getContactByPhoneNumber(number);
    } catch (_) {
      return null;
    }
  }

  bool _isOwnNumber(String number) {
    final numbers = userRepository.getLocalInfo()?.numbers;
    if (numbers == null) return false;
    return number == numbers.ext || number == numbers.main || (numbers.additional?.contains(number) ?? false);
  }
}
