part of 'keypad_cubit.dart';

class KeypadState extends Equatable {
  KeypadState({
    this.video = false,
  });

  final bool video;

  @override
  List<Object?> get props => [
        video,
      ];
}
