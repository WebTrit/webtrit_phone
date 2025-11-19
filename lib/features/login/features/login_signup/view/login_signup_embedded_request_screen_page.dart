import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/data/data.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'login_signup_embedded_request_screen.dart';

@RoutePage()
class LoginSignupEmbeddedRequestScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSignupEmbeddedRequestScreenPage(this.embeddedData);

  final EmbeddedData embeddedData;

  @override
  Widget build(BuildContext context) {
    // TODO(Serdun): Implement directly in LoginEmbedded
    final resource = ResourceLoader.fromUri(embeddedData.uri.toString());

    final locale = Localizations.localeOf(context);

    return FutureBuilder<String>(
      future: resource.loadContent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load content: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final content = snapshot.data!;
          return resource is NetworkResourceLoader
              ? LoginSignupEmbeddedRequestScreen(
                  initialUrl: Uri.parse(content),
                  mediaQueryMetricsData: context.mediaQueryMetrics,
                  deviceInfoData: context.read<AppMetadataProvider>().logLabels,
                  pageInjectionStrategyBuilder: _createInjectionStrategy(locale),
                  connectivityRecoveryStrategyBuilder: () => _createConnectivityRecoveryStrategy(embeddedData),
                )
              : LoginSignupEmbeddedRequestScreen(
                  initialUrl: Uri.dataFromString(content, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')),
                  mediaQueryMetricsData: context.mediaQueryMetrics,
                  deviceInfoData: context.read<AppMetadataProvider>().logLabels,
                  pageInjectionStrategyBuilder: _createInjectionStrategy(locale),
                  connectivityRecoveryStrategyBuilder: () => _createConnectivityRecoveryStrategy(embeddedData),
                );
        } else {
          return const Center(child: Text('Unexpected error occurred.'));
        }
      },
    );
  }

  PageInjectionStrategyBuilder _createInjectionStrategy(Locale locale) {
    return () => DefaultPayloadInjectionStrategy(
      functionName: 'initializePage',
      initialPayload: {'locale': locale.languageCode},
    );
  }

  ConnectivityRecoveryStrategy _createConnectivityRecoveryStrategy(EmbeddedData data) {
    return ConnectivityRecoveryStrategy.create(
      initialUri: data.uri,
      type: data.reconnectStrategy,
      connectivityStream: Connectivity().onConnectivityChanged,
      connectivityCheckerBuilder: () =>
          const DefaultConnectivityChecker(connectivityCheckUrl: EnvironmentConfig.CONNECTIVITY_CHECK_URL),
    );
  }
}
