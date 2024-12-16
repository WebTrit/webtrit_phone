import 'dart:async';
import 'dart:math';

import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';

const _appIdKey = 'app_id_key';

final Logger _logger = Logger('AppIdProvider');

abstract class AppIdProvider {
  Future<String> getId();

  Stream<String> get onIdChange;
}

class FirebaseAppIdProvider implements AppIdProvider {
  final _idChangeController = StreamController<String>.broadcast();

  FirebaseAppIdProvider() {
    _initializeIdListener();
  }

  @override
  Future<String> getId() async {
    try {
      final id = await FirebaseInstallations.instance.getId();
      await _saveIdToSharedPreferences(id);
      return id;
    } catch (e) {
      _logger.severe('Firebase ID fetch failed: $e');
      return _generateFallbackId();
    }
  }

  @override
  Stream<String> get onIdChange => _idChangeController.stream;

  void _initializeIdListener() {
    FirebaseInstallations.instance.onIdChange.listen((id) async {
      await _saveIdToSharedPreferences(id);
      _idChangeController.add(id);
      _logger.info('Firebase ID changed: $id');
    });
  }

  Future<void> _saveIdToSharedPreferences(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_appIdKey, id);
  }

  Future<String> _generateFallbackId() async {
    final prefs = await SharedPreferences.getInstance();

    final newId = _generateRandomId();
    await prefs.setString(_appIdKey, newId);
    _logger.info('Generated fallback ID: $newId');
    return newId;
  }

  String _generateRandomId([int length = 32]) {
    final random = Random();
    return String.fromCharCodes(List.generate(length, (index) => random.nextInt(26) + 97));
  }

  void dispose() {
    _idChangeController.close();
  }
}

class SharedPreferencesAppIdProvider implements AppIdProvider {
  const SharedPreferencesAppIdProvider();

  @override
  Future<String> getId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_appIdKey) ?? 'Undefine';
    } catch (e) {
      _logger.severe(e);
      return 'Undefine';
    }
  }

  @override
  Stream<String> get onIdChange => const Stream.empty();
}
