import 'dart:async';

import 'package:webtrit_phone/models/lines_state.dart';

abstract class LinesStateRepository {
  const LinesStateRepository();

  LinesState getState();

  Stream<LinesState> stateUpdates();

  Stream<LinesState> getStateAndListen();

  void setState(LinesState state);
}

class LinesStateRepositoryInMemoryImpl extends LinesStateRepository {
  LinesStateRepositoryInMemoryImpl() : _lastState = LinesState.blank() {
    _updatesController = StreamController<LinesState>.broadcast();
  }

  LinesState _lastState;
  late final StreamController<LinesState> _updatesController;

  @override
  LinesState getState() => _lastState;

  @override
  Stream<LinesState> stateUpdates() => _updatesController.stream;

  @override
  Stream<LinesState> getStateAndListen() async* {
    yield _lastState;
    yield* _updatesController.stream;
  }

  @override
  void setState(LinesState state) {
    _lastState = state;
    _updatesController.add(state);
  }
}
