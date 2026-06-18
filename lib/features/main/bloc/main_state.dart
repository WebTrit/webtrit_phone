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

/// The running app is older than the backend-declared minimum supported app
/// version (`min_supported_app_version` from system-info). A non-dismissible
/// update prompt must be shown.
final class AppVersionUnsupported extends CoreVersionState with EquatableMixin {
  final Version currentVersion;
  final Version minSupportedVersion;
  final Uri? updateStoreUrl;

  AppVersionUnsupported(this.currentVersion, this.minSupportedVersion, {this.updateStoreUrl});

  @override
  List<Object?> get props => [currentVersion, minSupportedVersion, updateStoreUrl];

  @override
  bool get stringify => true;
}
