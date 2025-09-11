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
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/embedded_cubit.dart';
import '../utils/utils.dart';

import 'embedded_screen.dart';

final _logger = Logger('EmbeddedScreenPage');

@RoutePage()
class EmbeddedScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EmbeddedScreenPage({
    required this.data,
  });

  final EmbeddedData data;

  @override
  Widget build(BuildContext context) {
    final selfConfigRepository = context.readOrNull<PrivateGatewayRepository>();
    final secureStorage = context.read<SecureStorage>();

    if (selfConfigRepository == null) {
      _logger.fine(
          'SelfConfigRepository not found in the widget tree; skipping all injections such as external page token');
    }

    return BlocProvider(
      create: (_) => _createCubit(selfConfigRepository, secureStorage),
      child: EmbeddedScreen(
        initialUri: data.uri,
        enableLogCapture: data.enableConsoleLogCapture,
        appBar: _buildAppBar(context),
        pageInjectionStrategyBuilder: _defaultPageInjectionStrategy,
        connectivityRecoveryStrategyBuilder: () => _createConnectivityRecoveryStrategy(data),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: const AutoLeadingButton(),
      title: Text(context.parseL10n(data.titleL10n!)),
    );
  }

  EmbeddedCubit _createCubit(
    PrivateGatewayRepository? selfConfigRepository,
    SecureStorage secureStorage,
  ) {
    return EmbeddedCubit(
      customPrivateGatewayRepository: selfConfigRepository,
      embeddedPayloadBuilder: EmbeddedPayloadBuilder(secureStorage),
      payload: data.payload,
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
