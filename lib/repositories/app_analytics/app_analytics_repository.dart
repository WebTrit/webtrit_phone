import 'package:flutter/widgets.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

/// Source of the navigator observer used to report screen views to analytics.
abstract interface class AppAnalyticsRepository {
  NavigatorObserver createObserver();
}

/// Firebase Analytics-backed implementation.
class FirebaseAppAnalyticsRepository implements AppAnalyticsRepository {
  FirebaseAppAnalyticsRepository({FirebaseAnalytics? instance}) : _instance = instance ?? FirebaseAnalytics.instance;

  final FirebaseAnalytics _instance;

  @override
  NavigatorObserver createObserver() {
    return FirebaseAnalyticsObserver(
      analytics: _instance,
      nameExtractor: (settings) {
        final routeSettingsName = settings.name;
        if (routeSettingsName == null) {
          return null;
        } else {
          final routeSettingsArguments = settings.arguments;
          if (routeSettingsArguments is! Map<String, dynamic>) {
            return routeSettingsName;
          } else {
            return Uri.parse(routeSettingsName).replace(queryParameters: routeSettingsArguments).toString();
          }
        }
      },
    );
  }
}

/// No-op implementation for builds that run without Firebase (e.g. embedded in a
/// host that owns the default Firebase app). Attaches a plain observer that
/// records nothing, so consumers need no Firebase-aware branching.
class NoopAppAnalyticsRepository implements AppAnalyticsRepository {
  const NoopAppAnalyticsRepository();

  @override
  NavigatorObserver createObserver() => NavigatorObserver();
}
