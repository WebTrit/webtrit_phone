import 'dart:async';

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('$ExternalContactsRepository');

class ExternalContactsRepository {
  final WebtritApiClient webtritApiClient;
  final String token;
  final bool periodicPolling;

  late StreamController<List<ExternalContact>> _controller;
  late int _listenedCounter;
  Timer? _periodicTimer;

  List<ExternalContact>? _cacheContacts;

  ExternalContactsRepository({
    required this.webtritApiClient,
    required this.token,
    this.periodicPolling = true,
  }) {
    _controller = StreamController<List<ExternalContact>>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
    _listenedCounter = 0;
  }

  Stream<List<ExternalContact>> contacts() {
    return _controller.stream;
  }

  Future<void> load() async {
    final contacts = await _listContacts();
    _cacheContacts = contacts;
    _controller.add(contacts);
  }

  void _onListenCallback() {
    if (periodicPolling && _listenedCounter++ == 0) {
      _periodicTimer = Timer.periodic(const Duration(seconds: 60), (timer) => _gatherListContacts());
    }
  }

  void _onCancelCallback() {
    if (periodicPolling && --_listenedCounter == 0) {
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
    final contacts = await webtritApiClient.accountContacts(token);

    return contacts
        .map((contact) => ExternalContact(
              id: contact.number,
              displayName: contact.extensionName,
              firstName: contact.firstName,
              lastName: contact.lastName,
              number: contact.number,
              ext: contact.extensionId,
              mobile: contact.mobile,
            ))
        .toList();
  }
}
