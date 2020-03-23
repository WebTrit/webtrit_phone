import 'package:meta/meta.dart';

import 'package:webtrit_phone/models/models.dart';

class RecentsRepository {
  int _callCounter = 0;

  Future<List<Recent>> getRecents() {
    // TODO: temporary code
    if (_callCounter++ % 2 == 0) throw Exception();
    final recents = List.generate(
      50,
      (index) => Recent(
        index % 2 == 0 ? Direction.incoming : Direction.outgoing,
        'Recent call #$index',
        DateTime.now().subtract(Duration(hours: index)),
      ),
    );
    return Future.delayed(Duration(seconds: 3), () => recents);
  }
}
