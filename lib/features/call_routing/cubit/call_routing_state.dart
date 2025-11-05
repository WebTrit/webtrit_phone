part of 'call_routing_cubit.dart';

class CallRoutingState extends Equatable {
  CallRoutingState._(this.mainNumber, this.additionalNumbers, this.mainLinesState, this.guestLineState);

  /// The main number of the user. From which the user makees calls regularly.
  final String mainNumber;

  /// The additional numbers of the user. From which the user can make calls.
  final List<String> additionalNumbers;

  /// The states of the main sip registration lines.
  /// From which the can make calls using main number.
  final List<LineState> mainLinesState;

  /// The state of the guest line.
  /// From which the user can make calls using additional numbers.
  /// `null` means that guest line is not supported.
  final LineState? guestLineState;

  /// Returns true if the user can make calls using any of the numbers.
  late final allNumbers = <String>[mainNumber, ...additionalNumbers];

  @override
  List<Object?> get props => [mainNumber, additionalNumbers, mainLinesState, guestLineState];

  @override
  String toString() {
    return 'CallRoutingState{mainNumber: $mainNumber, additionalNumbers: $additionalNumbers, mainLinesState: $mainLinesState, guestLineState: $guestLineState}';
  }

  bool get hasIdleMainLine => mainLinesState.any((line) => line == LineState.idle);
  bool get hasIdleGuestLine => guestLineState == LineState.idle;
}
