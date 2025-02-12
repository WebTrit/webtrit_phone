import 'dart:async';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../../data/data.dart';

class MockContactsRepository extends Mock implements ContactsRepository {
  final StreamController<Contact?> _contactStreamController = StreamController<Contact?>.broadcast();

  @override
  Stream<Contact?> watchContactBySourceWithPhonesAndEmails(ContactSourceType sourceType, String sourceId) {
    return _contactStreamController.stream;
  }

  void addContactUpdate(Contact? contact) {
    _contactStreamController.add(contact);
  }

  @override
  Future<Contact?> getContactBySource(ContactSourceType sourceType, String sourceId) async {
    return dContactsRepository.firstWhereOrNull(
      (contact) => contact.sourceType == sourceType && contact.sourceId == sourceId,
    );
  }
}
