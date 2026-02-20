import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

class LoggingConfig extends Equatable {
  const LoggingConfig({required this.logLevel, required this.monitorCheckInterval});

  final Level logLevel;
  final Duration monitorCheckInterval;

  @override
  List<Object?> get props => [logLevel, monitorCheckInterval];
}
