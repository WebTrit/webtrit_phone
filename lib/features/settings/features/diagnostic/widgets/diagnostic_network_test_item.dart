import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
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

        // An anchor, not a merged control: this row holds two things to press -
        // itself, which opens the details, and the button that runs the check
        // again. Merging them would leave one node and hide the button.
        return SemanticId(
          identifier: diagnosticNetworkTestId,
          child: ListTile(
            onTap: onTap,
            title: Row(
              children: [
                // Flexible so a long status at large text sizes ellipsizes
                // instead of pushing the button off the row.
                Flexible(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis)),
                const SizedBox(width: 4),
                // One slot of the same size in both states: the check swaps a
                // spinner for a button, and a slot that changes size makes the
                // row - and the list under it - jump on every re-test.
                SizedBox.square(
                  dimension: kMinInteractiveDimension,
                  child: gathering
                      ? const Center(
                          child: SizedBox.square(dimension: 12, child: CircularProgressIndicator(strokeWidth: 3)),
                        )
                      // A button rather than a bare gesture area: the icon is 16
                      // pixels across, so the thing to press was a third of the
                      // size a finger needs, and it offered no ripple to say it
                      // was one.
                      : SemanticAction(
                          label: l10n.diagnosticNetworkTest_SemanticsLabel_refresh,
                          identifier: diagnosticNetworkTestRefreshId,
                          child: IconButton(
                            onPressed: () => context.read<NetworkTesterCubit>().refresh(),
                            icon: const Icon(Icons.refresh, size: 16),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                ),
              ],
            ),
            subtitle: Text(subtitleParts.join(' · ')),
            trailing: Icon(icon, color: color),
          ),
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
