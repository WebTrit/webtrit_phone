import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class RecentsEvent extends Equatable {
  const RecentsEvent();

  @override
  List<Object> get props => [];
}

class RecentsFetched extends RecentsEvent {
  const RecentsFetched();
}

class RecentsRefreshed extends RecentsEvent {
  const RecentsRefreshed();
}
