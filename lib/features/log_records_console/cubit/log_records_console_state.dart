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
  const LogRecordsConsoleStateSuccess(this.logRecords, {this.isSharing = false});

  final List<String> logRecords;
  final bool isSharing;

  LogRecordsConsoleStateSuccess copyWith({bool? isSharing}) {
    return LogRecordsConsoleStateSuccess(logRecords, isSharing: isSharing ?? this.isSharing);
  }

  @override
  List<Object?> get props => [EquatablePropToString.list(logRecords), isSharing];
}

final class LogRecordsConsoleStateFailure extends LogRecordsConsoleState {
  const LogRecordsConsoleStateFailure(this.error);

  final Object error;

  @override
  List<Object?> get props => [error];
}
