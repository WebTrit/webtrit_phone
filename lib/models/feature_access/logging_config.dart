import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

class LoggingConfig extends Equatable {
  const LoggingConfig({required this.logLevel, required this.monitorCheckInterval, required this.remoteLoggingEnabled});

  final Level logLevel;
  final Duration monitorCheckInterval;
  final bool remoteLoggingEnabled;

  @override
  List<Object?> get props => [logLevel, monitorCheckInterval, remoteLoggingEnabled];
}
