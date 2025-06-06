import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class that observes and handles changes in the application's lifecycle state.
/// Across different instances, it can either be in
///   - master mode for main isolate
///   - slave mode for background isolate.
class AppLifecycle with WidgetsBindingObserver {
  static late AppLifecycle _instance;
  factory AppLifecycle() => _instance;
  AppLifecycle._(this._sharedPreferences, this.masterMode) {
    if (masterMode) {
      WidgetsBinding.instance.addObserver(this);
      final initialState = WidgetsFlutterBinding.ensureInitialized().lifecycleState;
      if (initialState != null) _setLifecycleState(initialState);
    }
  }

  static const _prefsKey = 'app_lifecycle_state';
  final SharedPreferences _sharedPreferences;
  final bool masterMode;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _setLifecycleState(state);
  }

  void _setLifecycleState(AppLifecycleState state) {
    _sharedPreferences.setString(_prefsKey, state.name.toString());
  }

  static Future<AppLifecycle> initMaster() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _instance = AppLifecycle._(sharedPreferences, true);
    return _instance;
  }

  static Future<AppLifecycle> initSlave() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    _instance = AppLifecycle._(sharedPreferences, false);
    return _instance;
  }

  AppLifecycleState? getLifecycleState() {
    final stateString = _sharedPreferences.getString(_prefsKey);
    if (stateString == null) return null;
    return AppLifecycleState.values.byName(stateString);
  }
}
