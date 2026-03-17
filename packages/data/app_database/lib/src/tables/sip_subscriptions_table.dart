import 'package:drift/drift.dart';

enum SipSubscriptionTypeData { blf, presence }

@DataClassName('SipSubscriptionData')
class SipSubscriptionsTable extends Table {
  @override
  String get tableName => 'sip_subscriptions';

  @override
  Set<Column> get primaryKey => {type, number};

  TextColumn get type => textEnum<SipSubscriptionTypeData>()();

  TextColumn get number => text()();

  TextColumn get contactUserId => text()();

  IntColumn get subscribedAtUsec => integer()();
}
