import 'package:equatable/equatable.dart';

class MonitoringConfig extends Equatable {
  const MonitoringConfig({required this.monitorCheckInterval});

  final Duration monitorCheckInterval;

  @override
  List<Object?> get props => [monitorCheckInterval];
}
