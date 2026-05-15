import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../bloc/network_tester_cubit.dart';

class DiagnosticNetworkTestItem extends StatelessWidget {
  const DiagnosticNetworkTestItem({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkTesterCubit, NetworkTesterState>(
      builder: (context, state) {
        final gathering = state.gatheringStatus == IceGatheringStatus.gathering;
        final offline = state.networks.isEmpty || state.networks.every((n) => n == ConnectivityResult.none);
        final effective = state.effectiveCandidates.toList();
        final srflx = effective.where((c) => c.type == IceType.srflx).toList();
        final relay = effective.where((c) => c.type == IceType.relay).toList();
        final host = effective.where((c) => c.type == IceType.host).toList();

        final publicIps = srflx.map((c) => c.address).toSet().join(', ');

        final l10n = context.l10n;

        final networkLabel = state.networks
            .where((n) => n != ConnectivityResult.none)
            .map((r) => _networkLabel(r, l10n))
            .toSet()
            .join(', ');

        final (title, icon, color) = switch (null) {
          _ when offline => (l10n.diagnosticNetworkTest_status_offline, Icons.signal_wifi_off, Colors.red),
          _ when srflx.isNotEmpty => (l10n.diagnosticNetworkTest_status_reachable, Icons.check_circle, Colors.green),
          _ when relay.isNotEmpty => (
            l10n.diagnosticNetworkTest_status_restricted,
            Icons.warning_amber_rounded,
            Colors.orange,
          ),
          _ when host.isNotEmpty => (
            l10n.diagnosticNetworkTest_status_restricted,
            Icons.warning_amber_rounded,
            Colors.orange,
          ),
          _ when gathering => (l10n.diagnosticNetworkTest_status_checking, Icons.pending_outlined, Colors.grey),
          _ => (l10n.diagnosticNetworkTest_status_unreachable, Icons.error_outline, Colors.red),
        };

        final subtitleParts = [
          if (networkLabel.isNotEmpty) networkLabel,
          if (offline)
            l10n.diagnosticNetworkTestItem_subtitle_noNetwork
          else if (srflx.isNotEmpty)
            l10n.diagnosticNetworkTestItem_subtitle_publicIps(publicIps)
          else if (relay.isNotEmpty)
            l10n.diagnosticNetworkTestItem_subtitle_stunBlocked
          else if (host.isNotEmpty)
            l10n.diagnosticNetworkTestItem_subtitle_stunUnreachable
          else if (!gathering)
            l10n.diagnosticNetworkTestItem_subtitle_noCandidates,
        ];

        return ListTile(
          onTap: onTap,
          title: Row(
            children: [
              Text(title),
              const SizedBox(width: 4),
              if (gathering)
                const SizedBox.square(dimension: 12, child: CircularProgressIndicator(strokeWidth: 3))
              else
                GestureDetector(
                  onTap: () => context.read<NetworkTesterCubit>().refresh(),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey.withAlpha(1)),
                    child: const Icon(Icons.refresh, size: 16),
                  ),
                ),
            ],
          ),
          subtitle: Text(subtitleParts.join(' · ')),
          trailing: Icon(icon, color: color),
        );
      },
    );
  }

  static String _networkLabel(ConnectivityResult r, AppLocalizations l10n) => switch (r) {
    ConnectivityResult.wifi => l10n.diagnosticNetworkTestItem_network_wifi,
    ConnectivityResult.mobile => l10n.diagnosticNetworkTestItem_network_mobile,
    ConnectivityResult.ethernet => l10n.diagnosticNetworkTestItem_network_ethernet,
    ConnectivityResult.vpn => l10n.diagnosticNetworkTestItem_network_vpn,
    _ => r.name,
  };
}
