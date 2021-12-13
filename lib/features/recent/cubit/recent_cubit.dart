import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'recent_state.dart';

class RecentCubit extends Cubit<RecentState> {
  RecentCubit(
    Recent recent, {
    required this.recentsRepository,
  }) : super(RecentInitial(recent: recent));

  final RecentsRepository recentsRepository;

  Future<void> getRecentHistory() async {
    final recents = await recentsRepository.history(state.recent);
    emit(RecentSuccess(recent: state.recent, recents: recents));
  }

  Future<void> delete(Recent recent) async {
    await recentsRepository.delete(recent);

    await getRecentHistory();
  }
}
