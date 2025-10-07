part of 'number_cdrs_log_cubit.dart';

class NumberCdrsLogState extends Equatable {
  final List<CdrRecord> records;
  final bool isLoading;
  final bool fetchingHistory;
  final bool historyEndReached;

  const NumberCdrsLogState({
    this.records = const [],
    this.isLoading = true,
    this.fetchingHistory = false,
    this.historyEndReached = false,
  });

  NumberCdrsLogState copyWith({
    bool? isLoading,
    List<CdrRecord>? records,
    bool? fetchingHistory,
    bool? historyEndReached,
  }) {
    return NumberCdrsLogState(
      isLoading: isLoading ?? this.isLoading,
      records: records ?? this.records,
      fetchingHistory: fetchingHistory ?? this.fetchingHistory,
      historyEndReached: historyEndReached ?? this.historyEndReached,
    );
  }

  @override
  List<Object?> get props => [records, isLoading, fetchingHistory, historyEndReached];

  @override
  String toString() {
    return 'NumberCdrsLogState(records: $records, isLoading: $isLoading, fetchingHistory: $fetchingHistory, historyEndReached: $historyEndReached)';
  }
}
