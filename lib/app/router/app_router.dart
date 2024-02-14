import 'package:auto_route/auto_route.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

export 'package:auto_route/auto_route.dart' show ReevaluateListenable;

part 'app_router.gr.dart';

final _logger = Logger('AppRouter');

@AutoRouterConfig(
  replaceInRouteName: null,
)
class AppRouter extends _$AppRouter {
  AppRouter(
    this._appBloc,
    this._appPreferences,
    this._appPermissions,
  );

  final AppBloc _appBloc;
  final AppPreferences _appPreferences;
  final AppPermissions _appPermissions;

  String? get coreUrl => _appBloc.state.coreUrl;
  String? get token => _appBloc.state.token;
  bool get appPermissionsDenied => _appPermissions.isDenied;

  @override
  List<AutoRoute> get routes => [
        AutoRoute.guarded(
          page: AppShellRoute.page,
          onNavigation: onAppShellRouteGuardNavigation,
          path: '/',
          children: [
            RedirectRoute(
              path: '',
              redirectTo: 'main',
            ),
            AutoRoute.guarded(
              page: LoginRouterPageRoute.page,
              onNavigation: onLoginScreenPageRouteGuardNavigation,
              path: 'login',
              children: [
                AutoRoute(
                  page: LoginModeSelectScreenPageRoute.page,
                ),
                AutoRoute(
                  page: LoginCoreUrlAssignScreenPageRoute.page,
                ),
                AutoRoute(
                  page: LoginOtpRequestScreenPageRoute.page,
                ),
                AutoRoute(
                  page: LoginOtpVerifyScreenPageRoute.page,
                ),
              ],
            ),
            AutoRoute.guarded(
              page: PermissionsScreenPageRoute.page,
              onNavigation: onPermissionsScreenPageRouteGuardNavigation,
              path: 'permissions',
            ),
            AutoRoute.guarded(
              page: MainShellRoute.page,
              onNavigation: onMainShellRouteGuardNavigation,
              path: 'main',
              children: [
                AutoRoute(
                  page: MainScreenPageRoute.page,
                  path: '',
                  children: [
                    RedirectRoute(
                      path: '',
                      redirectTo: _appPreferences.getActiveMainFlavor().name,
                    ),
                    AutoRoute(
                      page: FavoritesRouterPageRoute.page,
                      path: MainFlavor.favorites.name,
                      children: [
                        AutoRoute(
                          page: FavoritesScreenPageRoute.page,
                          path: '',
                        ),
                        AutoRoute(
                          page: ContactScreenPageRoute.page,
                          path: 'contact',
                        ),
                      ],
                    ),
                    AutoRoute(
                      page: RecentsRouterPageRoute.page,
                      path: MainFlavor.recents.name,
                      children: [
                        AutoRoute(
                          page: RecentsScreenPageRoute.page,
                          path: '',
                        ),
                        AutoRoute(
                          page: RecentScreenPageRoute.page,
                          path: 'recent',
                        ),
                      ],
                    ),
                    AutoRoute(
                      page: ContactsRouterPageRoute.page,
                      path: MainFlavor.contacts.name,
                      children: [
                        AutoRoute(
                          page: ContactsScreenPageRoute.page,
                          path: '',
                        ),
                        AutoRoute(
                          page: ContactScreenPageRoute.page,
                          path: 'contact',
                        ),
                      ],
                    ),
                    AutoRoute(
                      page: KeypadScreenPageRoute.page,
                      path: MainFlavor.keypad.name,
                    ),
                  ],
                ),
                CustomRoute(
                  page: CallScreenPageRoute.page,
                  path: 'call',
                  fullscreenDialog: true,
                  transitionsBuilder: TransitionsBuilders.fadeIn,
                ),
                AutoRoute(
                  page: SettingsRouterPageRoute.page,
                  path: 'settings',
                  fullscreenDialog: true,
                  children: [
                    AutoRoute(
                      page: SettingsScreenPageRoute.page,
                      path: '',
                      fullscreenDialog: true, // for AutoLeadingButton show correct CloseButton
                    ),
                    AutoRoute(
                      page: AboutScreenPageRoute.page,
                      path: 'about',
                    ),
                    AutoRoute(
                      page: HelpScreenPageRoute.page,
                      path: 'help',
                    ),
                    AutoRoute(
                      page: LanguageScreenPageRoute.page,
                      path: 'language',
                    ),
                    AutoRoute(
                      page: NetworkScreenPageRoute.page,
                      path: 'network',
                    ),
                    AutoRoute(
                      page: TermsConditionsScreenPageRoute.page,
                      path: 'terms-conditions',
                    ),
                    AutoRoute(
                      page: ThemeModeScreenPageRoute.page,
                      path: 'theme-mode',
                    ),
                    AutoRoute(
                      page: LogRecordsConsoleScreenPageRoute.page,
                      path: 'log-records-console',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];

  void onLoginScreenPageRouteGuardNavigation(NavigationResolver resolver, StackRouter router) {
    _logger.fine(_onNavigationLoggerMessage('onLoginScreenPageRouteGuardNavigation', resolver));

    if (coreUrl != null && token != null) {
      resolver.next(false);
      router.replaceAll(
        [const MainShellRoute()],
      );
    } else {
      resolver.next(true);
    }
  }

  void onPermissionsScreenPageRouteGuardNavigation(NavigationResolver resolver, StackRouter router) {
    _logger.fine(_onNavigationLoggerMessage('onPermissionsScreenPageRouteGuardNavigation', resolver));

    final appPermissionsDenied = _appPermissions.isDenied;

    if (appPermissionsDenied) {
      resolver.next(true);
    } else {
      resolver.next(false);
      router.replaceAll(
        [const MainShellRoute()],
      );
    }
  }

  void onMainShellRouteGuardNavigation(NavigationResolver resolver, StackRouter router) {
    _logger.fine(_onNavigationLoggerMessage('onMainShellRouteGuardNavigation', resolver));

    if (coreUrl != null && token != null) {
      if (appPermissionsDenied) {
        resolver.next(false);
        router.replaceAll(
          [const PermissionsScreenPageRoute()],
        );
      } else {
        resolver.next(true);
      }
    } else {
      resolver.next(false);
      router.replaceAll(
        [const LoginRouterPageRoute()],
      );
    }
  }

  void onAppShellRouteGuardNavigation(NavigationResolver resolver, StackRouter router) {
    _logger.fine(_onNavigationLoggerMessage('onAppShellRouteGuardNavigation', resolver));

    resolver.next(true);

    // Since reevaluateListenable triggers reevaluation only on the root router,
    // explicit reevaluation on the app shell router is necessary to ensure
    // proper handling of login/logout functionality.
    if (resolver.isReevaluating) {
      final innerRouter = router.innerRouterOf<StackRouter>(AppShellRoute.name);
      innerRouter?.reevaluateGuards();
    }
  }
}

Object _onNavigationLoggerMessage(String callbackName, NavigationResolver resolver) {
  return () =>
      '$callbackName: ${resolver.route.name} (${resolver.route.fullPath}) isReevaluating=${resolver.isReevaluating}';
}
