import 'package:drift/drift.dart';

@DataClassName('UserSmsNumberData')
class UserSmsNumbersTable extends Table {
  @override
  String get tableName => 'user_sms_numbers';

  @override
  Set<Column> get primaryKey => {phoneNumber};

  TextColumn get phoneNumber => text()();
}
