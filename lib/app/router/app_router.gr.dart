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
    AuthShellPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthShellPage(),
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
    ContactsScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ContactsScreenPage(),
      );
    },
    ContactsTabPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ContactsTabPage(),
      );
    },
    FavoritesScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FavoritesScreenPage(),
      );
    },
    FavoritesTabPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritesTabPage(),
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
    ModeSelectScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ModeSelectScreenPage(),
      );
    },
    NetworkScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NetworkScreenPage(),
      );
    },
    OtpLoginPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OtpLoginPage(),
      );
    },
    OtpRequestScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OtpRequestScreenPage(),
      );
    },
    OtpVerifyScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OtpVerifyScreenPage(),
      );
    },
    PasswordLoginPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PasswordLoginPage(),
      );
    },
    PasswordRequestScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PasswordRequestScreenPage(),
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
    RecentsScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecentsScreenPage(),
      );
    },
    RecentsTabPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RecentsTabPage(),
      );
    },
    SettingsScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SettingsScreenPage(),
      );
    },
    SupportedLoginsScreenPageRoute.name: (routeData) {
      final args = routeData.argsAs<SupportedLoginsScreenPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SupportedLoginsScreenPage(
          supportedLogins: args.supportedLogins,
          coreUrl: args.coreUrl,
          demo: args.demo,
          defaultTenantId: args.defaultTenantId,
        ),
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
/// [AuthShellPage]
class AuthShellPageRoute extends PageRouteInfo<void> {
  const AuthShellPageRoute({List<PageRouteInfo>? children})
      : super(
          AuthShellPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthShellPageRoute';

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
/// [ContactsTabPage]
class ContactsTabPageRoute extends PageRouteInfo<void> {
  const ContactsTabPageRoute({List<PageRouteInfo>? children})
      : super(
          ContactsTabPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactsTabPageRoute';

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
/// [FavoritesTabPage]
class FavoritesTabPageRoute extends PageRouteInfo<void> {
  const FavoritesTabPageRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesTabPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesTabPageRoute';

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
/// [ModeSelectScreenPage]
class ModeSelectScreenPageRoute extends PageRouteInfo<void> {
  const ModeSelectScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          ModeSelectScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ModeSelectScreenPageRoute';

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
/// [OtpLoginPage]
class OtpLoginPageRoute extends PageRouteInfo<void> {
  const OtpLoginPageRoute({List<PageRouteInfo>? children})
      : super(
          OtpLoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'OtpLoginPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OtpRequestScreenPage]
class OtpRequestScreenPageRoute extends PageRouteInfo<void> {
  const OtpRequestScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          OtpRequestScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'OtpRequestScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OtpVerifyScreenPage]
class OtpVerifyScreenPageRoute extends PageRouteInfo<void> {
  const OtpVerifyScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          OtpVerifyScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'OtpVerifyScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PasswordLoginPage]
class PasswordLoginPageRoute extends PageRouteInfo<void> {
  const PasswordLoginPageRoute({List<PageRouteInfo>? children})
      : super(
          PasswordLoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'PasswordLoginPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PasswordRequestScreenPage]
class PasswordRequestScreenPageRoute extends PageRouteInfo<void> {
  const PasswordRequestScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          PasswordRequestScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'PasswordRequestScreenPageRoute';

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
/// [RecentsTabPage]
class RecentsTabPageRoute extends PageRouteInfo<void> {
  const RecentsTabPageRoute({List<PageRouteInfo>? children})
      : super(
          RecentsTabPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecentsTabPageRoute';

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
/// [SupportedLoginsScreenPage]
class SupportedLoginsScreenPageRoute
    extends PageRouteInfo<SupportedLoginsScreenPageRouteArgs> {
  SupportedLoginsScreenPageRoute({
    required List<SupportedLoginType> supportedLogins,
    required String coreUrl,
    required bool demo,
    required String defaultTenantId,
    List<PageRouteInfo>? children,
  }) : super(
          SupportedLoginsScreenPageRoute.name,
          args: SupportedLoginsScreenPageRouteArgs(
            supportedLogins: supportedLogins,
            coreUrl: coreUrl,
            demo: demo,
            defaultTenantId: defaultTenantId,
          ),
          initialChildren: children,
        );

  static const String name = 'SupportedLoginsScreenPageRoute';

  static const PageInfo<SupportedLoginsScreenPageRouteArgs> page =
      PageInfo<SupportedLoginsScreenPageRouteArgs>(name);
}

class SupportedLoginsScreenPageRouteArgs {
  const SupportedLoginsScreenPageRouteArgs({
    required this.supportedLogins,
    required this.coreUrl,
    required this.demo,
    required this.defaultTenantId,
  });

  final List<SupportedLoginType> supportedLogins;

  final String coreUrl;

  final bool demo;

  final String defaultTenantId;

  @override
  String toString() {
    return 'SupportedLoginsScreenPageRouteArgs{supportedLogins: $supportedLogins, coreUrl: $coreUrl, demo: $demo, defaultTenantId: $defaultTenantId}';
  }
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
