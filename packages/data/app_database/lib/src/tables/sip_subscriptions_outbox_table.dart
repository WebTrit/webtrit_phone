import 'package:drift/drift.dart';

import 'sip_subscriptions_table.dart';

enum SipSubscriptionOutboxActionData { upsert, delete }

@DataClassName('SipSubscriptionOutboxEntryData')
class SipSubscriptionsOutboxTable extends Table {
  @override
  String get tableName => 'sip_subscriptions_outbox';

  @override
  Set<Column> get primaryKey => {action, type, number};

  TextColumn get action => textEnum<SipSubscriptionOutboxActionData>()();

  TextColumn get type => textEnum<SipSubscriptionTypeData>()();

  TextColumn get number => text()();

  TextColumn get contactUserId => text().nullable()();

  IntColumn get sendAttempts => integer().withDefault(const Constant(0))();

  IntColumn get timestampUsec => integer()();
}
