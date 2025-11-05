part of 'orientations_bloc.dart';

sealed class OrientationsEvent extends Equatable {
  const OrientationsEvent();

  @override
  List<Object?> get props => [];
}

class OrientationsChanged extends OrientationsEvent {
  const OrientationsChanged(this.orientation);

  final PreferredOrientation orientation;

  @override
  List<Object?> get props => [orientation];
}
