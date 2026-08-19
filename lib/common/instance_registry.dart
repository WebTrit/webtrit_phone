import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'disposable.dart';

final _logger = Logger('InstanceRegistry');

/// A simple, type-safe container for storing and retrieving initialized object instances.
///
/// The container owns what it holds: whoever built the registry releases it with
/// [dispose], and nothing downstream closes a registered instance on its own.
///
/// Usage:
/// ```dart
/// final registry = InstanceRegistry();
/// registry.register<MyService>(myServiceInstance);
/// final service = registry.get<MyService>();
/// ```
class InstanceRegistry {
  /// Internal storage for instances, mapped by their [Type], in registration order.
  final Map<Type, dynamic> _instances = {};

  var _released = false;

  /// Whether [dispose] has already run.
  bool get isReleased => _released;

  /// Registers an [instance] of type [T] in the registry.
  ///
  /// Throws a [StateError] if an instance of type [T] has already been registered.
  void register<T>(T instance) {
    if (kDebugMode) {
      print('registering instance of type $T');
    }

    if (_instances.containsKey(T)) {
      throw StateError('Instance of type $T is already registered in InstanceRegistry.');
    }

    _instances[T] = instance;
  }

  /// Retrieves the registered instance of type [T].
  ///
  /// Throws a [StateError] if no instance of type [T] has been registered.
  /// This ensures that dependencies are strictly defined and initialized before use.
  T get<T>() {
    if (_released) {
      throw StateError('InstanceRegistry has been released; instance of type $T can no longer be used.');
    }

    final instance = _instances[T];
    if (instance == null) {
      throw StateError(
        'Instance of type $T is not registered in InstanceRegistry. '
        'Ensure it is initialized and registered.',
      );
    }
    return instance as T;
  }

  /// Releases every registered [Disposable], in reverse order of registration.
  ///
  /// Registration follows construction, so the reverse order releases a
  /// dependency before the ones it was built from. Instances that hold no
  /// resources are simply skipped.
  ///
  /// Repeated and concurrent calls do nothing: the first one wins. A failing
  /// release is logged and does not stop the rest - a half-released container
  /// is worse than a noisy log, and the caller is usually going away anyway.
  Future<void> dispose() async {
    if (_released) return;
    _released = true;

    for (final entry in _instances.entries.toList().reversed) {
      final instance = entry.value;
      if (instance is! Disposable) continue;
      try {
        await instance.dispose();
      } catch (e, s) {
        _logger.warning('Failed to release the registered ${entry.key}', e, s);
      }
    }
    _instances.clear();
  }
}
