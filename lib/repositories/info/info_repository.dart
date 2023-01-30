import 'dart:async';

import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_api/webtrit_api.dart';

class InfoRepository {
  InfoRepository({
    required WebtritApiClient webtritApiClient,
  }) : _webtritApiClient = webtritApiClient;

  final WebtritApiClient _webtritApiClient;

  Future<Version> getCoreVersion() async {
    final info = await _webtritApiClient.info();
    return info.core.version;
  }
}
