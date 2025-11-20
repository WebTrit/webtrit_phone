import 'package:flutter/foundation.dart';

/// A simple, type-safe container for storing and retrieving initialized object instances.
///
/// Usage:
/// ```dart
/// final registry = InstanceRegistry();
/// registry.register<MyService>(myServiceInstance);
/// final service = registry.get<MyService>();
/// ```
class InstanceRegistry {
  /// Internal storage for instances, mapped by their [Type].
  final Map<Type, dynamic> _instances = {};

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
    final instance = _instances[T];
    if (instance == null) {
      throw StateError(
        'Instance of type $T is not registered in InstanceRegistry. '
        'Ensure it is initialized and registered.',
      );
    }
    return instance as T;
  }
}
