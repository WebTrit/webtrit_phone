import 'dart:async';

import 'package:webtrit_phone/models/models.dart';

abstract class CallPullRepository {
  CallPullRepository();

  List<PullableCall> get pullableCalls;

  Stream<List<PullableCall>> get pullableCallsStream;

  Stream<List<PullableCall>> get pullableCallsStreamWithValue;

  void setPullableCalls(List<PullableCall> pullableCalls);
}

class CallPullRepositoryMemoryImpl implements CallPullRepository {
  CallPullRepositoryMemoryImpl();

  final _pullableCalls = <PullableCall>[];
  final _pullableCallsController = StreamController<List<PullableCall>>.broadcast();

  @override
  List<PullableCall> get pullableCalls => _pullableCalls;

  @override
  Stream<List<PullableCall>> get pullableCallsStream => _pullableCallsController.stream;

  @override
  Stream<List<PullableCall>> get pullableCallsStreamWithValue async* {
    yield _pullableCalls;
    yield* pullableCallsStream;
  }

  @override
  void setPullableCalls(List<PullableCall> pullableCalls) {
    _pullableCalls.clear();
    _pullableCalls.addAll(pullableCalls);
    _pullableCallsController.add(_pullableCalls);
  }
}
