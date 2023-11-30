part of 'orientations_bloc.dart';

abstract class OrientationsEvent {
  const OrientationsEvent();
}

@Freezed(copyWith: false)
class OrientationsChanged with _$OrientationsChanged implements OrientationsEvent {
  const factory OrientationsChanged(PreferredOrientation orientation) = _OrientationsChanged;
}
