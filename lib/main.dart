import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/simple_bloc_observer.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/pages/main.dart';
import 'package:webtrit_phone/pages/call.dart';
import 'package:webtrit_phone/pages/settings.dart';
import 'package:webtrit_phone/pages/web_registration.dart';
import 'package:webtrit_phone/environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DeviceInfo.init();
  await PackageInfo.init();

  final assetManifestJson = await rootBundle.loadString('AssetManifest.json');
  final assetManifest = jsonDecode(assetManifestJson) as Map<String, dynamic>;
  await Future.wait(
    assetManifest.keys.where((String key) => key.endsWith('.svg')).map(
          (assetName) => precachePicture(
            ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, assetName),
            null,
          ),
        ),
  );

  PrintAppender.setupLogging(level: Level.LEVELS.firstWhere((level) => level.name == EnvironmentConfig.DEBUG_LEVEL));

  final logRecordsRepository = LogRecordsRepository()..attachToLogger(Logger.root);

  Bloc.observer = SimpleBlocObserver();

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(
        value: logRecordsRepository,
      ),
      RepositoryProvider<WebtritApiClient>(
        create: (context) => WebtritApiClient(Uri.parse(EnvironmentConfig.WEBTRIT_CORE_URL)),
      ),
      RepositoryProvider<CallRepository>(
        create: (context) => CallRepository(),
      ),
      RepositoryProvider<RecentsRepository>(
        create: (context) => RecentsRepository(),
      ),
      RepositoryProvider<LocalContactsRepository>(
        create: (context) => LocalContactsRepository(),
      ),
      RepositoryProvider<ExternalContactsRepository>(
        create: (context) => ExternalContactsRepository(
          webtritApiClient: context.read<WebtritApiClient>(),
          periodicPolling: EnvironmentConfig.PERIODIC_POLLING,
        ),
      ),
      RepositoryProvider<AccountInfoRepository>(
        create: (context) => AccountInfoRepository(
          webtritApiClient: context.read<WebtritApiClient>(),
        ),
      ),
    ],
    child: BlocProvider<AppBloc>(
      create: (context) {
        return AppBloc();
      },
      child: App(
        webRegistrationInitialUrl: await SecureStorage().readWebRegistrationInitialUrl(),
        isRegistered: await SecureStorage().readToken() != null,
      ),
    ),
  ));
}

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.webRegistrationInitialUrl,
    required this.isRegistered,
  }) : super(key: key);

  final String? webRegistrationInitialUrl;
  final bool isRegistered;

  String _initialRoute(String? webRegistrationInitialUrl, bool isRegistered) => isRegistered
      ? '/main'
      : webRegistrationInitialUrl == null
          ? '/login'
          : '/web-registration';

  @override
  Widget build(BuildContext context) {
    setDefaultOrientations();

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'WebTrit Phone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: _initialRoute(webRegistrationInitialUrl, isRegistered),
      builder: (BuildContext context, Widget? child) {
        final themeData = Theme.of(context);
        return Theme(
          data: themeData.copyWith(
            appBarTheme: AppBarTheme(
              color: themeData.canvasColor,
              iconTheme: IconThemeData(
                color: themeData.textTheme.caption!.color,
              ),
              actionsIconTheme: IconThemeData(
                color: themeData.textTheme.caption!.color,
              ),
              titleTextStyle: themeData.primaryTextTheme.headline6!.copyWith(
                color: themeData.accentColor,
                fontWeight: FontWeight.bold,
              ),
              centerTitle: false,
            ),
          ),
          child: child ?? Container(),
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        Widget page;
        switch (settings.name) {
          case '/login':
            page = const LoginPage();
            break;
          case '/web-registration':
            page = WebRegistrationPage(
              initialUrl: settings.arguments != null ? settings.arguments as String : webRegistrationInitialUrl!,
            );
            break;
          case '/main':
            page = MultiBlocProvider(
              providers: [
                BlocProvider<RecentsBloc>(
                  create: (context) {
                    return RecentsBloc(
                      recentsRepository: context.read<RecentsRepository>(),
                    )..add(const RecentsInitialLoaded());
                  },
                ),
                BlocProvider<LocalContactsBloc>(
                  create: (context) {
                    return LocalContactsBloc(
                      localContactsRepository: context.read<LocalContactsRepository>(),
                    )..add(const LocalContactsInitialLoaded());
                  },
                ),
                BlocProvider<ExternalContactsBloc>(
                  create: (context) {
                    return ExternalContactsBloc(
                      externalContactsRepository: context.read<ExternalContactsRepository>(),
                    )..add(const ExternalContactsInitialLoaded());
                  },
                ),
                BlocProvider<CallBloc>(
                  create: (context) {
                    return CallBloc(
                      callRepository: context.read<CallRepository>(),
                      appBloc: context.read<AppBloc>(),
                      recentsBloc: context.read<RecentsBloc>(),
                    )..add(const CallAttached());
                  },
                ),
              ],
              child: BlocListener<CallBloc, CallState>(
                listenWhen: (previous, current) => previous.runtimeType != current.runtimeType,
                listener: (context, state) {
                  if (state is CallActive) {
                    setCallOrientations().then((_) {
                      Navigator.pushNamed(context, '/main/call',
                          arguments: CallNavigationArguments(
                            callBloc: context.read<CallBloc>(),
                          ));
                    });
                  }
                  if (state is CallIdle && Navigator.canPop(context)) {
                    // TODO canPop must be removed by reorganise states
                    setDefaultOrientations().then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: const MainPage(),
              ),
            );
            break;
          case '/main/call':
            final callNavigationArguments = settings.arguments as CallNavigationArguments;
            page = BlocProvider<CallBloc>.value(
              value: callNavigationArguments.callBloc,
              child: const CallPage(),
            );
            break;
          case '/main/settings':
            page = const SettingsPage();
            break;
          case '/main/log-records-console':
            page = const LogRecordsConsolePage();
            break;
          default:
            return null;
        }

        if ('/'.allMatches(settings.name!).length <= 1) {
          // add listener only to top level page
          page = BlocListener<AppBloc, AppState>(
            listener: (context, state) async {
              if (state is AppUnregister) {
                final webRegistrationInitialUrl = await SecureStorage().readWebRegistrationInitialUrl();
                final isRegistered = await SecureStorage().readToken() != null;

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  _initialRoute(webRegistrationInitialUrl, isRegistered),
                  (route) => false,
                  arguments: webRegistrationInitialUrl,
                );
              }
            },
            child: page,
          );
        }

        switch (settings.name) {
          case '/main/call':
            return PageRouteBuilder(
              fullscreenDialog: true,
              settings: settings,
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                return page;
              },
              transitionsBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation, Widget child) {
                const builder = ZoomPageTransitionsBuilder();
                return builder.buildTransitions(null, context, animation, secondaryAnimation, child);
              },
            );
          default:
            return MaterialPageRoute(
              fullscreenDialog: true,
              settings: settings,
              builder: (BuildContext context) => page,
            );
        }
      },
    );
  }
}

Future<void> setDefaultOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> setCallOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

class CallNavigationArguments {
  final CallBloc callBloc;

  CallNavigationArguments({
    required this.callBloc,
  });
}
