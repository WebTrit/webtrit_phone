import 'dart:ui';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/app/session/session.dart';

abstract class CallToActionsRepository {
  Future<List<CallToAction>> getActions(MainFlavor flavor, Locale locale, String email);
}

class CallToActionsRepositoryImpl implements CallToActionsRepository {
  CallToActionsRepositoryImpl({
    required WebtritApiClient webtritApiClient,
    required String token,
    SessionGuard? sessionGuard,
  }) : _sessionGuard = sessionGuard ?? const EmptySessionGuard(),
       _webtritApiClient = webtritApiClient,
       _token = token;

  final WebtritApiClient _webtritApiClient;
  final String _token;
  final SessionGuard _sessionGuard;

  @override
  Future<List<CallToAction>> getActions(MainFlavor flavor, Locale locale, String email) async {
    try {
      final param = DemoCallToActionsParam(email: email, tab: flavor.name);

      final callToActions = await _webtritApiClient.getCallToActions(
        _token,
        locale.toString(),
        param,
        options: RequestOptions.withNoRetries(),
      );

      return callToActions.actions
          .map((it) => CallToAction(title: it.title, description: it.description, url: it.url))
          .toList();
    } on UnauthorizedException catch (e) {
      _sessionGuard.onUnauthorized(e);
      rethrow;
    } catch (e) {
      // Per the agreed behavior, any failure (e.g., unimplemented method, invalid session)
      // should result in returning an empty list without interrupting the flow.
      return [];
    }
  }
}
