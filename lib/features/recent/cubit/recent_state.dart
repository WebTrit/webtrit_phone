part of 'recent_cubit.dart';

abstract class RecentState extends Equatable {
  const RecentState({
    required this.recent,
  });

  final Recent recent;

  @override
  List<Object> get props => [
        recent,
      ];
}

class RecentInitial extends RecentState {
  const RecentInitial({
    required Recent recent,
  }) : super(recent: recent);
}

class RecentSuccess extends RecentState {
  const RecentSuccess({
    required Recent recent,
    required this.recents,
  }) : super(recent: recent);

  final List<Recent> recents;

  @override
  List<Object> get props => [
        ...super.props,
        recents,
      ];
}
