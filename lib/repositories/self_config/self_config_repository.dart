import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/mappers/api/self_config_mapper.dart';
import 'package:webtrit_phone/models/self_config.dart';

@Deprecated('Moved to custom_pages feature')
class SelfConfigRepository with SelfConfigApiMapper {
  SelfConfigRepository(this._webtritApiClient, this._token);

  final WebtritApiClient _webtritApiClient;
  final String _token;

  SelfConfig? _lastSelfConfig;

  Future<SelfConfig> _getSelfConfigRemote() async {
    try {
      final response = await _webtritApiClient.getSelfConfig(_token);
      return selfConfigFromApi(response);
    } on RequestFailure catch (e) {
      if (e.statusCode == 404 || e.statusCode == 501) {
        return SelfConfig.unsupported();
      }
      rethrow;
    }
  }

  Future<SelfConfig> getSelfConfig() async {
    final cached = _lastSelfConfig;

    if (cached is SelfConfigUnsupported) return cached;
    if (cached is SelfConfigSupported && !cached.isExpired) return cached;

    return (_lastSelfConfig = await _getSelfConfigRemote());
  }
}
