import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/embedded/embedded_data.dart';
import 'package:webtrit_phone/models/embedded/embedded_payload_data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/models/resource_loader.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../utils/utils.dart';
import '../bloc/embedded_cubit.dart';

import 'embedded_screen.dart';

@RoutePage()
class EmbeddedTabPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EmbeddedTabPage({@PathParam('id') required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final bottomMenuManager = context.read<FeatureAccess>().bottomMenuFeature;
    final data = bottomMenuManager.getEmbeddedTabById(id);

    final customPrivateGatewayRepository = context.read<PrivateGatewayRepository>();
    final secureStorage = context.read<SecureStorage>();
    final cubit = _createCubit(data.data!.payload, customPrivateGatewayRepository, secureStorage);

    final tabsRouter = AutoTabsRouter.of(context);

    final resource = ResourceLoader.fromUri(data.data!.uri.toString());

    return BlocProvider(
      create: (context) => cubit,
      child: AnimatedBuilder(
        animation: tabsRouter,
        builder: (context, child) {
          final tabActive = tabsRouter.isRouteDataActive(RouteData.of(context));

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
                    ? EmbeddedScreen(
                        initialUri: data.data!.uri,
                        mediaQueryMetricsData: context.mediaQueryMetrics,
                        deviceInfoData: context.read<AppMetadataProvider>().logLabels,
                        appBar: _buildAppBar(context, data.titleL10n),
                        pageInjectionStrategyBuilder: () => _defaultPageInjectionStrategy(cubit.state.payload),
                        connectivityRecoveryStrategyBuilder: () => _createConnectivityRecoveryStrategy(data.data!),
                        shouldForwardPop: tabActive,
                        // TODO: Use embedded configuration option to enable/disable log capture.
                        enableLogCapture: true,
                      )
                    : EmbeddedScreen(
                        initialUri: Uri.dataFromString(
                          content,
                          mimeType: 'text/html',
                          encoding: Encoding.getByName('utf-8'),
                        ),
                        mediaQueryMetricsData: context.mediaQueryMetrics,
                        deviceInfoData: context.read<AppMetadataProvider>().logLabels,
                        appBar: _buildAppBar(context, data.titleL10n),
                        pageInjectionStrategyBuilder: () => _defaultPageInjectionStrategy(cubit.state.payload),
                        connectivityRecoveryStrategyBuilder: () => _createConnectivityRecoveryStrategy(data.data!),
                        shouldForwardPop: tabActive,
                        // TODO: Use embedded configuration option to enable/disable log capture.
                        enableLogCapture: true,
                      );
              } else {
                return const Center(child: Text('Unexpected error occurred.'));
              }
            },
          );
        },
      ),
    );
  }

  EmbeddedCubit _createCubit(
    List<EmbeddedPayloadData> payload,
    PrivateGatewayRepository customPrivateGatewayRepository,
    SecureStorage secureStorage,
  ) {
    final embeddedPayloadBuilder = EmbeddedPayloadBuilder(secureStorage);

    return EmbeddedCubit(
      payload: payload,
      customPrivateGatewayRepository: customPrivateGatewayRepository,
      embeddedPayloadBuilder: embeddedPayloadBuilder,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String titleL10n) {
    return MainAppBar(title: Text(context.parseL10n(titleL10n)), context: context);
  }

  PageInjectionStrategy _defaultPageInjectionStrategy(Map<String, dynamic>? payload) {
    return DefaultPayloadInjectionStrategy(initialPayload: payload);
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
