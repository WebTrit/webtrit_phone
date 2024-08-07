import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

import 'deeplinks.dart';

export 'package:auto_route/auto_route.dart' show ReevaluateListenable;
export 'package:auto_route/auto_route.dart' show ReevaluateListenable, AutoRouteObserver;

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
  bool get appUserAgreementUnaccepted => _appBloc.state.userAgreementAccepted != true;

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
                  page: LoginCredentialsRequestScreenPageRoute.page,
                  maintainState: false,
                ),
                AutoRoute(
                  page: LoginCoreUrlAssignScreenPageRoute.page,
                ),
                AutoRoute(
                  page: LoginSwitchScreenPageRoute.page,
                  children: [
                    AutoRoute(
                      page: LoginOtpSigninRouterPageRoute.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                          page: LoginOtpSigninRequestScreenPageRoute.page,
                          maintainState: false,
                        ),
                        AutoRoute(
                          page: LoginOtpSigninVerifyScreenPageRoute.page,
                          maintainState: false,
                        ),
                      ],
                    ),
                    AutoRoute(
                      page: LoginPasswordSigninScreenPageRoute.page,
                      maintainState: false,
                    ),
                    AutoRoute(
                      page: LoginSignupRouterPageRoute.page,
                      maintainState: false,
                      children: [
                        AutoRoute(
                          page: LoginSignupRequestScreenPageRoute.page,
                          maintainState: false,
                        ),
                        AutoRoute(
                          page: LoginSignupVerifyScreenPageRoute.page,
                          maintainState: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            AutoRoute.guarded(
              page: PermissionsScreenPageRoute.page,
              onNavigation: onPermissionsScreenPageRouteGuardNavigation,
              path: 'permissions',
            ),
            AutoRoute.guarded(
              page: UserAgreementScreenPageRoute.page,
              onNavigation: onUserAgreementScreenPageRouteGuardNavigation,
              path: 'user-agreement',
            ),
            AutoRoute.guarded(
              page: AutoprovisionScreenPageRoute.page,
              onNavigation: onAutoprovisionScreenPageRouteGuardNavigation,
              path: 'autoprovision',
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
                AutoRoute(
                  page: DemoWebPageRoute.page,
                  path: 'demo',
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
                      page: ThemeModeScreenPageRoute.page,
                      path: 'theme-mode',
                    ),
                  ],
                ),
              ],
            ),
            AutoRoute(
              page: TermsConditionsScreenPageRoute.page,
              path: 'terms-conditions',
            ),
            AutoRoute(
              page: ErrorDetailsScreenPageRoute.page,
              path: 'error-details',
            ),
            AutoRoute(
              page: LogRecordsConsoleScreenPageRoute.page,
              path: 'log-records-console',
            ),
            AutoRoute(
              page: UndefinedScreenPageRoute.page,
              path: 'undefined',
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

    if (appPermissionsDenied) {
      resolver.next(true);
    } else {
      resolver.next(false);
      router.replaceAll(
        [const MainShellRoute()],
      );
    }
  }

  void onUserAgreementScreenPageRouteGuardNavigation(NavigationResolver resolver, StackRouter router) {
    _logger.fine(_onNavigationLoggerMessage('onPermissionsScreenPageRouteGuardNavigation', resolver));

    if (appUserAgreementUnaccepted) {
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

    const appTermsAndConditionsUrl = EnvironmentConfig.APP_TERMS_AND_CONDITIONS_URL;
    final hasToAcceptUserAgreement = appUserAgreementUnaccepted && appTermsAndConditionsUrl?.isNotEmpty == true;

    if (coreUrl != null && token != null) {
      if (hasToAcceptUserAgreement) {
        resolver.next(false);
        router.replaceAll(
          [const UserAgreementScreenPageRoute()],
        );
      } else if (appPermissionsDenied) {
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

  void onAutoprovisionScreenPageRouteGuardNavigation(NavigationResolver resolver, StackRouter router) {
    _logger.fine(_onNavigationLoggerMessage('onAutoprovisionScreenPageRouteGuardNavigation', resolver));

    final query = resolver.route.queryParams;
    final configToken = query.optString('config_token');

    // Protect from invalid token or redirect to the main shell in case
    // when new token is aplied by appbloc and provisioning screen is initial
    // so the reevaluation will be triggered
    if (configToken != null && configToken.isNotEmpty && !resolver.isReevaluating) {
      resolver.next(true);
    } else {
      resolver.next(false);
      router.replaceAll(
        [const MainShellRoute()],
      );
    }
  }

  FutureOr<DeepLink> deepLinkBuilder(PlatformDeepLink deepLink) {
    final handlers = <DeepLinkHandler>[
      // Internal deep-links within the platform
      HandleAndroidBackgroundIncomingCall(deepLink, _appBloc.pendingCallHandler),
      HandleReturnToMain(deepLink),
      // External deep-links from outside the application
      HandleAutoprovision(deepLink),
      HandleNotDefinedPath(deepLink, this),
    ];

    for (final handler in handlers) {
      final deeplink = handler.handle();
      if (deeplink != null) return deeplink;
    }

    return DeepLink.defaultPath;
  }
}

Object _onNavigationLoggerMessage(String callbackName, NavigationResolver resolver) {
  return () =>
      '$callbackName: ${resolver.route.name} (${resolver.route.fullPath}) isReevaluating=${resolver.isReevaluating}';
}
