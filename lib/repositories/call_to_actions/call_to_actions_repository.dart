import 'dart:ui';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';

abstract class CallToActionsRepository {
  Future<List<CallToAction>> getActions(MainFlavor flavor, Locale locale);
}

class CallToActionsRepositoryImpl implements CallToActionsRepository {
  CallToActionsRepositoryImpl({
    required WebtritApiClient webtritApiClient,
    required String token,
  })  : _webtritApiClient = webtritApiClient,
        _token = token;

  final WebtritApiClient _webtritApiClient;
  final String _token;

  // Cache the user information to avoid redundant API calls when data sources are unavailable
  UserInfo? _cachedUserInfo;

  @override
  Future<List<CallToAction>> getActions(MainFlavor flavor, Locale locale) async {
    try {
      final userInfo = await _getUserInfo();

      final param = DemoCallToActionsParam(
        email: userInfo.email!,
        tab: flavor.name,
      );

      final callToActions = await _webtritApiClient.getCallToActions(
        _token,
        locale.toString(),
        param,
        options: RequestOptions.withNoRetries(),
      );

      return callToActions.actions
          .map((it) => CallToAction(title: it.title, description: it.description, url: it.url))
          .toList();
    } catch (e) {
      // Per the agreed behavior, any failure (e.g., unimplemented method, invalid session)
      // should result in returning an empty list without interrupting the flow.
      return [];
    }
  }

  Future<UserInfo> _getUserInfo() async {
    final requestOption = RequestOptions.withNoRetries();
    final account = _cachedUserInfo ?? await _webtritApiClient.getUserInfo(_token, options: requestOption);
    return account;
  }
}
