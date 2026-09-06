import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/services/services.dart';

import 'cdrs_list_cubit.dart';

class MissedRecentCdrsCubit extends CdrsListCubit {
  MissedRecentCdrsCubit(
    super.localRepository,
    super.remoteRepository,
    super.syncStateSource,
    this.syncRunner, {
    super.pageSize,
  });

  final PollingTaskRunner syncRunner;

  /// Runs the app-owned CDR sync now or joins its in-flight cycle.
  Future<void> refresh() => syncRunner.runNow();

  @override
  Future<List<CdrRecord>> queryLocal({DateTime? from}) => localRepository.getHistory(
    status: CdrStatus.missed,
    direction: CallDirection.incoming,
    from: from,
    limit: pageSize,
  );

  @override
  bool matches(CdrRecord cdr) => cdr.status == CdrStatus.missed && cdr.direction == CallDirection.incoming;
}
