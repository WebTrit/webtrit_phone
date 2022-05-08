part of 'network_settings_tab_bloc.dart';

class NetworkSettingsTabState extends Equatable {
  const NetworkSettingsTabState({this.info});

  final AccountInfo? info;

  @override
  List<Object?> get props => [
        info,
      ];
}
