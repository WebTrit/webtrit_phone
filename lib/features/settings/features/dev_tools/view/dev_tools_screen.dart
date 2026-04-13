import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart' show WebtritSignalingService;

import 'package:webtrit_phone/l10n/l10n.dart';

import '../../../widgets/widgets.dart';

class DevToolsScreen extends StatelessWidget {
  const DevToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const AutoLeadingButton(), title: Text(context.l10n.devTools_AppBarTitle)),
      body: ListView(
        children: [
          GroupTitleListTile(titleData: context.l10n.devTools_signalingService_groupTitle),
          ListTile(
            title: Text(context.l10n.devTools_signalingService_simulateKill_title),
            subtitle: Text(context.l10n.devTools_signalingService_simulateKill_subtitle),
            trailing: const Icon(Icons.stop_circle_outlined),
            onTap: () => _confirmSimulateKill(context),
          ),
        ],
      ),
    );
  }

  void _confirmSimulateKill(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.devTools_signalingService_simulateKill_title),
        content: Text(context.l10n.devTools_signalingService_simulateKill_confirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(context.l10n.devTools_signalingService_simulateKill_cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              WebtritSignalingService.simulateKill();
            },
            child: Text(context.l10n.devTools_signalingService_simulateKill_confirm),
          ),
        ],
      ),
    );
  }
}
