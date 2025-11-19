import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/theme/models/resource_loader.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/embedded_cubit.dart';
import '../utils/utils.dart';

import 'embedded_screen.dart';

final _logger = Logger('EmbeddedScreenPage');

@RoutePage()
class EmbeddedScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EmbeddedScreenPage({required this.data});

  final EmbeddedData data;

  @override
  Widget build(BuildContext context) {
    final selfConfigRepository = context.readOrNull<PrivateGatewayRepository>();
    final secureStorage = context.read<SecureStorage>();
    final cubit = _createCubit(selfConfigRepository, secureStorage);

    if (selfConfigRepository == null) {
      _logger.fine(
        'SelfConfigRepository not found in the widget tree; skipping all injections such as external page token',
      );
    }

    final resource = ResourceLoader.fromUri(data.uri.toString());

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
              ? BlocProvider(
                  create: (_) => cubit,
                  child: EmbeddedScreen(
                    initialUri: data.uri,
                    mediaQueryMetricsData: context.mediaQueryMetrics,
                    deviceInfoData: context.read<AppMetadataProvider>().build(),
                    appBar: _buildAppBar(context),
                    pageInjectionStrategyBuilder: () => _defaultPageInjectionStrategy(cubit.state.payload),
                    connectivityRecoveryStrategyBuilder: () => _createConnectivityRecoveryStrategy(data),
                    // TODO: Use embedded configuration option to enable/disable log capture.
                    enableLogCapture: true,
                  ),
                )
              : BlocProvider(
                  create: (_) => cubit,
                  child: EmbeddedScreen(
                    initialUri: Uri.dataFromString(
                      content,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'),
                    ),
                    mediaQueryMetricsData: context.mediaQueryMetrics,
                    deviceInfoData: context.read<AppMetadataProvider>().build(),
                    appBar: _buildAppBar(context),
                    pageInjectionStrategyBuilder: () => _defaultPageInjectionStrategy(cubit.state.payload),
                    connectivityRecoveryStrategyBuilder: () => _createConnectivityRecoveryStrategy(data),
                    // TODO: Use embedded configuration option to enable/disable log capture.
                    enableLogCapture: true,
                  ),
                );
        } else {
          return const Center(child: Text('Unexpected error occurred.'));
        }
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final title = data.titleL10n;
    return AppBar(leading: const AutoLeadingButton(), title: title != null ? Text(context.parseL10n(title)) : null);
  }

  EmbeddedCubit _createCubit(PrivateGatewayRepository? selfConfigRepository, SecureStorage secureStorage) {
    return EmbeddedCubit(
      customPrivateGatewayRepository: selfConfigRepository,
      embeddedPayloadBuilder: EmbeddedPayloadBuilder(secureStorage),
      payload: data.payload,
    );
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
