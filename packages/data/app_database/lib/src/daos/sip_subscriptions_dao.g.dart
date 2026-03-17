// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sip_subscriptions_dao.dart';

// ignore_for_file: type=lint
mixin _$SipSubscriptionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SipSubscriptionsTableTable get sipSubscriptionsTable =>
      attachedDatabase.sipSubscriptionsTable;
  $SipSubscriptionsOutboxTableTable get sipSubscriptionsOutboxTable =>
      attachedDatabase.sipSubscriptionsOutboxTable;
  SipSubscriptionsDaoManager get managers => SipSubscriptionsDaoManager(this);
}

class SipSubscriptionsDaoManager {
  final _$SipSubscriptionsDaoMixin _db;
  SipSubscriptionsDaoManager(this._db);
  $$SipSubscriptionsTableTableTableManager get sipSubscriptionsTable =>
      $$SipSubscriptionsTableTableTableManager(
        _db.attachedDatabase,
        _db.sipSubscriptionsTable,
      );
  $$SipSubscriptionsOutboxTableTableTableManager
  get sipSubscriptionsOutboxTable =>
      $$SipSubscriptionsOutboxTableTableTableManager(
        _db.attachedDatabase,
        _db.sipSubscriptionsOutboxTable,
      );
}
