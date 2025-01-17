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
    AutoprovisionScreenPageRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<AutoprovisionScreenPageRouteArgs>(
          orElse: () => AutoprovisionScreenPageRouteArgs(
                configToken: queryParams.optString('config_token'),
                tenantId: queryParams.optString('tenant_id'),
                coreUrl: queryParams.optString('core_url'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AutoprovisionScreenPage(
          configToken: args.configToken,
          tenantId: args.tenantId,
          coreUrl: args.coreUrl,
        ),
      );
    },
    CallCodecsScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CallCodecsScreenPage(),
      );
    },
    CallScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CallScreenPage(),
      );
    },
    CallToActionsWebPageRoute.name: (routeData) {
      final args = routeData.argsAs<CallToActionsWebPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CallToActionsWebPage(args.initialUrl),
      );
    },
    ChatConversationScreenPageRoute.name: (routeData) {
      final args = routeData.argsAs<ChatConversationScreenPageRouteArgs>(
          orElse: () => const ChatConversationScreenPageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatConversationScreenPage(
          participantId: args.participantId,
          chatId: args.chatId,
        ),
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
    ContactsAgreementScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ContactsAgreementScreenPage(),
      );
    },
    ContactsRouterPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ContactsRouterPage(),
      );
    },
    ContactsScreenPageRoute.name: (routeData) {
      final args = routeData.argsAs<ContactsScreenPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ContactsScreenPage(sourceTypes: args.sourceTypes),
      );
    },
    ConversationsScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConversationsScreenPage(),
      );
    },
    DiagnosticScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DiagnosticScreenPage(),
      );
    },
    EmbeddedScreenPage1Route.name: (routeData) {
      final args = routeData.argsAs<EmbeddedScreenPage1RouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EmbeddedScreenPage1(args.data),
      );
    },
    EmbeddedScreenPage2Route.name: (routeData) {
      final args = routeData.argsAs<EmbeddedScreenPage2RouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EmbeddedScreenPage2(args.data),
      );
    },
    EmbeddedScreenPage3Route.name: (routeData) {
      final args = routeData.argsAs<EmbeddedScreenPage3RouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EmbeddedScreenPage3(args.data),
      );
    },
    ErrorDetailsScreenPageRoute.name: (routeData) {
      final args = routeData.argsAs<ErrorDetailsScreenPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ErrorDetailsScreenPage(
          title: args.title,
          fields: args.fields,
        ),
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
    LoginEmbeddedScreenPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginEmbeddedScreenPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginEmbeddedScreenPage(loginEmbedded: args.loginEmbedded),
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
      final args = routeData.argsAs<LoginRouterPageRouteArgs>(
          orElse: () => const LoginRouterPageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginRouterPage(launchLoginEmbedded: args.launchLoginEmbedded),
      );
    },
    LoginSignupEmbeddedRequestScreenPageRoute.name: (routeData) {
      final args =
          routeData.argsAs<LoginSignupEmbeddedRequestScreenPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginSignupEmbeddedRequestScreenPage(args.embeddedData),
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
          orElse: () =>
              RecentScreenPageRouteArgs(callId: pathParams.getInt('callId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecentScreenPage(args.callId),
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
    SelfConfigScreenPageRoute.name: (routeData) {
      final args = routeData.argsAs<SelfConfigScreenPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SelfConfigScreenPage(args.url),
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
    SmsConversationScreenPageRoute.name: (routeData) {
      final args = routeData.argsAs<SmsConversationScreenPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SmsConversationScreenPage(
          firstNumber: args.firstNumber,
          secondNumber: args.secondNumber,
          recipientId: args.recipientId,
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
    UndefinedScreenPageRoute.name: (routeData) {
      final args = routeData.argsAs<UndefinedScreenPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UndefinedScreenPage(args.undefinedType),
      );
    },
    UserAgreementScreenPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserAgreementScreenPage(),
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
/// [AutoprovisionScreenPage]
class AutoprovisionScreenPageRoute
    extends PageRouteInfo<AutoprovisionScreenPageRouteArgs> {
  AutoprovisionScreenPageRoute({
    String? configToken,
    String? tenantId,
    String? coreUrl,
    List<PageRouteInfo>? children,
  }) : super(
          AutoprovisionScreenPageRoute.name,
          args: AutoprovisionScreenPageRouteArgs(
            configToken: configToken,
            tenantId: tenantId,
            coreUrl: coreUrl,
          ),
          rawQueryParams: {
            'config_token': configToken,
            'tenant_id': tenantId,
            'core_url': coreUrl,
          },
          initialChildren: children,
        );

  static const String name = 'AutoprovisionScreenPageRoute';

  static const PageInfo<AutoprovisionScreenPageRouteArgs> page =
      PageInfo<AutoprovisionScreenPageRouteArgs>(name);
}

class AutoprovisionScreenPageRouteArgs {
  const AutoprovisionScreenPageRouteArgs({
    this.configToken,
    this.tenantId,
    this.coreUrl,
  });

  final String? configToken;

  final String? tenantId;

  final String? coreUrl;

  @override
  String toString() {
    return 'AutoprovisionScreenPageRouteArgs{configToken: $configToken, tenantId: $tenantId, coreUrl: $coreUrl}';
  }
}

/// generated route for
/// [CallCodecsScreenPage]
class CallCodecsScreenPageRoute extends PageRouteInfo<void> {
  const CallCodecsScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          CallCodecsScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'CallCodecsScreenPageRoute';

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
/// [CallToActionsWebPage]
class CallToActionsWebPageRoute
    extends PageRouteInfo<CallToActionsWebPageRouteArgs> {
  CallToActionsWebPageRoute({
    required Uri initialUrl,
    List<PageRouteInfo>? children,
  }) : super(
          CallToActionsWebPageRoute.name,
          args: CallToActionsWebPageRouteArgs(initialUrl: initialUrl),
          initialChildren: children,
        );

  static const String name = 'CallToActionsWebPageRoute';

  static const PageInfo<CallToActionsWebPageRouteArgs> page =
      PageInfo<CallToActionsWebPageRouteArgs>(name);
}

class CallToActionsWebPageRouteArgs {
  const CallToActionsWebPageRouteArgs({required this.initialUrl});

  final Uri initialUrl;

  @override
  String toString() {
    return 'CallToActionsWebPageRouteArgs{initialUrl: $initialUrl}';
  }
}

/// generated route for
/// [ChatConversationScreenPage]
class ChatConversationScreenPageRoute
    extends PageRouteInfo<ChatConversationScreenPageRouteArgs> {
  ChatConversationScreenPageRoute({
    String? participantId,
    int? chatId,
    List<PageRouteInfo>? children,
  }) : super(
          ChatConversationScreenPageRoute.name,
          args: ChatConversationScreenPageRouteArgs(
            participantId: participantId,
            chatId: chatId,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatConversationScreenPageRoute';

  static const PageInfo<ChatConversationScreenPageRouteArgs> page =
      PageInfo<ChatConversationScreenPageRouteArgs>(name);
}

class ChatConversationScreenPageRouteArgs {
  const ChatConversationScreenPageRouteArgs({
    this.participantId,
    this.chatId,
  });

  final String? participantId;

  final int? chatId;

  @override
  String toString() {
    return 'ChatConversationScreenPageRouteArgs{participantId: $participantId, chatId: $chatId}';
  }
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
/// [ContactsAgreementScreenPage]
class ContactsAgreementScreenPageRoute extends PageRouteInfo<void> {
  const ContactsAgreementScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          ContactsAgreementScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactsAgreementScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
class ContactsScreenPageRoute
    extends PageRouteInfo<ContactsScreenPageRouteArgs> {
  ContactsScreenPageRoute({
    required List<ContactSourceType> sourceTypes,
    List<PageRouteInfo>? children,
  }) : super(
          ContactsScreenPageRoute.name,
          args: ContactsScreenPageRouteArgs(sourceTypes: sourceTypes),
          initialChildren: children,
        );

  static const String name = 'ContactsScreenPageRoute';

  static const PageInfo<ContactsScreenPageRouteArgs> page =
      PageInfo<ContactsScreenPageRouteArgs>(name);
}

class ContactsScreenPageRouteArgs {
  const ContactsScreenPageRouteArgs({required this.sourceTypes});

  final List<ContactSourceType> sourceTypes;

  @override
  String toString() {
    return 'ContactsScreenPageRouteArgs{sourceTypes: $sourceTypes}';
  }
}

/// generated route for
/// [ConversationsScreenPage]
class ConversationsScreenPageRoute extends PageRouteInfo<void> {
  const ConversationsScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          ConversationsScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConversationsScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DiagnosticScreenPage]
class DiagnosticScreenPageRoute extends PageRouteInfo<void> {
  const DiagnosticScreenPageRoute({List<PageRouteInfo>? children})
      : super(
          DiagnosticScreenPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiagnosticScreenPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EmbeddedScreenPage1]
class EmbeddedScreenPage1Route
    extends PageRouteInfo<EmbeddedScreenPage1RouteArgs> {
  EmbeddedScreenPage1Route({
    required ConfigData data,
    List<PageRouteInfo>? children,
  }) : super(
          EmbeddedScreenPage1Route.name,
          args: EmbeddedScreenPage1RouteArgs(data: data),
          initialChildren: children,
        );

  static const String name = 'EmbeddedScreenPage1Route';

  static const PageInfo<EmbeddedScreenPage1RouteArgs> page =
      PageInfo<EmbeddedScreenPage1RouteArgs>(name);
}

class EmbeddedScreenPage1RouteArgs {
  const EmbeddedScreenPage1RouteArgs({required this.data});

  final ConfigData data;

  @override
  String toString() {
    return 'EmbeddedScreenPage1RouteArgs{data: $data}';
  }
}

/// generated route for
/// [EmbeddedScreenPage2]
class EmbeddedScreenPage2Route
    extends PageRouteInfo<EmbeddedScreenPage2RouteArgs> {
  EmbeddedScreenPage2Route({
    required ConfigData data,
    List<PageRouteInfo>? children,
  }) : super(
          EmbeddedScreenPage2Route.name,
          args: EmbeddedScreenPage2RouteArgs(data: data),
          initialChildren: children,
        );

  static const String name = 'EmbeddedScreenPage2Route';

  static const PageInfo<EmbeddedScreenPage2RouteArgs> page =
      PageInfo<EmbeddedScreenPage2RouteArgs>(name);
}

class EmbeddedScreenPage2RouteArgs {
  const EmbeddedScreenPage2RouteArgs({required this.data});

  final ConfigData data;

  @override
  String toString() {
    return 'EmbeddedScreenPage2RouteArgs{data: $data}';
  }
}

/// generated route for
/// [EmbeddedScreenPage3]
class EmbeddedScreenPage3Route
    extends PageRouteInfo<EmbeddedScreenPage3RouteArgs> {
  EmbeddedScreenPage3Route({
    required ConfigData data,
    List<PageRouteInfo>? children,
  }) : super(
          EmbeddedScreenPage3Route.name,
          args: EmbeddedScreenPage3RouteArgs(data: data),
          initialChildren: children,
        );

  static const String name = 'EmbeddedScreenPage3Route';

  static const PageInfo<EmbeddedScreenPage3RouteArgs> page =
      PageInfo<EmbeddedScreenPage3RouteArgs>(name);
}

class EmbeddedScreenPage3RouteArgs {
  const EmbeddedScreenPage3RouteArgs({required this.data});

  final ConfigData data;

  @override
  String toString() {
    return 'EmbeddedScreenPage3RouteArgs{data: $data}';
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

  static const PageInfo<ErrorDetailsScreenPageRouteArgs> page =
      PageInfo<ErrorDetailsScreenPageRouteArgs>(name);
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
/// [LoginEmbeddedScreenPage]
class LoginEmbeddedScreenPageRoute
    extends PageRouteInfo<LoginEmbeddedScreenPageRouteArgs> {
  LoginEmbeddedScreenPageRoute({
    required LoginEmbedded loginEmbedded,
    List<PageRouteInfo>? children,
  }) : super(
          LoginEmbeddedScreenPageRoute.name,
          args: LoginEmbeddedScreenPageRouteArgs(loginEmbedded: loginEmbedded),
          initialChildren: children,
        );

  static const String name = 'LoginEmbeddedScreenPageRoute';

  static const PageInfo<LoginEmbeddedScreenPageRouteArgs> page =
      PageInfo<LoginEmbeddedScreenPageRouteArgs>(name);
}

class LoginEmbeddedScreenPageRouteArgs {
  const LoginEmbeddedScreenPageRouteArgs({required this.loginEmbedded});

  final LoginEmbedded loginEmbedded;

  @override
  String toString() {
    return 'LoginEmbeddedScreenPageRouteArgs{loginEmbedded: $loginEmbedded}';
  }
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
class LoginRouterPageRoute extends PageRouteInfo<LoginRouterPageRouteArgs> {
  LoginRouterPageRoute({
    LoginEmbedded? launchLoginEmbedded,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRouterPageRoute.name,
          args: LoginRouterPageRouteArgs(
              launchLoginEmbedded: launchLoginEmbedded),
          initialChildren: children,
        );

  static const String name = 'LoginRouterPageRoute';

  static const PageInfo<LoginRouterPageRouteArgs> page =
      PageInfo<LoginRouterPageRouteArgs>(name);
}

class LoginRouterPageRouteArgs {
  const LoginRouterPageRouteArgs({this.launchLoginEmbedded});

  final LoginEmbedded? launchLoginEmbedded;

  @override
  String toString() {
    return 'LoginRouterPageRouteArgs{launchLoginEmbedded: $launchLoginEmbedded}';
  }
}

/// generated route for
/// [LoginSignupEmbeddedRequestScreenPage]
class LoginSignupEmbeddedRequestScreenPageRoute
    extends PageRouteInfo<LoginSignupEmbeddedRequestScreenPageRouteArgs> {
  LoginSignupEmbeddedRequestScreenPageRoute({
    required LoginEmbeddedModeButton embeddedData,
    List<PageRouteInfo>? children,
  }) : super(
          LoginSignupEmbeddedRequestScreenPageRoute.name,
          args: LoginSignupEmbeddedRequestScreenPageRouteArgs(
              embeddedData: embeddedData),
          initialChildren: children,
        );

  static const String name = 'LoginSignupEmbeddedRequestScreenPageRoute';

  static const PageInfo<LoginSignupEmbeddedRequestScreenPageRouteArgs> page =
      PageInfo<LoginSignupEmbeddedRequestScreenPageRouteArgs>(name);
}

class LoginSignupEmbeddedRequestScreenPageRouteArgs {
  const LoginSignupEmbeddedRequestScreenPageRouteArgs(
      {required this.embeddedData});

  final LoginEmbeddedModeButton embeddedData;

  @override
  String toString() {
    return 'LoginSignupEmbeddedRequestScreenPageRouteArgs{embeddedData: $embeddedData}';
  }
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
    required int callId,
    List<PageRouteInfo>? children,
  }) : super(
          RecentScreenPageRoute.name,
          args: RecentScreenPageRouteArgs(callId: callId),
          rawPathParams: {'callId': callId},
          initialChildren: children,
        );

  static const String name = 'RecentScreenPageRoute';

  static const PageInfo<RecentScreenPageRouteArgs> page =
      PageInfo<RecentScreenPageRouteArgs>(name);
}

class RecentScreenPageRouteArgs {
  const RecentScreenPageRouteArgs({required this.callId});

  final int callId;

  @override
  String toString() {
    return 'RecentScreenPageRouteArgs{callId: $callId}';
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
/// [SelfConfigScreenPage]
class SelfConfigScreenPageRoute
    extends PageRouteInfo<SelfConfigScreenPageRouteArgs> {
  SelfConfigScreenPageRoute({
    required Uri url,
    List<PageRouteInfo>? children,
  }) : super(
          SelfConfigScreenPageRoute.name,
          args: SelfConfigScreenPageRouteArgs(url: url),
          initialChildren: children,
        );

  static const String name = 'SelfConfigScreenPageRoute';

  static const PageInfo<SelfConfigScreenPageRouteArgs> page =
      PageInfo<SelfConfigScreenPageRouteArgs>(name);
}

class SelfConfigScreenPageRouteArgs {
  const SelfConfigScreenPageRouteArgs({required this.url});

  final Uri url;

  @override
  String toString() {
    return 'SelfConfigScreenPageRouteArgs{url: $url}';
  }
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
/// [SmsConversationScreenPage]
class SmsConversationScreenPageRoute
    extends PageRouteInfo<SmsConversationScreenPageRouteArgs> {
  SmsConversationScreenPageRoute({
    required String firstNumber,
    required String secondNumber,
    String? recipientId,
    List<PageRouteInfo>? children,
  }) : super(
          SmsConversationScreenPageRoute.name,
          args: SmsConversationScreenPageRouteArgs(
            firstNumber: firstNumber,
            secondNumber: secondNumber,
            recipientId: recipientId,
          ),
          initialChildren: children,
        );

  static const String name = 'SmsConversationScreenPageRoute';

  static const PageInfo<SmsConversationScreenPageRouteArgs> page =
      PageInfo<SmsConversationScreenPageRouteArgs>(name);
}

class SmsConversationScreenPageRouteArgs {
  const SmsConversationScreenPageRouteArgs({
    required this.firstNumber,
    required this.secondNumber,
    this.recipientId,
  });

  final String firstNumber;

  final String secondNumber;

  final String? recipientId;

  @override
  String toString() {
    return 'SmsConversationScreenPageRouteArgs{firstNumber: $firstNumber, secondNumber: $secondNumber, recipientId: $recipientId}';
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

  static const PageInfo<UndefinedScreenPageRouteArgs> page =
      PageInfo<UndefinedScreenPageRouteArgs>(name);
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

  static const PageInfo<void> page = PageInfo<void>(name);
}
