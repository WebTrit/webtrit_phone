part of 'keypad_cubit.dart';

class KeypadState extends Equatable {
  const KeypadState({
    this.video = false,
  });

  final bool video;

  @override
  List<Object?> get props => [
        video,
      ];
}
