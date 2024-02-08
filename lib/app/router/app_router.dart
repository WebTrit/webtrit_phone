import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

import 'auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: null,
)
class AppRouter extends _$AppRouter {
  AppRouter(
    this._appBloc,
    this._appPreferences,
    this._secureStorage,
    this._appPermissions,
  ) {
    _refreshListenable = GoRouterRefreshBloc<AppState>(_appBloc)..addListener(_onRefreshListener);
  }

  final AppBloc _appBloc;
  final AppPreferences _appPreferences;
  final SecureStorage _secureStorage;
  final AppPermissions _appPermissions;

  late final Listenable? _refreshListenable;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AppShellRoute.page,
          path: '/',
          children: [
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
              path: '',
              guards: [AuthGuard(_secureStorage)],
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
                AutoRoute(
                  page: CallScreenPageRoute.page,
                  path: 'call',
                  fullscreenDialog: true,
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

  void _onRefreshListener() {
    final appPermissionsDenied = _appPermissions.isDenied;

    final coreUrl = _appBloc.state.coreUrl;
    final token = _appBloc.state.token;

    if (coreUrl != null && token != null) {
      if (appPermissionsDenied) {
        replaceAll([const PermissionsScreenPageRoute()], updateExistingRoutes: false);
      } else {
        replaceAll([const MainScreenPageRoute()], updateExistingRoutes: false);
      }
    } else {
      replaceAll([LoginScreenPageRoute(stepPathParam: LoginStep.modeSelect.name)]);
    }
  }

  @override
  void dispose() {
    _refreshListenable?.removeListener(_onRefreshListener);
    _refreshListenable = null;
    super.dispose();
  }
}

class GoRouterRefreshBloc<S> extends ChangeNotifier {
  GoRouterRefreshBloc(BlocBase<S> bloc) {
    notifyListeners();
    _subscription = bloc.stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<S> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
