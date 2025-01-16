import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

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
    this._appPermissions,
    this._launchLoginEmbedded,
    this._initialBottomMenuTab,
  );

  final AppBloc _appBloc;
  final AppPermissions _appPermissions;

  final LoginEmbedded? _launchLoginEmbedded;
  final BottomMenuTab _initialBottomMenuTab;

  String? get coreUrl => _appBloc.state.coreUrl;

  String? get token => _appBloc.state.token;

  String? get userId => _appBloc.state.userId;

  bool get appPermissionsDenied => _appPermissions.isDenied;

  bool get appUserAgreementUnaccepted => _appBloc.state.userAgreementAccepted != true;

  bool get appContactsAgreementUnaccepted => _appBloc.state.contactsAgreementUnaccepted != true;

  bool get appLoggedIn => coreUrl != null && token != null && userId != null;

  @override
  List<AutoRoute> get routes => [
        AutoRoute.guarded(
          page: AppShellRoute.page,
          onNavigation: onAppShellRouteGuardNavigation,
          path: '/',
          children: [
            RedirectRoute(
              path: '',
              redirectTo: MainShellRoute.name,
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
                  page: LoginEmbeddedScreenPageRoute.page,
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
                          page: LoginSignupEmbeddedRequestScreenPageRoute.page,
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
              page: ContactsAgreementScreenPageRoute.page,
              onNavigation: onContactsAgreementScreenPageRouteGuardNavigation,
              path: 'contacts-agreement',
            ),
            AutoRoute.guarded(
              page: AutoprovisionScreenPageRoute.page,
              onNavigation: onAutoprovisionScreenPageRouteGuardNavigation,
              path: 'autoprovision',
            ),
            AutoRoute.guarded(
              page: MainShellRoute.page,
              onNavigation: onMainShellRouteGuardNavigation,
              path: MainShellRoute.name,
              children: [
                AutoRoute(
                  page: MainScreenPageRoute.page,
                  path: '',
                  guards: [
                    // Redirects to the appropriate screen if required parameters are missing
                    // This ensures that necessary data is passed to the  screen when the initial route is loaded.
                    AutoRouteGuard.redirect(
                      (resolver) => EmbeddedScreenPage.getPageRouteInfo(
                        resolver.route,
                        _initialBottomMenuTab.data,
                      ),
                    ),
                  ],
                  children: [
                    RedirectRoute(
                      path: '',
                      redirectTo: _initialBottomMenuTab.flavor.name,
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
                          guards: [
                            // Redirects to the appropriate screen if required parameters are missing
                            // This ensures that necessary data is passed to the  screen when the initial route is loaded.
                            AutoRouteGuard.redirect(
                              (resolver) => ContactsScreenPage.getPageRouteInfo(
                                resolver.route,
                                () => _initialBottomMenuTab.toContacts.contactSourceTypes,
                              ),
                            ),
                          ],
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
                    // Embedded flavors
                    AutoRoute(
                      page: EmbeddedScreenPage1Route.page,
                      path: MainFlavor.embedded1.name,
                    ),
                    AutoRoute(
                      page: EmbeddedScreenPage2Route.page,
                      path: MainFlavor.embedded2.name,
                    ),
                    AutoRoute(
                      page: EmbeddedScreenPage3Route.page,
                      path: MainFlavor.embedded3.name,
                    ),
                    AutoRoute(
                      page: ConversationsScreenPageRoute.page,
                      path: MainFlavor.messaging.name,
                    ),
                  ],
                ),
                AutoRoute(
                  page: ChatConversationScreenPageRoute.page,
                  path: 'chat_conversation',
                ),
                AutoRoute(
                  page: SmsConversationScreenPageRoute.page,
                  path: 'sms_conversation',
                ),
                AutoRoute(
                  page: CallToActionsWebPageRoute.page,
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
                      page: CallCodecsScreenPageRoute.page,
                      path: 'call_codecs',
                    ),
                    AutoRoute(
                      page: ThemeModeScreenPageRoute.page,
                      path: 'theme-mode',
                    ),
                    AutoRoute(
                      page: DiagnosticScreenPageRoute.page,
                      path: 'diagnostic',
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
            AutoRoute(
              page: EmbeddedScreenPage1Route.page,
              path: 'embedded',
            ),
          ],
        ),
      ];

  void onLoginScreenPageRouteGuardNavigation(NavigationResolver resolver, StackRouter router) {
    _logger.fine(_onNavigationLoggerMessage('onLoginScreenPageRouteGuardNavigation', resolver));

    if (appLoggedIn) {
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
    _logger.fine(_onNavigationLoggerMessage('onUserAgreementScreenPageRouteGuardNavigation', resolver));

    if (appUserAgreementUnaccepted) {
      resolver.next(true);
    } else {
      resolver.next(false);
      router.replaceAll(
        [const MainShellRoute()],
      );
    }
  }

  void onContactsAgreementScreenPageRouteGuardNavigation(NavigationResolver resolver, StackRouter router) {
    _logger.fine(_onNavigationLoggerMessage('onContactsAgreementScreenPageRouteGuardNavigation', resolver));

    if (appContactsAgreementUnaccepted) {
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

    if (appLoggedIn) {
      if (appUserAgreementUnaccepted) {
        resolver.next(false);
        router.replaceAll(
          [const UserAgreementScreenPageRoute()],
        );
      } else if (appContactsAgreementUnaccepted) {
        resolver.next(false);
        router.replaceAll(
          [const ContactsAgreementScreenPageRoute()],
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
        [
          LoginRouterPageRoute(
            launchLoginEmbedded: _launchLoginEmbedded,
          )
        ],
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
      HandleAndroidBackgroundIncomingCall(deepLink),
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
