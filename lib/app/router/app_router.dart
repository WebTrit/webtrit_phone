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
          initial: true,
          children: [
            AutoRoute(
              page: LoginScreenPageRoute.page,
            ),
            AutoRoute(
              page: PermissionsScreenPageRoute.page,
            ),
            AutoRoute(
              page: MainShellRoute.page,
              initial: true,
              guards: [AuthGuard(_secureStorage)],
              children: [
                AutoRoute(
                  initial: true,
                  page: MainScreenPageRoute.page,
                  children: [
                    RedirectRoute(
                      path: '',
                      redirectTo: _appPreferences.getActiveMainFlavor().name,
                    ),
                    AutoRoute(
                      page: FavoritesRouterPageRoute.page,
                      path: MainFlavor.favorites.name,
                      children: [
                        AutoRoute(page: FavoritesScreenPageRoute.page, initial: true),
                        AutoRoute(page: ContactScreenPageRoute.page),
                      ],
                    ),
                    AutoRoute(
                      page: RecentsRouterPageRoute.page,
                      path: MainFlavor.recents.name,
                      children: [
                        AutoRoute(page: RecentsScreenPageRoute.page, initial: true),
                        AutoRoute(page: RecentScreenPageRoute.page),
                      ],
                    ),
                    AutoRoute(
                      page: ContactsRouterPageRoute.page,
                      path: MainFlavor.contacts.name,
                      children: [
                        AutoRoute(page: ContactsScreenPageRoute.page, initial: true),
                        AutoRoute(page: ContactScreenPageRoute.page),
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
                  fullscreenDialog: true,
                ),
                AutoRoute(
                  page: SettingsScreenPageRoute.page,
                  fullscreenDialog: true,
                ),
                AutoRoute(
                  page: AboutScreenPageRoute.page,
                ),
                AutoRoute(
                  page: HelpScreenPageRoute.page,
                ),
                AutoRoute(
                  page: LanguageScreenPageRoute.page,
                ),
                AutoRoute(
                  page: NetworkScreenPageRoute.page,
                ),
                AutoRoute(
                  page: TermsConditionsScreenPageRoute.page,
                ),
                AutoRoute(
                  page: ThemeModeScreenPageRoute.page,
                ),
                AutoRoute(
                  page: LogRecordsConsoleScreenPageRoute.page,
                ),
              ],
            ),
          ],
        )
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
