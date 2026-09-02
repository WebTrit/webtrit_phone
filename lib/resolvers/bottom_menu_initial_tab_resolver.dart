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
    // An install that does not reopen the last section has nothing to look up:
    // the configuration's initial flag decides, which is the only thing that
    // flag is for.
    if (!_config.remembersSelectedTab) return _config.findInitialTab(null);

    // With nothing saved the contacts tab has always been the default, ahead
    // of the configuration's initial flag - kept as is. The bare kind name is
    // enough to find it: a contacts tab that offers the favourites filter
    // appends a segment, and the lookup falls back to matching on kind.
    final savedPath = _repository.getActiveTabPath() ?? MainFlavor.contacts.name;
    return _config.findInitialTab(savedPath);
  }
}
