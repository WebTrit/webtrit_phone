part of 'settings_bloc.dart';

class SettingsState with EquatableMixin {
  final bool progress;
  SettingsState({
    required this.progress,
  });

  @override
  List<Object> get props => [progress];

  @override
  bool get stringify => true;

  SettingsState copyWith({bool? progress}) {
    return SettingsState(progress: progress ?? this.progress);
  }
}
