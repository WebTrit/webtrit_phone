import 'package:webtrit_phone/models/models.dart';

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
    ),
  ),
  (
    favorite: Favorite(number: '4567', sourceType: FavoriteSourceType.device, sourceId: '4', label: 'ext', position: 3),
    contact: Contact(
      id: 0,
      sourceType: ContactSourceType.external,
      kind: ContactKind.visible,
      sourceId: '4',
      registered: false,
      aliasName: 'Ruth Jenkins',
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
    ),
  ),
];
