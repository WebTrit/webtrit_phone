import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/embedded/embedded_data.dart';
import 'package:webtrit_phone/models/embedded/embedded_payload_data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../utils/utils.dart';
import '../bloc/embedded_cubit.dart';

import 'embedded_screen.dart';

@RoutePage()
class EmbeddedTabPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EmbeddedTabPage({
    @PathParam('id') required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final bottomMenuManager = context.read<FeatureAccess>().bottomMenuFeature;
    final data = bottomMenuManager.getEmbeddedTabById(id);

    final customPrivateGatewayRepository = context.read<PrivateGatewayRepository>();
    final secureStorage = context.read<SecureStorage>();

    final tabsRouter = AutoTabsRouter.of(context);

    return BlocProvider(
      create: (context) => _createCubit(data.data!.payload, customPrivateGatewayRepository, secureStorage),
      child: AnimatedBuilder(
        animation: tabsRouter,
        builder: (context, child) {
          final tabActive = tabsRouter.isRouteDataActive(RouteData.of(context));

          return EmbeddedScreen(
            initialUri: data.data!.uri,
            enableLogCapture: data.data?.enableConsoleLogCapture ?? false,
            appBar: _buildAppBar(context, data.titleL10n),
            pageInjectionStrategyBuilder: _defaultPageInjectionStrategy,
            connectivityRecoveryStrategyBuilder: () => _createConnectivityRecoveryStrategy(data.data!),
            shouldForwardPop: tabActive,
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
    return MainAppBar(
      title: Text(context.parseL10n(titleL10n)),
      context: context,
    );
  }

  PageInjectionStrategy _defaultPageInjectionStrategy() {
    return DefaultPayloadInjectionStrategy();
  }

  ConnectivityRecoveryStrategy _createConnectivityRecoveryStrategy(EmbeddedData data) {
    return ConnectivityRecoveryStrategy.create(
      initialUri: data.uri,
      type: data.reconnectStrategy,
      connectivityStream: Connectivity().onConnectivityChanged,
      connectivityCheckerBuilder: () => const DefaultConnectivityChecker(
        connectivityCheckUrl: EnvironmentConfig.CONNECTIVITY_CHECK_URL,
      ),
    );
  }
}
