import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

import '../features/main/models/models.dart';
import '../theme/models/models.dart';

final Logger _logger = Logger('AppFeatureAvailability');

class AppFeatureAvailability {
  static late AppFeatureAvailability _instance;

  final BottomMenuFlavorManager bottomMenuFlavorManager;

  AppFeatureAvailability._(this.bottomMenuFlavorManager);

  static Future<void> init(UiComposeSettings uiComposeSettings) async {
    final bottomMenuFlavorManager = BottomMenuFlavorManager();

    final typeCount = <MainFlavorType, int>{};

    final bottomMenuFlavors = uiComposeSettings.bottomMenuTabs.map((flavor) {
      final type = MainFlavorType.values.firstWhere((type) => type.value == flavor.type);

      final typePosition = typeCount.update(type, (value) => value + 1, ifAbsent: () => 1);
      final path = typePosition == 1 ? '${type.value}/1' : '${type.value}/$typePosition';

      final data = flavor.data != null ? FlavorData(url: flavor.data!.url, path: path) : null;

      _logger.info('Flavor: ${flavor.title} - $path');
      return MainFlavor(
        icon: flavor.icon,
        title: flavor.title,
        type: type,
        path: path,
        initial: flavor.initial,
        data: data,
      );
    }).toList();

    bottomMenuFlavorManager.addFlavors(bottomMenuFlavors);

    _instance = AppFeatureAvailability._(bottomMenuFlavorManager);
  }

  factory AppFeatureAvailability() => _instance;
}

class BottomMenuFlavorManager {
  final List<MainFlavor> _flavors = [];
  MainFlavor? _activeFlavor;

  MainFlavor get activeFlavor =>
      _activeFlavor ?? _flavors.firstWhereOrNull((flavor) => flavor.initial) ?? _flavors.last;

  int get activeIndex => flavors.indexOf(activeFlavor);

  set activeFlavor(MainFlavor flavor) {
    if (!_flavors.contains(flavor)) {
      throw Exception('Flavor not found');
    }
    _activeFlavor = flavor;
  }

  List<MainFlavor> getEmbeddedFlavors() {
    return _flavors.where((flavor) => flavor.type == MainFlavorType.embedded).toList();
  }

  MainFlavor? getFlavorByUniqueId(String uniqueId) {
    return _flavors.firstWhereOrNull((flavor) => flavor.path == uniqueId);
  }

  String getRedirectTo() {
    var redirect = flavors.firstWhereOrNull((it) => it.initial)!.path;
    _logger.info('Redirect to: $redirect');
    return redirect;
  }

  MainFlavor flavorByPosition(int position) {
    if (position >= 0 && position < _flavors.length) {
      return _flavors[position];
    }
    return _flavors.isNotEmpty ? _flavors.first : throw Exception('No flavors available');
  }

  int positionOfFlavor(MainFlavor flavor) => _flavors.indexOf(flavor);

  void addFlavors(List<MainFlavor> flavors) {
    for (var flavor in flavors) {
      addFlavor(flavor);
    }
  }

  void addFlavor(MainFlavor flavor) {
    if (!_flavors.contains(flavor)) {
      _flavors.add(flavor);
    }
  }

  List<MainFlavor> get flavors => List.unmodifiable(_flavors);

  String? getFlavorPathIfExists(MainFlavorType type) {
    // final flavors = _flavors.where((flavor) => flavor.type == type).toList();
    // if (flavors.isNotEmpty) {
    //   return flavors.map((flavor) => flavor.hashCode).join(', ');
    // }
    return type.value;
  }
}
