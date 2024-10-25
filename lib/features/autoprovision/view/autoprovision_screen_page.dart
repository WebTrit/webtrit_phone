import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

import '../models/models.dart';

@RoutePage()
class AutoprovisionScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AutoprovisionScreenPage({
    @QueryParam('config_token') this.configToken,
    @QueryParam('tenant_id') this.tenantId,
    @QueryParam('core') this.coreUrl,
  });

  final String? configToken;
  final String? tenantId;
  final String? coreUrl;

  @override
  Widget build(BuildContext context) {
    // Explicitly cast to string,
    // coz value are verified by the router guard [onAutoprovisionScreenPageRouteGuardNavigation]
    final configToken = this.configToken!;
    final oldToken = context.read<AppBloc>().state.token;

    final tenantId = this.tenantId ?? '';
    final oldTenant = context.read<AppBloc>().state.tenantId ?? '';

    const defaultCoreUrl = EnvironmentConfig.CORE_URL ?? EnvironmentConfig.DEMO_CORE_URL;
    final coreUrl = this.coreUrl;
    final oldCoreUrl = context.read<AppBloc>().state.coreUrl ?? defaultCoreUrl;

    final widget = BlocProvider(
      create: (context) => AutoprovisionCubit(AutoprovisionConfig(
        configToken: configToken,
        oldToken: oldToken,
        tenantId: tenantId,
        oldTenantId: oldTenant,
        coreUrl: coreUrl ?? oldCoreUrl,
        oldCoreUrl: oldCoreUrl,
      )),
      child: const AutoprovisionScreen(),
    );

    return widget;
  }
}
