// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AboutScreenPage]
class AboutScreenPageRoute extends PageRouteInfo<void> {
  const AboutScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          AboutScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutScreenPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return AboutScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppShell();
    },
  );
}

/// generated route for
/// [AutoprovisionScreenPage]
class AutoprovisionScreenPageRoute
    extends PageRouteInfo<AutoprovisionScreenPageRouteArgs> {
  AutoprovisionScreenPageRoute({
    String? configToken,
    String? tenantId,
    List<PageRouteInfo>? children,
  }) : super(
          AutoprovisionScreenPageRoute.name,
          args: AutoprovisionScreenPageRouteArgs(
            configToken: configToken,
            tenantId: tenantId,
          ),
          rawQueryParams: {
            'config_token': configToken,
            'tenant_id': tenantId,
          },
          initialChildren: children,
        );

  static const String name = 'AutoprovisionScreenPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<AutoprovisionScreenPageRouteArgs>(
          orElse: () => AutoprovisionScreenPageRouteArgs(
                configToken: queryParams.optString('config_token'),
                tenantId: queryParams.optString('tenant_id'),
              ));
      return AutoprovisionScreenPage(
        configToken: args.configToken,
        tenantId: args.tenantId,
      );
    },
  );
}

class AutoprovisionScreenPageRouteArgs {
  const AutoprovisionScreenPageRouteArgs({
    this.configToken,
    this.tenantId,
  });

  final String? configToken;

  final String? tenantId;

  @override
  String toString() {
    return 'AutoprovisionScreenPageRouteArgs{configToken: $configToken, tenantId: $tenantId}';
  }
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return CallScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ContactScreenPageRouteArgs>(
          orElse: () => ContactScreenPageRouteArgs(
              contactId: pathParams.getInt('contactId')));
      return ContactScreenPage(args.contactId);
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContactsRouterPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return ContactsScreenPage();
    },
  );
}

/// generated route for
/// [DemoWebPage]
class DemoWebPageRoute extends PageRouteInfo<DemoWebPageRouteArgs> {
  DemoWebPageRoute({
    required Uri initialUrl,
    List<PageRouteInfo>? children,
  }) : super(
          DemoWebPageRoute.name,
          args: DemoWebPageRouteArgs(initialUrl: initialUrl),
          initialChildren: children,
        );

  static const String name = 'DemoWebPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DemoWebPageRouteArgs>();
      return DemoWebPage(args.initialUrl);
    },
  );
}

class DemoWebPageRouteArgs {
  const DemoWebPageRouteArgs({required this.initialUrl});

  final Uri initialUrl;

  @override
  String toString() {
    return 'DemoWebPageRouteArgs{initialUrl: $initialUrl}';
  }
}

/// generated route for
/// [EmbeddedScreenPage]
class EmbeddedScreenPageRoute
    extends PageRouteInfo<EmbeddedScreenPageRouteArgs> {
  EmbeddedScreenPageRoute({
    required String? id,
    List<PageRouteInfo>? children,
  }) : super(
          EmbeddedScreenPageRoute.name,
          args: EmbeddedScreenPageRouteArgs(id: id),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'EmbeddedScreenPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<EmbeddedScreenPageRouteArgs>(
          orElse: () =>
              EmbeddedScreenPageRouteArgs(id: pathParams.optString('id')));
      return EmbeddedScreenPage(id: args.id);
    },
  );
}

class EmbeddedScreenPageRouteArgs {
  const EmbeddedScreenPageRouteArgs({required this.id});

  final String? id;

  @override
  String toString() {
    return 'EmbeddedScreenPageRouteArgs{id: $id}';
  }
}

/// generated route for
/// [ErrorDetailsScreenPage]
class ErrorDetailsScreenPageRoute
    extends PageRouteInfo<ErrorDetailsScreenPageRouteArgs> {
  ErrorDetailsScreenPageRoute({
    required String title,
    required List<ErrorFieldModel> fields,
    List<PageRouteInfo>? children,
  }) : super(
          ErrorDetailsScreenPageRoute.name,
          args: ErrorDetailsScreenPageRouteArgs(
            title: title,
            fields: fields,
          ),
          initialChildren: children,
        );

  static const String name = 'ErrorDetailsScreenPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ErrorDetailsScreenPageRouteArgs>();
      return ErrorDetailsScreenPage(
        title: args.title,
        fields: args.fields,
      );
    },
  );
}

class ErrorDetailsScreenPageRouteArgs {
  const ErrorDetailsScreenPageRouteArgs({
    required this.title,
    required this.fields,
  });

  final String title;

  final List<ErrorFieldModel> fields;

  @override
  String toString() {
    return 'ErrorDetailsScreenPageRouteArgs{title: $title, fields: $fields}';
  }
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritesRouterPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return FavoritesScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<HelpScreenPageRouteArgs>(
          orElse: () => HelpScreenPageRouteArgs(
              initialUriQueryParam: queryParams.optString('initialUrl')));
      return HelpScreenPage(initialUriQueryParam: args.initialUriQueryParam);
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return KeypadScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LanguageScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LogRecordsConsoleScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginCoreUrlAssignScreenPage();
    },
  );
}

/// generated route for
/// [LoginCredentialsRequestScreenPage]
class LoginCredentialsRequestScreenPageRoute extends PageRouteInfo<void> {
  const LoginCredentialsRequestScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginCredentialsRequestScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginCredentialsRequestScreenPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginCredentialsRequestScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginModeSelectScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginOtpSigninRequestScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginOtpSigninRouterPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginOtpSigninVerifyScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginPasswordSigninScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginRouterPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginSignupRequestScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginSignupRouterPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginSignupVerifyScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return LoginSwitchScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return MainScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainShell();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return NetworkScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return PermissionsScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<RecentScreenPageRouteArgs>(
          orElse: () => RecentScreenPageRouteArgs(
              recentId: pathParams.getInt('recentId')));
      return RecentScreenPage(args.recentId);
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RecentsRouterPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return RecentsScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsRouterPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return SettingsScreenPage();
    },
  );
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<TermsConditionsScreenPageRouteArgs>(
          orElse: () => TermsConditionsScreenPageRouteArgs(
              initialUriQueryParam: queryParams.optString('initialUrl')));
      return TermsConditionsScreenPage(
          initialUriQueryParam: args.initialUriQueryParam);
    },
  );
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
/// [TestScreenPage]
class TestScreenPageRoute extends PageRouteInfo<TestScreenPageRouteArgs> {
  TestScreenPageRoute({
    required String? id,
    List<PageRouteInfo>? children,
  }) : super(
          TestScreenPageRoute.name,
          args: TestScreenPageRouteArgs(id: id),
          initialChildren: children,
        );

  static const String name = 'TestScreenPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TestScreenPageRouteArgs>();
      return TestScreenPage(id: args.id);
    },
  );
}

class TestScreenPageRouteArgs {
  const TestScreenPageRouteArgs({required this.id});

  final String? id;

  @override
  String toString() {
    return 'TestScreenPageRouteArgs{id: $id}';
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return ThemeModeScreenPage();
    },
  );
}

/// generated route for
/// [UndefinedScreenPage]
class UndefinedScreenPageRoute
    extends PageRouteInfo<UndefinedScreenPageRouteArgs> {
  UndefinedScreenPageRoute({
    required UndefinedType undefinedType,
    List<PageRouteInfo>? children,
  }) : super(
          UndefinedScreenPageRoute.name,
          args: UndefinedScreenPageRouteArgs(undefinedType: undefinedType),
          initialChildren: children,
        );

  static const String name = 'UndefinedScreenPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UndefinedScreenPageRouteArgs>();
      return UndefinedScreenPage(args.undefinedType);
    },
  );
}

class UndefinedScreenPageRouteArgs {
  const UndefinedScreenPageRouteArgs({required this.undefinedType});

  final UndefinedType undefinedType;

  @override
  String toString() {
    return 'UndefinedScreenPageRouteArgs{undefinedType: $undefinedType}';
  }
}

/// generated route for
/// [UserAgreementScreenPage]
class UserAgreementScreenPageRoute extends PageRouteInfo<void> {
  const UserAgreementScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          UserAgreementScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAgreementScreenPageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return UserAgreementScreenPage();
    },
  );
}
