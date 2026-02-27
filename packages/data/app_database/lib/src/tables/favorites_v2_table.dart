import 'package:drift/drift.dart';

enum FavoriteSourceTypeData { device, pbx }

@DataClassName('FavoriteV2Data')
class FavoritesV2Table extends Table {
  @override
  String get tableName => 'favorites_v2';

  @override
  Set<Column> get primaryKey => {number, sourceType};

  TextColumn get number => text()();

  TextColumn get sourceType => textEnum<FavoriteSourceTypeData>()();

  TextColumn get sourceId => text()();

  TextColumn get label => text()();

  IntColumn get position => integer()();
}
