import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// Resolves contacts through the (mock) [ContactsRepository] for previews.
///
/// Skips the self-number check of [DefaultContactResolver], which needs a
/// [UserRepository] the screenshot harness does not provide.
class MockContactResolver implements ContactResolver {
  const MockContactResolver(this._contactsRepository);

  final ContactsRepository _contactsRepository;

  @override
  Future<Contact?> resolve(String? number) async {
    if (number == null || number.isEmpty) return null;
    try {
      return await _contactsRepository.getContactByPhoneNumber(number);
    } catch (_) {
      return null;
    }
  }
}
