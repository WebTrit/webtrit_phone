import 'dart:async';

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('$ExternalContactsRepository');

class ExternalContactsRepository {
  ExternalContactsRepository({
    required WebtritApiClient webtritApiClient,
    required String token,
    bool periodicPolling = true,
  })  : _webtritApiClient = webtritApiClient,
        _token = token,
        _periodicPolling = periodicPolling {
    _controller = StreamController<List<ExternalContact>>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
    _listenedCounter = 0;
  }

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final bool _periodicPolling;

  late StreamController<List<ExternalContact>> _controller;
  late int _listenedCounter;
  Timer? _periodicTimer;

  List<ExternalContact>? _cacheContacts;

  Stream<List<ExternalContact>> contacts() {
    return _controller.stream;
  }

  Future<void> load() async {
    final contacts = await _listContacts();
    _cacheContacts = contacts;
    _controller.add(contacts);
  }

  void _onListenCallback() {
    if (_periodicPolling && _listenedCounter++ == 0) {
      _periodicTimer = Timer.periodic(const Duration(seconds: 60), (timer) => _gatherListContacts());
    }
  }

  void _onCancelCallback() {
    if (_periodicPolling && --_listenedCounter == 0) {
      _periodicTimer?.cancel();
      _periodicTimer = null;
    }
  }

  void _gatherListContacts() async {
    try {
      final contacts = await _listContacts();
      if (!(const ListEquality<ExternalContact>()).equals(contacts, _cacheContacts)) {
        _cacheContacts = contacts;
        _controller.add(contacts);
      }
    } catch (e, stackTrace) {
      _logger.warning('_gatherListContacts', e, stackTrace);
    }
  }

  Future<List<ExternalContact>> _listContacts() async {
    final contacts = await _webtritApiClient.getUserContactList(_token);

    return contacts.map((contact) {
      final numbers = contact.numbers;
      return ExternalContact(
        id: numbers.main,
        firstName: contact.firstName,
        lastName: contact.lastName,
        aliasName: contact.aliasName,
        number: numbers.main,
        ext: numbers.ext,
        mobile: numbers.main,
        email: contact.email,
      );
    }).toList();
  }
}
