import 'package:webtrit_phone/models/models.dart';

class ContactsFixtureFactory {
  static ExternalContact createExternalContact(
    int index, {
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
    final i = index.toString();
    return ExternalContact(
      id: id ?? i,
      number: number ?? '100$i',
      ext: ext,
      firstName: firstName ?? 'External',
      lastName: lastName ?? 'User $i',
      aliasName: 'Alias $i',
      email: email ?? 'external.$i@example.com',
      registered: true,
      userRegistered: true,
      isCurrentUser: isCurrentUser,
      smsNumbers: smsNumbers,
      additional: additional,
    );
  }

  static LocalContact createLocalContact(
    int index, {
    String? id,
    String? firstName,
    String? lastName,
    List<LocalContactPhone>? phones,
    List<LocalContactEmail>? emails,
  }) {
    final i = index.toString();
    return LocalContact(
      id: id ?? 'local_$i',
      firstName: firstName ?? 'Local',
      lastName: lastName ?? 'User $i',
      displayName: 'Local Display $i',
      thumbnail: null,
      phones: phones ?? [LocalContactPhone(number: '300$i', label: 'mobile')],
      emails: emails ?? [LocalContactEmail(address: 'local.$i@example.com', label: 'home')],
    );
  }
}
