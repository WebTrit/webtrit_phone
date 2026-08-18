import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// Contract for resolving the initial tab of the main application screen.
abstract interface class InitialTabResolver {
  BottomMenuTab resolve();
}

/// Implementation of [InitialTabResolver] that uses [BottomMenuConfig]
/// and [ActiveMainTabRepository] to determine the starting tab.
class BottomMenuInitialTabResolver implements InitialTabResolver {
  const BottomMenuInitialTabResolver({required BottomMenuConfig config, required ActiveMainTabRepository repository})
    : _config = config,
      _repository = repository;

  final BottomMenuConfig _config;
  final ActiveMainTabRepository _repository;

  @override
  BottomMenuTab resolve() {
    // With nothing saved the contacts tab has always been the default, ahead
    // of the configuration's initial flag - kept as is. The bare kind name IS
    // the contacts tab's routePath: that tab encodes no further segments.
    final savedPath = _repository.getActiveTabPath() ?? MainFlavor.contacts.name;
    return _config.findInitialTab(savedPath);
  }
}
