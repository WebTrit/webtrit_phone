import 'dart:async';

import 'package:collection/collection.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/secure_storage.dart';

import 'models/models.dart';
export 'models/models.dart';

class ExternalContactsRepository {
  final WebtritApiClient webtritApiClient;
  final bool periodicPolling;

  late StreamController<List<ExternalContact>> _controller;
  late int _listenedCounter;
  Timer? _periodicTimer;

  List<ExternalContact> _contacts = [];

  ExternalContactsRepository({
    required this.webtritApiClient,
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
    _contacts = await _listContacts();
    _controller.add(_contacts);
  }

  void _onListenCallback() {
    if (periodicPolling && _listenedCounter++ == 0) {
      _periodicTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        final newContacts = await _listContacts();
        if (!(const ListEquality<ExternalContact>()).equals(newContacts, _contacts)) {
          _contacts = newContacts;
          _controller.add(_contacts);
        }
      });
    }
  }

  void _onCancelCallback() {
    if (periodicPolling && --_listenedCounter == 0) {
      _periodicTimer?.cancel();
      _periodicTimer = null;
    }
  }

  Future<List<ExternalContact>> _listContacts() async {
    final token = await SecureStorage().readToken();
    final contacts = await webtritApiClient.accountContacts(token!);

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
