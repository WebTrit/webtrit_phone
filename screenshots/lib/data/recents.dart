import 'package:clock/clock.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

final dRecents = [
  Recent(
    direction: Direction.incoming,
    number: '1234',
    video: false,
    createdTime: clock.nowBased(hour: 9, minute: 30),
    aliasName: 'Thomas Anderson',
  ),
  Recent(
    direction: Direction.incoming,
    number: '1234',
    video: false,
    createdTime: clock.nowBased(hour: 9, minute: 00),
    acceptedTime: clock.nowBased(hour: 9, minute: 01),
    hungUpTime: clock.nowBased(hour: 9, minute: 10),
    aliasName: 'Thomas Anderson',
  ),
  Recent(
    direction: Direction.outgoing,
    number: '3344',
    video: true,
    createdTime: clock.nowBased(hour: 8, minute: 41),
    acceptedTime: clock.nowBased(hour: 12, minute: 01),
    hungUpTime: clock.nowBased(hour: 12, minute: 10),
    aliasName: 'Dion Dames',
  ),
];
