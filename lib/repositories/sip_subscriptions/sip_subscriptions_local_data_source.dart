import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class SipSubscriptionsLocalDataSource {
  Stream<List<SipSubscription>> watchAll();

  Future<List<SipSubscription>> getAll();

  Future<void> upsert(SipSubscription item);

  Future<void> remove(SipSubscriptionType type, String number);

  Future<void> batchReplace(List<SipSubscription> items, {bool removePrevious = false});

  Future<List<SipSubscriptionOutboxAction>> getAllOutboxActions();

  Future<void> setOutboxAction(SipSubscriptionOutboxAction action, {bool replacePrevAction = false});

  Future<void> removeOutboxAction(SipSubscriptionOutboxAction action);
}

class SipSubscriptionsLocalDataSourceDriftImpl
    with SipSubscriptionsDriftMapper, SipSubscriptionOutboxActionDriftMapper
    implements SipSubscriptionsLocalDataSource {
  SipSubscriptionsLocalDataSourceDriftImpl(this._appDatabase);

  final AppDatabase _appDatabase;
  late final _dao = _appDatabase.sipSubscriptionsDao;

  @override
  Stream<List<SipSubscription>> watchAll() {
    return _dao.watchAll().map((rows) => rows.map(sipSubscriptionFromDrift).toList());
  }

  @override
  Future<List<SipSubscription>> getAll() async {
    final rows = await _dao.getAll();
    return rows.map(sipSubscriptionFromDrift).toList();
  }

  @override
  Future<void> upsert(SipSubscription item) {
    return _dao.upsert(sipSubscriptionToDrift(item));
  }

  @override
  Future<void> remove(SipSubscriptionType type, String number) {
    return _dao.remove(SipSubscriptionTypeData.values.byName(type.name), number);
  }

  @override
  Future<void> batchReplace(List<SipSubscription> items, {bool removePrevious = false}) {
    return _dao.batchReplace(items.map(sipSubscriptionToDrift).toList(), removePrevious: removePrevious);
  }

  @override
  Future<List<SipSubscriptionOutboxAction>> getAllOutboxActions() async {
    final entries = await _dao.getAllOutboxEntries();
    return entries.map(sipSubscriptionOutboxActionFromDrift).toList();
  }

  @override
  Future<void> setOutboxAction(SipSubscriptionOutboxAction action, {bool replacePrevAction = false}) {
    return _dao.setOutboxEntry(sipSubscriptionOutboxActionToDrift(action), replacePrevAction: replacePrevAction);
  }

  @override
  Future<void> removeOutboxAction(SipSubscriptionOutboxAction action) {
    return _dao.removeOutboxEntry(
      SipSubscriptionOutboxActionData.values.byName(action.action.name),
      SipSubscriptionTypeData.values.byName(action.type.name),
      action.number,
    );
  }
}
