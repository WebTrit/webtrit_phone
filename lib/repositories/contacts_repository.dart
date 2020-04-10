import 'dart:async';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_phone/models/models.dart';

import 'call_repository.dart';

class ContactsRepository {
  final CallRepository callRepository;

  StreamController _controller;
  int _listenedCounter;
  Timer _periodicTimer;

  List<Contact> _contacts;

  ContactsRepository({
    @required this.callRepository,
  }) {
    _controller = StreamController<List<Contact>>.broadcast(
      onListen: _onListenCallback,
      onCancel: _onCancelCallback,
    );
    _listenedCounter = 0;
  }

  Stream<List<Contact>> contacts() {
    return _controller.stream;
  }

  Future<void> load() async {
    _contacts = await _listContacts();
    _controller.add(_contacts);
  }

  void _onListenCallback() {
    if (_listenedCounter++ == 0) {
      _periodicTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
        final newContacts = await _listContacts();
        if (!(const ListEquality<Contact>()).equals(newContacts, _contacts)) {
          _contacts = newContacts;
          _controller.add(_contacts);
        }
      });
    }
  }

  void _onCancelCallback() {
    if (--_listenedCounter == 0) {
      _periodicTimer.cancel();
      _periodicTimer = null;
    }
  }

  Future<List<Contact>> _listContacts() async {
    final list = await callRepository.list();
    return List<Contact>.from(list.map<Contact>((username) => Contact(username)));
  }
}
