part of 'keypad_cubit.dart';

class KeypadState extends Equatable {
  const KeypadState({
    this.transfer = false,
    this.video = false,
  });

  final bool transfer;
  final bool video;

  @override
  List<Object?> get props => [
        transfer,
        video,
      ];
}
