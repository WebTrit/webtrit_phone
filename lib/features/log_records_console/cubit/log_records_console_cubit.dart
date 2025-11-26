import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../utils/utils.dart';

part 'log_records_console_state.dart';

class LogRecordsConsoleCubit extends Cubit<LogRecordsConsoleState> {
  LogRecordsConsoleCubit({
    required this.logRecordsRepository,
    this.logRecordsFormatter = const DefaultLogRecordFormatter(),
    required this.packageInfo,
    required this.appInfo,
  }) : super(const LogRecordsConsoleStateInitial());

  final LogRecordsRepository logRecordsRepository;
  final LogRecordFormatter logRecordsFormatter;
  final PackageInfo packageInfo;
  final AppInfo appInfo;

  void load() async {
    emit(const LogRecordsConsoleStateLoading());
    try {
      final logRecords = await logRecordsRepository.getLogRecords();
      emit(LogRecordsConsoleStateSuccess(logRecords));
    } catch (error) {
      emit(LogRecordsConsoleStateFailure(error));
    }
  }

  void clear() async {
    emit(const LogRecordsConsoleStateLoading());
    logRecordsRepository.clear();
    emit(const LogRecordsConsoleStateSuccess([]));
  }

  String get _namePrefix => '${packageInfo.appName}_${appInfo.identifier}_';

  String _timeSlug(DateTime time) =>
      '${time.year.toString()}${time.month.toString().padLeft(2, '0')}${time.day.toString().padLeft(2, '0')}'
      '${time.hour.toString()}${time.minute.toString().padLeft(2, '0')}${time.second.toString().padLeft(2, '0')}';

  Future<void> share() async {
    final state = this.state as LogRecordsConsoleStateSuccess;

    final logRecords = state.logRecords;

    final time = DateTime.now();
    final name = '$_namePrefix${_timeSlug(time)}.log';

    await shareLogRecords(logRecords, logRecordsFormatter: logRecordsFormatter, name: name);
  }
}
