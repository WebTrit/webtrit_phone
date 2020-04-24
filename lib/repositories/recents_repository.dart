import 'dart:async';

import 'package:meta/meta.dart';

import 'package:webtrit_phone/models/models.dart';

// TODO: add local persist and/or external sync of recents calls
class RecentsRepository {
  final List<Recent> _recents = [];
  final StreamController _controller = StreamController<List<Recent>>.broadcast();

  Stream<List<Recent>> recents() {
    return _controller.stream;
  }

  Future<void> load() async {
    _controller.add(List<Recent>.from(_recents));
  }

  Future<void> add(Recent recent) {
    _recents.insert(0, recent);

    _controller.add(List<Recent>.from(_recents));
  }

  Future<void> delete(Recent recent) {
    _recents.remove(recent);

    _controller.add(List<Recent>.from(_recents));
  }
}
