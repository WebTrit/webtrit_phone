import 'package:equatable/equatable.dart';

sealed class LineState extends Equatable {
  const LineState();

  @override
  List<Object?> get props => [];

  factory LineState.idle() => const IdleLineState();
  factory LineState.inUse({required String callId}) => InUseLineState(callId: callId);
}

final class IdleLineState extends LineState {
  const IdleLineState();

  @override
  String toString() => 'IdleLineState';
}

final class InUseLineState extends LineState {
  const InUseLineState({required this.callId});
  final String callId;

  @override
  List<Object?> get props => [callId];

  @override
  String toString() => 'InUseLineState{callId: $callId}';
}

class LinesState extends Equatable {
  const LinesState({required this.mainLines, required this.guestLine});

  final List<LineState> mainLines;
  final LineState? guestLine;

  factory LinesState.blank() => const LinesState(mainLines: [], guestLine: null);

  /// True when this state has no main lines and no guest line.
  ///
  /// This occurs in two situations:
  /// - Pre-handshake: [CallBloc.onChange] sets [LinesState.blank] while
  ///   [CallState.linesCount] is 0 and [CallState.isHandshakeEstablished] is false.
  /// - Post-handshake with no lines: a valid server state where both main lines
  ///   and guest line are absent (treated the same as blank by [CallRoutingCubit]).
  bool get isBlank => mainLines.isEmpty && guestLine == null;

  @override
  List<Object?> get props => [mainLines, guestLine];

  @override
  String toString() {
    return 'LinesState{mainLines: $mainLines, guestLine: $guestLine}';
  }
}
