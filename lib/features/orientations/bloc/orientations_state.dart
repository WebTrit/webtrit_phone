part of 'orientations_bloc.dart';

@freezed
abstract class OrientationsState with _$OrientationsState {
  const factory OrientationsState([PreferredOrientation? lastOrientation]) = _OrientationsState;
}
