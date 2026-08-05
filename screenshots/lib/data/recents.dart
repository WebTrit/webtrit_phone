import 'package:clock/clock.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

// Fixed timestamp so the presence-driven screenshots stay deterministic.
final _presenceAt = DateTime.utc(2024, 1, 1);

PresenceInfo _presence(String number, {required bool available, List<PresenceActivity> activities = const []}) {
  return PresenceInfo(
    id: number,
    number: number,
    available: available,
    note: '',
    statusIcon: null,
    device: null,
    timeOffsetMin: null,
    timestamp: _presenceAt,
    activities: activities,
    source: PresenceInfoSource.sip,
    arrivalTime: _presenceAt,
  );
}

/// 🔹 Mock recent call history data for testing call logs & contact integration
final dMockRecentCallHistory = [
  Recent(
    callLogEntry: CallLogEntry(
      id: 1,
      direction: CallDirection.incoming,
      number: '1234',
      video: false,
      createdTime: clock.nowBased(hour: 9, minute: 30),
    ),
    contact: Contact(
      id: 1,
      sourceType: ContactSourceType.local,
      kind: ContactKind.visible,
      sourceId: '1',
      firstName: 'Thomas',
      lastName: 'Anderson',
      presenceInfo: [_presence('1234', available: true)],
    ),
  ),
  Recent(
    callLogEntry: CallLogEntry(
      id: 2,
      direction: CallDirection.incoming,
      number: '1234',
      video: false,
      createdTime: clock.nowBased(hour: 9, minute: 00),
      acceptedTime: clock.nowBased(hour: 9, minute: 01),
      hungUpTime: clock.nowBased(hour: 9, minute: 10),
    ),
    contact: Contact(
      id: 2,
      sourceType: ContactSourceType.local,
      kind: ContactKind.visible,
      sourceId: '2',
      firstName: 'Thomas',
      lastName: 'Anderson',
      presenceInfo: [
        _presence('1234', available: true, activities: [PresenceActivity.onThePhone]),
      ],
    ),
  ),
  Recent(
    callLogEntry: CallLogEntry(
      id: 3,
      direction: CallDirection.outgoing,
      number: '3344',
      video: true,
      createdTime: clock.nowBased(hour: 8, minute: 41),
      acceptedTime: clock.nowBased(hour: 12, minute: 01),
      hungUpTime: clock.nowBased(hour: 12, minute: 10),
    ),
    contact: Contact(
      id: 3,
      sourceType: ContactSourceType.local,
      kind: ContactKind.visible,
      sourceId: '3',
      firstName: 'Dion',
      lastName: 'Dames',
      presenceInfo: [
        _presence('3344', available: true, activities: [PresenceActivity.meeting]),
      ],
    ),
  ),
  Recent(
    callLogEntry: CallLogEntry(
      id: 4,
      direction: CallDirection.incoming,
      number: '1234',
      video: false,
      createdTime: clock.nowBased(hour: 9, minute: 00),
      acceptedTime: clock.nowBased(hour: 9, minute: 01),
      hungUpTime: clock.nowBased(hour: 9, minute: 10),
    ),
    contact: Contact(
      id: 4,
      sourceType: ContactSourceType.external,
      kind: ContactKind.visible,
      sourceId: '4',
      firstName: 'Stuart',
      lastName: 'Peterson',
      presenceInfo: [_presence('1234', available: false)],
    ),
  ),
  Recent(
    callLogEntry: CallLogEntry(
      id: 5,
      direction: CallDirection.incoming,
      number: '1234',
      video: false,
      createdTime: clock.nowBased(hour: 9, minute: 00),
      acceptedTime: clock.nowBased(hour: 9, minute: 01),
      hungUpTime: clock.nowBased(hour: 9, minute: 10),
    ),
    contact: Contact(
      id: 5,
      sourceType: ContactSourceType.external,
      kind: ContactKind.visible,
      sourceId: '5',
      firstName: 'Alex',
      lastName: 'Bloom',
      presenceInfo: [
        _presence('1234', available: false, activities: [PresenceActivity.away]),
      ],
    ),
  ),
];
