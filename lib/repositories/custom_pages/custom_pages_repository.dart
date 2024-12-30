import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/mappers/api/custom_page_mapper.dart';
import 'package:webtrit_phone/models/custom_page.dart';

class CustomPagesRepository with CustomPageApiMapper {
  CustomPagesRepository(this._webtritApiClient, this._token);

  final WebtritApiClient _webtritApiClient;
  final String _token;

  final Map<String, List<CustomPage>> _customPagesCache = {};

  Future<List<CustomPage>> _fetchCustomPages(String locale) async {
    final response = await _webtritApiClient.getCustomPages(_token, locale);
    return response.pages.map(customPageFromApi).toList();
  }

  Future<List<CustomPage>> getCustomPages(String locale) async {
    if (_customPagesCache.containsKey(locale)) {
      final pages = _customPagesCache[locale]!;
      final anyExpired = pages.any((page) => page.expiresAt?.isBefore(DateTime.now()) ?? false);
      if (!anyExpired) return _customPagesCache[locale]!;
    }

    return _customPagesCache[locale] = await _fetchCustomPages(locale);
  }
}
