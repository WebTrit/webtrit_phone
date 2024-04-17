import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class AutoprovisionScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AutoprovisionScreenPage({
    @QueryParam('config_token') this.configToken,
    @QueryParam('tenant_id') this.tenantId,
  });
  final String? configToken;
  final String? tenantId;

  @override
  Widget build(BuildContext context) {
    // Explicitly cast to string,
    // coz value are verified by the router guard [onAutoprovisionScreenPageRouteGuardNavigation]
    final configToken = this.configToken!;
    final tenantId = this.tenantId ?? '';

    /// Check if user is logged in already
    final loggedIn = context.read<AppBloc>().state.token != null;

    final widget = BlocProvider(
      create: (context) => AutoprovisionCubit(configToken, tenantId, loggedIn),
      child: const AutoprovisionScreen(),
    );

    return widget;
  }
}
