import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/recent.dart';

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

class RecentsUpdated extends RecentsEvent {
  final List<Recent> recents;

  const RecentsUpdated({
    @required this.recents,
  });

  @override
  List<Object> get props =>
      [
        recents,
      ];
}

class RecentsAdd extends RecentsEvent {
  final Recent recent;

  const RecentsAdd({
    @required this.recent,
  });

  @override
  List<Object> get props =>
      [
        recent,
      ];
}

class RecentsDelete extends RecentsEvent {
  final Recent recent;

  const RecentsDelete({
    @required this.recent,
  });

  @override
  List<Object> get props =>
      [
        recent,
      ];
}
