import 'package:webtrit_api/webtrit_api.dart' show WebtritApiClient, UnauthorizedException;

import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class CdrsRemoteRepository {
  /// Fetches the history of Call Detail Records (CDRs).
  ///
  /// [from] - Optional parameter to filter records `from` this date.
  /// [to] - Optional parameter to filter records `to` this date.
  /// [limit] - Optional parameter to limit the number of records returned.
  Future<List<CdrRecord>> getHistory({DateTime? from, DateTime? to, int? limit});
}

class CdrsRemoteRepositoryApiImpl with CdrApiMapper implements CdrsRemoteRepository {
  CdrsRemoteRepositoryApiImpl(this._webtritApiClient, this._token, this._sessionGuard);

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final SessionGuard _sessionGuard;

  @override
  Future<List<CdrRecord>> getHistory({DateTime? from, DateTime? to, int? limit}) async {
    try {
      final response = await _webtritApiClient.getCdrHistory(_token, from: from, to: to, limit: limit);
      return response.items.map(cdrFromApi).toList();
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    }
  }
}
