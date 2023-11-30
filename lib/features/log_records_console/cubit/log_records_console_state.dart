part of 'log_records_console_cubit.dart';

enum LogRecordsConsoleStatus { initial, loading, success, failure }

extension LogRecordsConsoleStatusX on LogRecordsConsoleStatus {
  bool get isInitial => this == LogRecordsConsoleStatus.initial;

  bool get isLoading => this == LogRecordsConsoleStatus.loading;

  bool get isSuccess => this == LogRecordsConsoleStatus.success;

  bool get isFailure => this == LogRecordsConsoleStatus.failure;
}

class LogRecordsConsoleState extends Equatable {
  const LogRecordsConsoleState._({
    this.status = LogRecordsConsoleStatus.initial,
    this.logRecords = const [],
    this.error,
  });

  const LogRecordsConsoleState.initial() : this._();

  const LogRecordsConsoleState.loading()
      : this._(
          status: LogRecordsConsoleStatus.loading,
        );

  const LogRecordsConsoleState.success(List<LogRecord> logRecords)
      : this._(
          status: LogRecordsConsoleStatus.success,
          logRecords: logRecords,
        );

  const LogRecordsConsoleState.failure(Object error)
      : this._(
          status: LogRecordsConsoleStatus.failure,
          error: error,
        );

  final LogRecordsConsoleStatus status;
  final List<LogRecord> logRecords;
  final Object? error;

  @override
  List<Object?> get props => [
        status,
        logRecords,
        error,
      ];

  @override
  String toString() => '$runtimeType($status, ${logRecords.length}, $error)';
}
