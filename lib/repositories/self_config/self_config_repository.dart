import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/mappers/api/self_config_mapper.dart';
import 'package:webtrit_phone/models/self_config.dart';

class SelfConfigRepository with SelfConfigApiMapper {
  SelfConfigRepository(this._webtritApiClient, this._token);

  final WebtritApiClient _webtritApiClient;
  final String _token;

  SelfConfig? _lastSelfConfig;

  Future<SelfConfig> _getSelfConfigRemote() async {
    final response = await _webtritApiClient.getSelfConfig(_token);
    return selfConfigFromApi(response);
  }

  Future<SelfConfig> getSelfConfig() async {
    final cached = _lastSelfConfig;
    if (cached != null && !cached.isExpired) return cached;

    return (_lastSelfConfig = await _getSelfConfigRemote());
  }
}
