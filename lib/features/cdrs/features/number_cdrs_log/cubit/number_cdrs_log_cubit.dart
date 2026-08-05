import 'package:webtrit_phone/features/cdrs/cubit/cdrs_list_cubit.dart';
import 'package:webtrit_phone/models/models.dart';

class NumberCdrsLogCubit extends CdrsListCubit {
  NumberCdrsLogCubit(this.number, super.localRepository, super.remoteRepository, {super.pageSize});

  final String number;

  @override
  Future<List<CdrRecord>> queryLocal({DateTime? from}) =>
      localRepository.getHistory(number: number, from: from, limit: pageSize);

  @override
  bool matches(CdrRecord cdr) => cdr.callerNumber == number || cdr.calleeNumber == number;
}
