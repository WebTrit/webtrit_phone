part of 'log_records_console_cubit.dart';

sealed class LogRecordsConsoleState extends Equatable {
  const LogRecordsConsoleState();
}

final class LogRecordsConsoleStateInitial extends LogRecordsConsoleState {
  const LogRecordsConsoleStateInitial();

  @override
  List<Object?> get props => [];
}

final class LogRecordsConsoleStateLoading extends LogRecordsConsoleState {
  const LogRecordsConsoleStateLoading();

  @override
  List<Object?> get props => [];
}

final class LogRecordsConsoleStateSuccess extends LogRecordsConsoleState {
  const LogRecordsConsoleStateSuccess(this.logRecords);

  final List<String> logRecords;

  @override
  List<Object?> get props => [EquatablePropToString.list(logRecords)];
}

final class LogRecordsConsoleStateFailure extends LogRecordsConsoleState {
  const LogRecordsConsoleStateFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}
