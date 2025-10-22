part of 'orientations_bloc.dart';

sealed class OrientationsEvent {
  const OrientationsEvent();
}

class OrientationsChanged extends OrientationsEvent {
  const OrientationsChanged(this.orientation);

  final PreferredOrientation orientation;
}
