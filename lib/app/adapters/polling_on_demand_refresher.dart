import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/services/services.dart';

/// Implements the contacts refresh port on top of [PollingService]: the
/// forced refresh goes through the schedule owner, so it cannot race a
/// periodic tick and pushes the next one a full interval away.
class PollingContactsRefresher implements ContactsRefresher {
  const PollingContactsRefresher({required PollingService pollingService, required Refreshable listener})
    : _pollingService = pollingService,
      _listener = listener;

  final PollingService _pollingService;
  final Refreshable _listener;

  @override
  Future<void> refreshNow() => _pollingService.refreshListener(_listener);
}
