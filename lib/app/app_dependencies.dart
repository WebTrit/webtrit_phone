import 'dart:collection';

import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/theme.dart';

final _logger = Logger('AppDependencies');

/// A reactive config input: the [initial] value for the first frame plus an
/// [updates] factory that creates the stream replacing it as it changes.
///
/// [updates] is a factory (not a ready stream) so every provider subscription
/// gets a fresh stream - the FeatureAccess stream is single-subscription and
/// reactive (it follows runtime system-info / remote-config changes), so a
/// re-created provider must be able to listen again without throwing or going
/// stale.
typedef ConfigSource<T> = ({T initial, Stream<T> Function() updates});

/// The configuration sources rendered by the widget tree after bootstrap has
/// finished using its operational configuration.
typedef AppPresentationConfig = ({
  ConfigSource<FeatureAccess> featureAccess,
  ConfigSource<ThemeSettings> themeSettings,
});

/// Lets a host replace only what the widget tree renders, without changing the
/// configuration bootstrap uses to initialize services.
typedef AppPresentationConfigBuilder = AppPresentationConfig Function(AppPresentationConfig defaults);

/// Collects the application while it starts.
///
/// Everything long-lived is handed to the builder as it is created, which is
/// what makes the two decisions - who owns it and who may see it - a property
/// of the line that creates it rather than of a list somewhere else:
///
/// * [keep] - the app owns it and releases it; the widget tree never sees it.
/// * [share] - the same, and the tree receives it as an inherited value.
///
/// Release runs in reverse, so registering after whatever a thing was built
/// from is enough to release it in the right order - and that ordering now
/// follows construction by itself, because a thing cannot be shared before it
/// exists.
class AppDependenciesBuilder {
  /// Preserves creation order so teardown can release dependants before the
  /// objects they were built from.
  final _owned = <Object>[];

  /// Guards ownership by identity: two equal value objects may still represent
  /// distinct resources, while the same resource must never be released twice.
  final _ownedInstances = HashSet<Object>.identity();

  /// Keeps tree visibility separate from ownership: only [share] adds here,
  /// while both [share] and [keep] add to [_owned].
  final _providers = <SingleChildWidget>[];

  /// Prevents one provider from silently shadowing another provider of the
  /// same type in `MultiProvider`.
  final _sharedTypes = <Type>{};

  /// Seals the builder after [build], so two application objects cannot claim
  /// ownership of the same collected dependencies.
  var _built = false;

  /// Owns [instance] without showing it to the widget tree. For the few things
  /// that exist only so they keep running - and so they can be stopped.
  T keep<T>(T instance) {
    _ensureCollecting();
    _own(instance as Object);
    return instance;
  }

  /// Owns [instance] and hands it to the widget tree, where screens read it
  /// with `context.read<T>()`.
  ///
  /// The tree receives it by value, so no provider can close it: the app owns
  /// it for as long as it runs (see `docs/dependency_ownership.md`).
  T share<T>(T instance) {
    _ensureCollecting();
    if (!_sharedTypes.add(T)) {
      throw StateError('Dependency of type $T is already shared.');
    }

    try {
      _own(instance as Object);
    } catch (_) {
      _sharedTypes.remove(T);
      rethrow;
    }

    _providers.add(Provider<T>.value(value: instance));
    return instance;
  }

  /// Seals the collected dependencies into the started application.
  AppDependencies build({
    required ConfigSource<FeatureAccess> featureAccess,
    required ConfigSource<ThemeSettings> themeSettings,
    required SystemInfoRepository systemInfo,
  }) {
    _ensureCollecting();
    _built = true;

    return AppDependencies._(
      owned: List.unmodifiable(_owned),
      providers: List.unmodifiable(_providers),
      featureAccess: featureAccess,
      themeSettings: themeSettings,
      systemInfo: systemInfo,
    );
  }

  void _ensureCollecting() {
    if (_built) {
      throw StateError('AppDependenciesBuilder has already been built.');
    }
  }

  void _own(Object instance) {
    if (!_ownedInstances.add(instance)) {
      throw StateError('${instance.runtimeType} is already owned by this builder.');
    }
    _owned.add(instance);
  }
}

/// The application, started: what `bootstrap()` hands back.
///
/// Two things can be done with it - give the widget tree what it may see
/// ([providers]) and shut the application down ([dispose]). There is
/// deliberately no lookup by type: a widget is given its dependencies, it does
/// not go looking for them, and that rule holds by construction because there
/// is nothing to call.
///
/// Anything needed outside the tree is a named member, so widening that access
/// is a visible edit with a reason attached, instead of one more lookup lost in
/// a thousand lines.
class AppDependencies {
  AppDependencies._({
    required List<Object> owned,
    required List<SingleChildWidget> providers,
    required this.featureAccess,
    required this.themeSettings,
    required this.systemInfo,
  }) : _owned = owned,
       providers = providers;

  final List<Object> _owned;

  /// Everything the widget tree may see, ready to be spread into a
  /// `MultiProvider`.
  final List<SingleChildWidget> providers;

  /// The configuration the app renders with, as selected during bootstrap.
  /// An embedding host can replace the defaults through
  /// `bootstrap(configurePresentation: ...)`.
  final ConfigSource<FeatureAccess> featureAccess;
  final ConfigSource<ThemeSettings> themeSettings;

  /// The one member a host needs before the app is mounted: the theme
  /// configurator asks the real backend what it supports so its preview can
  /// default to those capabilities.
  final SystemInfoRepository systemInfo;

  var _released = false;

  /// Whether [dispose] has already run.
  bool get isReleased => _released;

  /// Releases everything the application owns, in reverse order of creation.
  ///
  /// Repeated and concurrent calls do nothing: the first one wins. A failing
  /// release is logged and does not stop the rest - a half-released app is
  /// worse than a noisy log, and the caller is usually going away anyway.
  Future<void> dispose() async {
    if (_released) return;
    _released = true;

    for (final instance in _owned.reversed) {
      if (instance is! Disposable) continue;
      try {
        await instance.dispose();
      } catch (e, s) {
        _logger.warning('Failed to release ${instance.runtimeType}', e, s);
      }
    }
  }
}
