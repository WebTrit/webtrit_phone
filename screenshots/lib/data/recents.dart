import 'package:clock/clock.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

final dRecents = [
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
      sourceId: '1',
      firstName: 'Thomas',
      lastName: 'Anderson',
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
      sourceId: '2',
      firstName: 'Thomas',
      lastName: 'Anderson',
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
      sourceId: '3',
      firstName: 'Dion',
      lastName: 'Dames',
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
      sourceId: '4',
      firstName: 'Stu',
      lastName: 'Pedaso',
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
      sourceId: '5',
      firstName: 'Zeliboba',
      lastName: 'Sheshera',
    ),
  ),
];
