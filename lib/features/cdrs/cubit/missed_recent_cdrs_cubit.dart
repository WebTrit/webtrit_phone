import 'package:webtrit_phone/models/models.dart';

import 'cdrs_list_cubit.dart';

class MissedRecentCdrsCubit extends CdrsListCubit {
  MissedRecentCdrsCubit(super.localRepository, super.remoteRepository, {super.pageSize});

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
