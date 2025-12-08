part of 'full_recent_cdrs_cubit.dart';

class FullRecentCdrsState extends Equatable {
  final List<CdrRecord> records;
  final bool isLoading;
  final bool fetchingHistory;
  final bool historyEndReached;

  const FullRecentCdrsState({
    this.records = const [],
    this.isLoading = true,
    this.fetchingHistory = false,
    this.historyEndReached = false,
  });

  FullRecentCdrsState copyWith({
    bool? isLoading,
    List<CdrRecord>? records,
    bool? fetchingHistory,
    bool? historyEndReached,
  }) {
    return FullRecentCdrsState(
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
    return 'FullRecentCdrsState(records: $records, isLoading: $isLoading, fetchingHistory: $fetchingHistory, historyEndReached: $historyEndReached)';
  }
}
