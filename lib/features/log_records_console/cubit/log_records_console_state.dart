part of 'log_records_console_cubit.dart';

@freezed
class LogRecordsConsoleState with _$LogRecordsConsoleState {
  const factory LogRecordsConsoleState.initial() = LogRecordsConsoleStateInitial;

  const factory LogRecordsConsoleState.loading() = LogRecordsConsoleStateLoading;

  const factory LogRecordsConsoleState.success(List<LogRecord> logRecords) = LogRecordsConsoleStateSuccess;

  const factory LogRecordsConsoleState.failure(Object error) = LogRecordsConsoleStateFailure;
}
