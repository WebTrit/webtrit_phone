import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/services/services.dart';

/// Implements the [OnDemandRefresher] port on top of [PollingService]: the
/// forced refresh goes through the schedule owner, so it cannot race a
/// periodic tick and pushes the next one a full interval away.
class PollingOnDemandRefresher implements OnDemandRefresher {
  const PollingOnDemandRefresher({required PollingService pollingService, required Refreshable listener})
    : _pollingService = pollingService,
      _listener = listener;

  final PollingService _pollingService;
  final Refreshable _listener;

  @override
  Future<void> refreshNow() => _pollingService.refreshListener(_listener);
}

/// The contacts instance of the polling-backed refresher, typed with the
/// narrow port so dependency lookup cannot hand it to another consumer.
class PollingContactsRefresher extends PollingOnDemandRefresher implements ContactsRefresher {
  const PollingContactsRefresher({required super.pollingService, required super.listener});
}
