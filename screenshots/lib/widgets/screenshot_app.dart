import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:auto_route/auto_route.dart';
import 'package:mocktail/mocktail.dart';

// TODO(ScreenshotApp): Remove this import after fixing this bug https://github.com/Milad-Akarie/auto_route_library/issues/1806
// ignore: implementation_imports, depend_on_referenced_packages
import 'package:auto_route/src/router/controller/pageless_routes_observer.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

class ScreenshotApp extends StatelessWidget {
  const ScreenshotApp({
    super.key,
    required this.appBloc,
    required this.child,
  });

  final AppBloc appBloc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget widgetsApp = BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.themeSettings != current.themeSettings,
      builder: (context, state) {
        return ThemeProvider(
          settings: state.themeSettings,
          lightDynamic: null,
          darkDynamic: null,
          child: BlocBuilder<AppBloc, AppState>(
            buildWhen: (previous, current) =>
            previous.effectiveLocale != current.effectiveLocale ||
                previous.effectiveThemeMode != current.effectiveThemeMode,
            builder: (context, state) {
              final themeProvider = ThemeProvider.of(context);

              return WidgetsApp.router(
                locale: state.effectiveLocale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                title: EnvironmentConfig.APP_NAME,
                color: themeProvider.light()!.primaryColor,
                debugShowCheckedModeBanner: false,
                routerDelegate: ScreenshotRouterDelegate(child),
                routeInformationParser: const _NoOpRouteInformationParser(),
                builder: (context, child) {
                  // Ensure themes are applied to the app
                  return Theme(
                    data: themeProvider.light()!,
                    child: child!,
                  );
                },
              );
            },
          ),
        );
      },
    );

    widgetsApp = IgnorePointer(
      child: widgetsApp,
    );

    final provider = MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>.value(
          value: appBloc,
        ),
      ],
      child: _autoStackRouterWrap(widgetsApp),
    );

    return provider;
  }
}

class ScreenshotRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  ScreenshotRouterDelegate(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          child: child,
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        // Notify listeners if necessary
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(Object configuration) async {
    // You can handle any route configuration logic here if needed.
    return;
  }

  @override
  Future<bool> popRoute() async {
    // Prevent navigation stack popping
    return false;
  }
}

class _NoOpRouteInformationParser extends RouteInformationParser<Object> {
  const _NoOpRouteInformationParser();

  @override
  Future<Object> parseRouteInformation(RouteInformation routeInformation) async {
    return Object();
  }
}

//  Mock auto_route router stack
//  Needed for invocation AutoRoute.of and other platform dependent code inside test widget
class _AutoStackRouter extends Mock implements StackRouter {
  @override
  PagelessRoutesObserver pagelessRoutesObserver = PagelessRoutesObserver();

  @override
  bool canPop({bool ignoreChildRoutes = false, bool ignoreParentRoutes = false, bool ignorePagelessRoutes = false}) {
    return true;
  }
}

Widget _autoStackRouterWrap(Widget child) {
  return RouterScope(
    controller: _AutoStackRouter(),
    stateHash: 0,
    inheritableObserversBuilder: () => [],
    child: StackRouterScope(controller: _AutoStackRouter(), stateHash: 0, child: child),
  );
}
