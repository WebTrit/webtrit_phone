import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('RecentsRepository');

class RecentsRepository
    with DialogInfoDriftMapper, PresenceInfoDriftMapper, CallLogsDriftMapper, ContactsDriftMapper, RecentsDriftMapper {
  RecentsRepository({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  final AppDatabase _appDatabase;

  Stream<List<Recent>> watchRecents() {
    return _appDatabase.recentsDao.watchLastRecents().map((callLogsExt) {
      return callLogsExt
          .map((data) {
            final recent = recentFromDrift(data);
            final entry = recent.callLogEntry;
            final contact = recent.contact;

            final numberHash = entry.number.hashCode;
            final usernameHash = entry.username?.hashCode;
            final contactNameHash = contact?.maybeName?.hashCode;
            final resolvedNameHash = recent.name.hashCode;

            final nameSource = contact?.maybeName != null
                ? 'contact.maybeName'
                : entry.username != null
                ? 'callLog.username'
                : 'callLog.number';

            final mismatch = recent.name != entry.number;

            if (mismatch) {
              _logger.warning(
                '[Recents:mismatch] '
                'id=${entry.id} '
                'direction=${entry.direction.name} '
                'number=${entry.number} '
                'number.hash=$numberHash '
                'username=${entry.username} '
                'username.hash=$usernameHash '
                'contactName=${contact?.maybeName} '
                'contactName.hash=$contactNameHash '
                'resolvedName=${recent.name} '
                'resolvedName.hash=$resolvedNameHash '
                'nameSource=$nameSource '
                'hasContact=${contact != null} '
                'contactId=${contact?.id} '
                'contactSourceType=${contact?.sourceType} '
                'contactPhonesCount=${contact?.phones.length ?? 0} '
                'numberEqualsUsername=${entry.number == entry.username}',
              );
            }

            return recent;
          })
          .toList(growable: false);
    });
  }

  Future<void> deleteByCallId(int id) async {
    await _appDatabase.recentsDao.deleteRecent(id);
  }

  Future<Recent> getRecentByCallId(int id) {
    return _appDatabase.recentsDao.getRecentByCallId(id).then(recentFromDrift);
  }
}
