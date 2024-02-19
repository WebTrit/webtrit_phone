// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AboutScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AboutScreenPage(),
      );
    },
    AppShellRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppShell(),
      );
    },
    CallScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CallScreenPage(),
      );
    },
    ContactScreenPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ContactScreenPageRouteArgs>(
          orElse: () => ContactScreenPageRouteArgs(
              contactId: pathParams.getInt('contactId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ContactScreenPage(args.contactId),
      );
    },
    ContactsRouterPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ContactsRouterPage(),
      );
    },
    ContactsScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ContactsScreenPage(),
      );
    },
    FavoritesRouterPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritesRouterPage(),
      );
    },
    FavoritesScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FavoritesScreenPage(),
      );
    },
    HelpScreenPageRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<HelpScreenPageRouteArgs>(
          orElse: () => HelpScreenPageRouteArgs(
              initialUriQueryParam: queryParams.optString('initialUrl')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HelpScreenPage(initialUriQueryParam: args.initialUriQueryParam),
      );
    },
    KeypadScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: KeypadScreenPage(),
      );
    },
    LanguageScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LanguageScreenPage(),
      );
    },
    LogRecordsConsoleScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LogRecordsConsoleScreenPage(),
      );
    },
    LoginCoreUrlAssignScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginCoreUrlAssignScreenPage(),
      );
    },
    LoginModeSelectScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginModeSelectScreenPage(),
      );
    },
    LoginOtpSigninRequestScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginOtpSigninRequestScreenPage(),
      );
    },
    LoginOtpSigninRouterPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginOtpSigninRouterPage(),
      );
    },
    LoginOtpSigninVerifyScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginOtpSigninVerifyScreenPage(),
      );
    },
    LoginPasswordSigninScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPasswordSigninScreenPage(),
      );
    },
    LoginRouterPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginRouterPage(),
      );
    },
    LoginSignupRequestScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginSignupRequestScreenPage(),
      );
    },
    LoginSignupRouterPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginSignupRouterPage(),
      );
    },
    LoginSignupVerifyScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginSignupVerifyScreenPage(),
      );
    },
    LoginSwitchScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginSwitchScreenPage(),
      );
    },
    MainScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MainScreenPage(),
      );
    },
    MainShellRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainShell(),
      );
    },
    NetworkScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NetworkScreenPage(),
      );
    },
    PermissionsScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PermissionsScreenPage(),
      );
    },
    RecentScreenPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RecentScreenPageRouteArgs>(
          orElse: () => RecentScreenPageRouteArgs(
              recentId: pathParams.getInt('recentId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecentScreenPage(args.recentId),
      );
    },
    RecentsRouterPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RecentsRouterPage(),
      );
    },
    RecentsScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecentsScreenPage(),
      );
    },
    SettingsRouterPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsRouterPage(),
      );
    },
    SettingsScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SettingsScreenPage(),
      );
    },
    TermsConditionsScreenPageRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<TermsConditionsScreenPageRouteArgs>(
          orElse: () => TermsConditionsScreenPageRouteArgs(
              initialUriQueryParam: queryParams.optString('initialUrl')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TermsConditionsScreenPage(
            initialUriQueryParam: args.initialUriQueryParam),
      );
    },
    ThemeModeScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ThemeModeScreenPage(),
      );
    },
  };
}

/// generated route for
/// [AboutScreenPage]
class AboutScreenPageRoute extends PageRouteInfo<void> {
  const AboutScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          AboutScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AppShell]
class AppShellRoute extends PageRouteInfo<void> {
  const AppShellRoute({List<PageRouteInfo>? children})
      : super(
          AppShellRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppShellRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CallScreenPage]
class CallScreenPageRoute extends PageRouteInfo<void> {
  const CallScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          CallScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CallScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ContactScreenPage]
class ContactScreenPageRoute extends PageRouteInfo<ContactScreenPageRouteArgs> {
  ContactScreenPageRoute({
    required int contactId,
    List<PageRouteInfo>? children,
  }) : super(
          ContactScreenPageRoute.name,
          args: ContactScreenPageRouteArgs(contactId: contactId),
          rawPathParams: {'contactId': contactId},
          initialChildren: children,
        );

  static const String name = 'ContactScreenPageRoute';

  static const PageInfo<ContactScreenPageRouteArgs> page =
      PageInfo<ContactScreenPageRouteArgs>(name);
}

class ContactScreenPageRouteArgs {
  const ContactScreenPageRouteArgs({required this.contactId});

  final int contactId;

  @override
  String toString() {
    return 'ContactScreenPageRouteArgs{contactId: $contactId}';
  }
}

/// generated route for
/// [ContactsRouterPage]
class ContactsRouterPageRoute extends PageRouteInfo<void> {
  const ContactsRouterPageRoute({List<PageRouteInfo>? children})
      : super(
          ContactsRouterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactsRouterPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ContactsScreenPage]
class ContactsScreenPageRoute extends PageRouteInfo<void> {
  const ContactsScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          ContactsScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactsScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoritesRouterPage]
class FavoritesRouterPageRoute extends PageRouteInfo<void> {
  const FavoritesRouterPageRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesRouterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRouterPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoritesScreenPage]
class FavoritesScreenPageRoute extends PageRouteInfo<void> {
  const FavoritesScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HelpScreenPage]
class HelpScreenPageRoute extends PageRouteInfo<HelpScreenPageRouteArgs> {
  HelpScreenPageRoute({
    String? initialUriQueryParam,
    List<PageRouteInfo>? children,
  }) : super(
          HelpScreenPageRoute.name,
          args: HelpScreenPageRouteArgs(
              initialUriQueryParam: initialUriQueryParam),
          rawQueryParams: {'initialUrl': initialUriQueryParam},
          initialChildren: children,
        );

  static const String name = 'HelpScreenPageRoute';

  static const PageInfo<HelpScreenPageRouteArgs> page =
      PageInfo<HelpScreenPageRouteArgs>(name);
}

class HelpScreenPageRouteArgs {
  const HelpScreenPageRouteArgs({this.initialUriQueryParam});

  final String? initialUriQueryParam;

  @override
  String toString() {
    return 'HelpScreenPageRouteArgs{initialUriQueryParam: $initialUriQueryParam}';
  }
}

/// generated route for
/// [KeypadScreenPage]
class KeypadScreenPageRoute extends PageRouteInfo<void> {
  const KeypadScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          KeypadScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'KeypadScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LanguageScreenPage]
class LanguageScreenPageRoute extends PageRouteInfo<void> {
  const LanguageScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LanguageScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LogRecordsConsoleScreenPage]
class LogRecordsConsoleScreenPageRoute extends PageRouteInfo<void> {
  const LogRecordsConsoleScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LogRecordsConsoleScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LogRecordsConsoleScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginCoreUrlAssignScreenPage]
class LoginCoreUrlAssignScreenPageRoute extends PageRouteInfo<void> {
  const LoginCoreUrlAssignScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginCoreUrlAssignScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginCoreUrlAssignScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginModeSelectScreenPage]
class LoginModeSelectScreenPageRoute extends PageRouteInfo<void> {
  const LoginModeSelectScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginModeSelectScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginModeSelectScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginOtpSigninRequestScreenPage]
class LoginOtpSigninRequestScreenPageRoute extends PageRouteInfo<void> {
  const LoginOtpSigninRequestScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginOtpSigninRequestScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginOtpSigninRequestScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginOtpSigninRouterPage]
class LoginOtpSigninRouterPageRoute extends PageRouteInfo<void> {
  const LoginOtpSigninRouterPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginOtpSigninRouterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginOtpSigninRouterPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginOtpSigninVerifyScreenPage]
class LoginOtpSigninVerifyScreenPageRoute extends PageRouteInfo<void> {
  const LoginOtpSigninVerifyScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginOtpSigninVerifyScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginOtpSigninVerifyScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPasswordSigninScreenPage]
class LoginPasswordSigninScreenPageRoute extends PageRouteInfo<void> {
  const LoginPasswordSigninScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginPasswordSigninScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPasswordSigninScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginRouterPage]
class LoginRouterPageRoute extends PageRouteInfo<void> {
  const LoginRouterPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginRouterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRouterPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginSignupRequestScreenPage]
class LoginSignupRequestScreenPageRoute extends PageRouteInfo<void> {
  const LoginSignupRequestScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginSignupRequestScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginSignupRequestScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginSignupRouterPage]
class LoginSignupRouterPageRoute extends PageRouteInfo<void> {
  const LoginSignupRouterPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginSignupRouterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginSignupRouterPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginSignupVerifyScreenPage]
class LoginSignupVerifyScreenPageRoute extends PageRouteInfo<void> {
  const LoginSignupVerifyScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginSignupVerifyScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginSignupVerifyScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginSwitchScreenPage]
class LoginSwitchScreenPageRoute extends PageRouteInfo<void> {
  const LoginSwitchScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginSwitchScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginSwitchScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreenPage]
class MainScreenPageRoute extends PageRouteInfo<void> {
  const MainScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          MainScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainShell]
class MainShellRoute extends PageRouteInfo<void> {
  const MainShellRoute({List<PageRouteInfo>? children})
      : super(
          MainShellRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainShellRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NetworkScreenPage]
class NetworkScreenPageRoute extends PageRouteInfo<void> {
  const NetworkScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          NetworkScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'NetworkScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PermissionsScreenPage]
class PermissionsScreenPageRoute extends PageRouteInfo<void> {
  const PermissionsScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          PermissionsScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'PermissionsScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecentScreenPage]
class RecentScreenPageRoute extends PageRouteInfo<RecentScreenPageRouteArgs> {
  RecentScreenPageRoute({
    required int recentId,
    List<PageRouteInfo>? children,
  }) : super(
          RecentScreenPageRoute.name,
          args: RecentScreenPageRouteArgs(recentId: recentId),
          rawPathParams: {'recentId': recentId},
          initialChildren: children,
        );

  static const String name = 'RecentScreenPageRoute';

  static const PageInfo<RecentScreenPageRouteArgs> page =
      PageInfo<RecentScreenPageRouteArgs>(name);
}

class RecentScreenPageRouteArgs {
  const RecentScreenPageRouteArgs({required this.recentId});

  final int recentId;

  @override
  String toString() {
    return 'RecentScreenPageRouteArgs{recentId: $recentId}';
  }
}

/// generated route for
/// [RecentsRouterPage]
class RecentsRouterPageRoute extends PageRouteInfo<void> {
  const RecentsRouterPageRoute({List<PageRouteInfo>? children})
      : super(
          RecentsRouterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecentsRouterPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecentsScreenPage]
class RecentsScreenPageRoute extends PageRouteInfo<void> {
  const RecentsScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          RecentsScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecentsScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsRouterPage]
class SettingsRouterPageRoute extends PageRouteInfo<void> {
  const SettingsRouterPageRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRouterPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRouterPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreenPage]
class SettingsScreenPageRoute extends PageRouteInfo<void> {
  const SettingsScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          SettingsScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TermsConditionsScreenPage]
class TermsConditionsScreenPageRoute
    extends PageRouteInfo<TermsConditionsScreenPageRouteArgs> {
  TermsConditionsScreenPageRoute({
    String? initialUriQueryParam,
    List<PageRouteInfo>? children,
  }) : super(
          TermsConditionsScreenPageRoute.name,
          args: TermsConditionsScreenPageRouteArgs(
              initialUriQueryParam: initialUriQueryParam),
          rawQueryParams: {'initialUrl': initialUriQueryParam},
          initialChildren: children,
        );

  static const String name = 'TermsConditionsScreenPageRoute';

  static const PageInfo<TermsConditionsScreenPageRouteArgs> page =
      PageInfo<TermsConditionsScreenPageRouteArgs>(name);
}

class TermsConditionsScreenPageRouteArgs {
  const TermsConditionsScreenPageRouteArgs({this.initialUriQueryParam});

  final String? initialUriQueryParam;

  @override
  String toString() {
    return 'TermsConditionsScreenPageRouteArgs{initialUriQueryParam: $initialUriQueryParam}';
  }
}

/// generated route for
/// [ThemeModeScreenPage]
class ThemeModeScreenPageRoute extends PageRouteInfo<void> {
  const ThemeModeScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          ThemeModeScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemeModeScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
