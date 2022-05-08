part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({this.info});

  final AccountInfo? info;

  @override
  List<Object?> get props => [
    info,
  ];
}