import 'dart:async';

import 'package:equatable/equatable.dart';

enum LineState { idle, inUse }

class LinesState extends Equatable {
  const LinesState({required this.mainLines, required this.guestLine});

  final List<LineState> mainLines;
  final LineState? guestLine;

  factory LinesState.blank() => const LinesState(mainLines: [], guestLine: null);

  @override
  List<Object?> get props => [mainLines, guestLine];

  @override
  String toString() {
    return 'LinesState{mainLines: $mainLines, guestLine: $guestLine}';
  }
}

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
