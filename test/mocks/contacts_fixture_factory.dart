import 'package:webtrit_phone/models/models.dart';

class ContactsFixtureFactory {
  static ExternalContact createExternalContact({
    String? id,
    String? number,
    String? ext,
    String? firstName,
    String? lastName,
    String? email,
    List<String>? smsNumbers,
    List<String>? additional,
    bool isCurrentUser = false,
  }) {
    return ExternalContact(
      id: id,
      number: number ?? '100$id',
      ext: ext,
      firstName: firstName ?? 'External',
      lastName: lastName ?? 'User $id',
      aliasName: 'Alias $id',
      email: email ?? 'external.$id@example.com',
      registered: true,
      userRegistered: true,
      isCurrentUser: isCurrentUser,
      smsNumbers: smsNumbers,
      additional: additional,
    );
  }

  static LocalContact createLocalContact({
    String? id,
    String? firstName,
    String? lastName,
    List<LocalContactPhone>? phones,
    List<LocalContactEmail>? emails,
  }) {
    return LocalContact(
      id: id ?? 'local_$id',
      firstName: firstName ?? 'Local',
      lastName: lastName ?? 'User $id',
      displayName: 'Local Display $id',
      thumbnail: null,
      phones: phones ?? [LocalContactPhone(number: '300$id', label: 'mobile')],
      emails: emails ?? [LocalContactEmail(address: 'local.$id@example.com', label: 'home')],
    );
  }
}
