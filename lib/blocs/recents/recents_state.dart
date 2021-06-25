import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/recent.dart';

@immutable
abstract class RecentsState extends Equatable {
  const RecentsState();

  @override
  List<Object> get props => [];
}

class RecentsInitial extends RecentsState {
  const RecentsInitial();
}

class RecentsLoadSuccess extends RecentsState {
  final List<Recent> recents;

  const RecentsLoadSuccess({
    required this.recents,
  });

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

abstract class RecentsLoadFailure extends RecentsState {
  const RecentsLoadFailure();

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);
}

class RecentsInitialLoadFailure extends RecentsLoadFailure {
  const RecentsInitialLoadFailure();
}

class RecentsRefreshFailure extends RecentsLoadFailure {
  const RecentsRefreshFailure();
}
