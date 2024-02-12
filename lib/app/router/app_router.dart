import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

export 'package:auto_route/auto_route.dart' show ReevaluateListenable;

part 'app_router.gr.dart';

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

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AppShellRoute.page,
          path: '/',
          guards: [AutoRouteGuard.simple(onAppShellRouteGuardNavigation)],
          children: [
            RedirectRoute(
              path: '',
              redirectTo: 'main',
            ),
            AutoRoute(
              page: LoginScreenPageRoute.page,
              path: 'login',
            ),
            AutoRoute(
              page: PermissionsScreenPageRoute.page,
              path: 'permissions',
            ),
            AutoRoute(
              page: MainShellRoute.page,
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

  void onAppShellRouteGuardNavigation(NavigationResolver resolver, StackRouter router) {
    final coreUrl = _appBloc.state.coreUrl;
    final token = _appBloc.state.token;
    final appPermissionsDenied = _appPermissions.isDenied;

    final routeFlattened = resolver.route.flattened;

    final isLoginPath = routeFlattened.any((route) => route.name == LoginScreenPageRoute.name);
    final isMainPath = routeFlattened.any((route) => route.name == MainShellRoute.name);

    if (coreUrl != null && token != null) {
      if (isLoginPath) {
        resolver.next(false);
        router.replaceAll(
          [const MainShellRoute()],
          updateExistingRoutes: false,
        );
        return;
      } else if (isMainPath) {
        if (appPermissionsDenied) {
          resolver.next(false);
          router.replaceAll(
            [const PermissionsScreenPageRoute()],
            updateExistingRoutes: false,
          );
          return;
        }
      }
    } else if (!isLoginPath) {
      resolver.next(false);
      router.replaceAll(
        [LoginScreenPageRoute(stepPathParam: LoginStep.modeSelect.name)],
        updateExistingRoutes: false,
      );
      return;
    }

    resolver.next(true);
  }
}
