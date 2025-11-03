part of 'orientations_bloc.dart';

@freezed
class OrientationsState with _$OrientationsState {
  const OrientationsState({
    this.lastOrientation,
  });

  @override
  final PreferredOrientation? lastOrientation;
}
