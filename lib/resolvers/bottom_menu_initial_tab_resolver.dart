import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// Contract for resolving the initial tab of the main application screen.
abstract interface class InitialTabResolver {
  BottomMenuTab resolve();
}

/// Implementation of [InitialTabResolver] that uses [BottomMenuConfig]
/// and [ActiveMainFlavorRepository] to determine the starting tab.
class BottomMenuInitialTabResolver implements InitialTabResolver {
  const BottomMenuInitialTabResolver({required BottomMenuConfig config, required ActiveMainFlavorRepository repository})
    : _config = config,
      _repository = repository;

  final BottomMenuConfig _config;
  final ActiveMainFlavorRepository _repository;

  @override
  BottomMenuTab resolve() {
    final savedFlavor = _repository.getActiveMainFlavor();
    return _config.findInitialTab(savedFlavor);
  }
}
