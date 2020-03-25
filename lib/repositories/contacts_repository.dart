import 'dart:async';
import 'dart:math';

import 'package:meta/meta.dart';

import 'package:webtrit_phone/models/models.dart';

// TODO: temporary code
class ContactsRepository {
  final List<Contact> _contacts = [];
  final StreamController _controller = StreamController<List<Contact>>.broadcast();

  int _loadCallCounter = 0;
  Timer _timer;

  Stream<List<Contact>> contacts() {
    return _controller.stream;
  }

  Future<void> load() async {
    if (_contacts.isEmpty) {
      _contacts.addAll(List.generate(
        10,
        (index) => Contact(
          'Contact #$index',
        ),
      ));

      await Future.delayed(Duration(seconds: 1));

      _controller.add(List<Contact>.from(_contacts));
    } else {
      _timer?.cancel();
      final addContact = () {
        _contacts.insert(0, Contact(DateTime.now().toString()));
        _controller.add(List<Contact>.from(_contacts));
      };
      if (_loadCallCounter++ % 2 == 0) {
        _timer = Timer(Duration(seconds: 5), addContact);
        throw Exception();
      }  else {
        addContact();
      }
    }
  }
}
