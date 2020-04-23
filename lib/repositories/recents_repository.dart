import 'dart:async';

import 'package:meta/meta.dart';

import 'package:webtrit_phone/models/models.dart';

// TODO: temporary code
class RecentsRepository {
  final List<Recent> _recents = [];
  final StreamController _controller = StreamController<List<Recent>>.broadcast();

  int _fetchCallCounter = 0;

  Stream<List<Recent>> recents() {
    return _controller.stream;
  }

  Future<void> load() async {
    if (_recents.isEmpty) {
      _recents.addAll(List.generate(
        50,
        (index) => Recent(
          index % 2 == 0 ? Direction.incoming : Direction.outgoing,
          index % 3 == 0,
          'Recent call #$index',
          DateTime.now().subtract(Duration(hours: index)),
        ),
      ));
    }

    await Future.delayed(Duration(seconds: 1));
    if (_fetchCallCounter++ % 3 == 0) throw Exception();

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
