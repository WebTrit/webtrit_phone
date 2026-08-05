part of 'cdrs_list_cubit.dart';

class CdrsListState extends Equatable {
  final List<CdrRecord> records;
  final bool isLoading;
  final bool fetchingHistory;
  final bool historyEndReached;

  const CdrsListState({
    this.records = const [],
    this.isLoading = true,
    this.fetchingHistory = false,
    this.historyEndReached = false,
  });

  CdrsListState copyWith({bool? isLoading, List<CdrRecord>? records, bool? fetchingHistory, bool? historyEndReached}) {
    return CdrsListState(
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
    return 'CdrsListState(records: $records, isLoading: $isLoading, fetchingHistory: $fetchingHistory, historyEndReached: $historyEndReached)';
  }
}
