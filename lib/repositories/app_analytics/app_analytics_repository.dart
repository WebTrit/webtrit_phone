import 'package:flutter/widgets.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalyticsRepository {
  AppAnalyticsRepository({required FirebaseAnalytics instance}) : _instance = instance;

  final FirebaseAnalytics _instance;

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
