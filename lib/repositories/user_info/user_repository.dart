import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/models/models.dart';

import 'user_local_datasource.dart';
import 'user_remote_datasource.dart';

export 'package:webtrit_phone/models/user_info.dart';
export 'user_local_datasource.dart';
export 'user_remote_datasource.dart';

final _logger = Logger('UserRepository');

class UserRepository implements Refreshable {
  UserRepository({required this.remoteDatasource, required this.localDatasource}) {
    _updatesController = StreamController<UserInfo>.broadcast();
  }

  final UserRemoteDatasource remoteDatasource;
  final UserLocalDatasource localDatasource;
  late final StreamController<UserInfo> _updatesController;

  /// Gets last known user information and listens for updates.
  /// Its safe to use without catching exceptions, as they are handled internally and never emitted through this stream.
  ///
  /// Its recommended to use this method for most use cases:
  /// fo example [getAndListen.first] will give your dependant components (like [user_info_cubit] or [contacts_sync_bloc])
  /// valid user info only when it will be available, because they dont give a heck if it wasn't in cache or app were offline or error happend.
  Stream<UserInfo> getAndListen() async* {
    final info = getLocalInfo();
    if (info != null) yield info;
    yield* _updatesController.stream;
  }

  /// Deletes the user information from the remote source and clears the local cache.
  Future<void> deleteRemote() async {
    await remoteDatasource.delete();
  }

  /// Fetches the latest user information directly from the remote source.
  Future<UserInfo?> getRemoteInfo() async {
    return await remoteDatasource.getInfo();
  }

  /// Retrieves the locally cached user information, if available.
  UserInfo? getLocalInfo() {
    return localDatasource.getInfo();
  }

  @override
  bool get isActive => true;

  @override
  Future<void> refresh() async {
    try {
      final oldInfo = localDatasource.getInfo();
      final newInfo = await remoteDatasource.getInfo();
      if (newInfo != oldInfo) {
        _updatesController.add(newInfo);
        localDatasource.setInfo(newInfo);
      }
    } catch (e, stackTrace) {
      _logger.warning('refresh', e, stackTrace);
    }
  }
}
