part of 'main_bloc.dart';

class MainBlocState extends Equatable {
  final CoreVersionState coreVersionState;
  const MainBlocState({required this.coreVersionState});

  @override
  List<Object?> get props => [coreVersionState];
  @override
  bool get stringify => true;

  factory MainBlocState.initial() => MainBlocState(coreVersionState: Unknown());

  MainBlocState copyWith({CoreVersionState? coreVersionState}) {
    return MainBlocState(coreVersionState: coreVersionState ?? this.coreVersionState);
  }
}

sealed class CoreVersionState {}

final class Unknown extends CoreVersionState {}

final class Compatible extends CoreVersionState {}

final class Incompatible extends CoreVersionState with EquatableMixin {
  final Version currentVersion;
  final VersionConstraint supportedConstraint;
  final Uri? updateStoreUrl;

  Incompatible(this.currentVersion, this.supportedConstraint, {this.updateStoreUrl});

  @override
  List<Object?> get props => [currentVersion, supportedConstraint, updateStoreUrl];

  @override
  bool get stringify => true;
}
