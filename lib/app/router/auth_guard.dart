import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/login/login.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._secureStorage);

  final SecureStorage _secureStorage;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final token = _secureStorage.readToken();
    final coreUrl = _secureStorage.readCoreUrl();
    final tenantId = _secureStorage.readTenantId();

    final isAuthorized = token != null && coreUrl != null && tenantId != null;

    if (isAuthorized) {
      resolver.next(true);
    } else {
      router.replaceAll([LoginScreenPageRoute(stepPathParam: LoginStep.modeSelect.name)], updateExistingRoutes: false);
    }
  }
}
