import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('ExternalContactsRepository');

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
  // TODO: Remove useless variable _listenedCounter
  // *The [onListen] callback is called when the first listener is subscribed, and the [onCancel] is called when there are no longer any active listeners. If a listener is added again later, after the [onCancel] was called, the [onListen] will be called again.*
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
      if (!listEquals(contacts, _cacheContacts)) {
        _cacheContacts = contacts;
        _controller.add(contacts);
      }
    } catch (e, stackTrace) {
      _logger.warning('_gatherListContacts', e, stackTrace);
      _controller.addError(e, stackTrace);
    }
  }

  Future<List<ExternalContact>> _listContacts() async {
    final contacts = await _webtritApiClient.getUserContactList(_token);

    return contacts.map((contact) {
      final numbers = contact.numbers;
      return ExternalContact(
        id: contact.userId,
        registered: contact.sipStatus == null ? null : contact.sipStatus == SipStatus.registered,
        userRegistered: contact.isRegisteredUser,
        isCurrentUser: contact.isCurrentUser,
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
