import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import '../models/models.dart';
import 'diagnostic_screen.dart';

@RoutePage()
class DiagnosticScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const DiagnosticScreenPage();

  @override
  Widget build(BuildContext context) {
    final pushTokensBloc = context.read<PushTokensBloc>();
    final featureAccess = context.read<FeatureAccess>();

    final contactTab = featureAccess.bottomMenuFeature.getTabEnabled(MainFlavor.contacts)?.toContacts;

    final screenContext = DiagnosticScreenContext(
      isLocalContactsFeatureEnabled: contactTab?.contactSourceTypes.contains(ContactSourceType.local) ?? false,
    );

    return BlocProvider<DiagnosticCubit>(
      create: (context) => DiagnosticCubit(
        pushTokensBloc: pushTokensBloc,
        appPermissions: AppPermissions(),
      ),
      child: Provider<DiagnosticScreenContext>(
        create: (context) => screenContext,
        child: const DiagnosticScreen(),
      ),
    );
  }
}
