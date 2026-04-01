import 'package:equatable/equatable.dart';

enum LineState { idle, inUse }

class LinesState extends Equatable {
  const LinesState({required this.mainLines, required this.guestLine});

  final List<LineState> mainLines;
  final LineState? guestLine;

  factory LinesState.blank() => const LinesState(mainLines: [], guestLine: null);

  /// True when this state was produced by [LinesState.blank] — i.e. the
  /// signaling handshake has not been received yet and line counts are unknown.
  ///
  /// After the first handshake, [CallBloc] always sets a non-null [guestLine],
  /// so [guestLine] == null is an unambiguous marker for the pre-handshake state.
  bool get isBlank => mainLines.isEmpty && guestLine == null;

  @override
  List<Object?> get props => [mainLines, guestLine];

  @override
  String toString() {
    return 'LinesState{mainLines: $mainLines, guestLine: $guestLine}';
  }
}
