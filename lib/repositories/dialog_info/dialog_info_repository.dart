import 'dart:async';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class DialogInfoRepository {
  /// Used to set initial dialog info when signaling connection is established and we get the initial dialogs snapshot.
  /// This replaces all existing dialog info.
  Future<void> setInitialDialogInfo(List<DialogInfo> dialogInfo);

  /// Replaces dialogs list per number
  Future<void> setNumberDialogs(String number, List<DialogInfo> dialogInfo);

  /// Retrieves dialogs list for a specific number
  Future<List<DialogInfo>> getNumberDialogs(String number);

  /// Watches dialogs list for a specific number
  Stream<List<DialogInfo>> watchNumberDialogs(String number);
}

class DialogInfoRepositoryDriftImpl with DialogInfoDriftMapper implements DialogInfoRepository {
  DialogInfoRepositoryDriftImpl(this._appDatabase);
  final AppDatabase _appDatabase;
  late final _dao = _appDatabase.dialogInfoDao;

  @override
  Future<void> setInitialDialogInfo(List<DialogInfo> dialogInfo) async {
    await _dao.replaceData(dialogInfo.map((info) => dialogInfoToDrift(info)).toList());
  }

  @override
  Future<void> setNumberDialogs(String number, List<DialogInfo> dialogs) async {
    final existing = await _dao.getDialogInfoByNumber(number);
    final toRemove = existing.map((e) => e.idKey).toSet().difference(dialogs.map((e) => e.id).toSet());

    final data = dialogs.map((e) => dialogInfoToDrift(e)).toList();
    await _dao.deleteDialogInfoByIdsAndNumber(toRemove.toList(), number);
    await _dao.upsertDialogInfo(data);
  }

  @override
  Future<List<DialogInfo>> getNumberDialogs(String number) async {
    final data = await _dao.getDialogInfoByNumber(number);
    final dialogs = data.map(dialogInfoFromDrift).toList();
    return dialogs;
  }

  @override
  Stream<List<DialogInfo>> watchNumberDialogs(String number) {
    return _dao.watchDialogInfoByNumber(number).map((dialogsData) => dialogsData.map(dialogInfoFromDrift).toList());
  }
}
