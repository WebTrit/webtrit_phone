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

// Each favorite carries a distinct presence so the preview showcases the
// available/unavailable colors and the activity icons rendered on top of them.
final dFavorites = <FavoriteWithContact>[
  (
    favorite: Favorite(number: '1234', sourceType: FavoriteSourceType.device, sourceId: '1', label: 'ext', position: 0),
    contact: Contact(
      id: 0,
      sourceType: ContactSourceType.external,
      kind: ContactKind.visible,
      sourceId: '1',
      registered: true,
      aliasName: 'Thomas Anderson',
      presenceInfo: [_presence('1234', available: true)],
    ),
  ),
  (
    favorite: Favorite(number: '2345', sourceType: FavoriteSourceType.device, sourceId: '2', label: 'ext', position: 1),
    contact: Contact(
      id: 0,
      sourceType: ContactSourceType.external,
      kind: ContactKind.visible,
      sourceId: '2',
      registered: false,
      aliasName: 'Anna Collins',
      presenceInfo: [_presence('2345', available: false)],
    ),
  ),
  (
    favorite: Favorite(number: '3456', sourceType: FavoriteSourceType.device, sourceId: '3', label: 'ext', position: 2),
    contact: Contact(
      id: 0,
      sourceType: ContactSourceType.external,
      kind: ContactKind.visible,
      sourceId: '3',
      registered: true,
      aliasName: 'Lawrence Brown',
      presenceInfo: [
        _presence('3456', available: true, activities: [PresenceActivity.onThePhone]),
      ],
    ),
  ),
  (
    favorite: Favorite(number: '4567', sourceType: FavoriteSourceType.device, sourceId: '4', label: 'ext', position: 3),
    contact: Contact(
      id: 0,
      sourceType: ContactSourceType.external,
      kind: ContactKind.visible,
      sourceId: '4',
      registered: true,
      aliasName: 'Ruth Jenkins',
      presenceInfo: [
        _presence('4567', available: true, activities: [PresenceActivity.doNotDisturb]),
      ],
    ),
  ),
  (
    favorite: Favorite(number: '5678', sourceType: FavoriteSourceType.device, sourceId: '5', label: 'ext', position: 4),
    contact: Contact(
      id: 0,
      sourceType: ContactSourceType.external,
      kind: ContactKind.visible,
      sourceId: '5',
      registered: true,
      aliasName: 'Beverly Nelson',
      presenceInfo: [
        _presence('5678', available: true, activities: [PresenceActivity.meeting]),
      ],
    ),
  ),
  (
    favorite: Favorite(number: '6789', sourceType: FavoriteSourceType.device, sourceId: '6', label: 'ext', position: 5),
    contact: Contact(
      id: 0,
      sourceType: ContactSourceType.external,
      kind: ContactKind.visible,
      sourceId: '6',
      registered: false,
      aliasName: 'Randy Jones',
      presenceInfo: [
        _presence('6789', available: false, activities: [PresenceActivity.away]),
      ],
    ),
  ),
];
