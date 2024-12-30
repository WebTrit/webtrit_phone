import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/custom_page.dart';

mixin CustomPageApiMapper {
  CustomPage customPageFromApi(api.CustomPageResponse data) {
    return CustomPage(
      title: data.title,
      url: data.url,
      extraData: data.extraData,
      description: data.description,
      expiresAt: data.expiresAt,
    );
  }
}
