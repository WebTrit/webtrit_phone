import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/self_config.dart';

@Deprecated('Moved to custom_pages feature')
mixin SelfConfigApiMapper {
  SelfConfig selfConfigFromApi(api.SelfConfigResponse data) {
    return SelfConfig.supported(url: data.url, expiresAt: data.expiresAt);
  }
}
