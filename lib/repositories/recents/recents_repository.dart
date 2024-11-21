import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

class RecentsRepository {
  RecentsRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Recent>> watchRecents() {
    return _appDatabase.recentsDao
        .watchLastRecents()
        .map((callLogsExt) => callLogsExt.map(_toRecent).toList(growable: false));
  }

  Future<void> deleteByCallId(int id) async {
    await _appDatabase.recentsDao.deleteRecent(id);
  }

  Future<Recent> getRecentByCallId(int id) {
    return _appDatabase.recentsDao.getRecentByCallId(id).then(_toRecent);
  }

  Recent _toRecent(RecentData data) {
    Contact? contact;

    if (data.contactData != null) {
      final email = data.contactEmails.firstOrNull?.address;
      final gravatarUrl = gravatarThumbnailUrl(email);

      contact = Contact(
        id: data.contactData!.id,
        sourceType: data.contactData!.sourceType.toModel(),
        sourceId: data.contactData!.sourceId,
        registered: data.contactData!.registered,
        userRegistered: data.contactData!.userRegistered,
        isCurrentUser: data.contactData!.isCurrentUser,
        firstName: data.contactData!.firstName,
        lastName: data.contactData!.lastName,
        aliasName: data.contactData!.aliasName,
        thumbnail: data.contactData!.thumbnail,
        thumbnailUrl: gravatarUrl,
        phones: data.contactPhones.map(_toRealContactPhone).toList(),
        emails: data.contactEmails.map(_toContactEmail).toList(),
      );
    }

    return Recent(
      callLogEntry: CallLogEntry(
        id: data.callLog.id,
        direction: CallDirection.values.byName(data.callLog.direction.name),
        number: data.callLog.number,
        video: data.callLog.video,
        createdTime: data.callLog.createdAt,
        acceptedTime: data.callLog.acceptedAt,
        hungUpTime: data.callLog.hungUpAt,
      ),
      contact: contact,
    );
  }

  ContactPhone _toRealContactPhone(ContactPhoneData data) {
    return ContactPhone(
      id: data.id,
      number: data.number,
      label: data.label,
      favorite: false,
    );
  }

  ContactEmail _toContactEmail(ContactEmailData data) {
    return ContactEmail(
      id: data.id,
      address: data.address,
      label: data.label,
    );
  }
}
