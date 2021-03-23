import 'dart:async';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/models/models.dart';

import 'call_repository.dart';

class ExternalContactsRepository {
  final CallRepository callRepository;
  final bool periodicPolling;

  StreamController _controller;
  int _listenedCounter;
  Timer _periodicTimer;

  List<ExternalContact> _contacts;

  ExternalContactsRepository({
    @required this.callRepository,
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
      _periodicTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
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
      _periodicTimer.cancel();
      _periodicTimer = null;
    }
  }

  Future<List<ExternalContact>> _listContacts() async {
    final list = await callRepository.list();
    return List<ExternalContact>.from(list.map<ExternalContact>((username) => ExternalContact(username)));
  }
}
