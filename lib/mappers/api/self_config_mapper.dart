import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/self_config.dart';

mixin SelfConfigApiMapper {
  SelfConfig selfConfigFromApi(api.SelfConfigResponse data) {
    return SelfConfig.supported(url: data.url, expiresAt: data.expiresAt);
  }
}
