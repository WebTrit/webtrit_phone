import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../bloc/network_tester_cubit.dart';

class DiagnosticNetworkTestDetails extends StatelessWidget {
  const DiagnosticNetworkTestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NetworkTesterCubit>().state;

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final gathering = state.gatheringStatus == IceGatheringStatus.gathering;
    final offline = state.networks.isEmpty || state.networks.every((n) => n == ConnectivityResult.none);
    final effective = state.effectiveCandidates.toList();
    final srflx = effective.where((c) => c.type == IceType.srflx).toList();
    final relay = effective.where((c) => c.type == IceType.relay).toList();
    final host = effective.where((c) => c.type == IceType.host).toList();

    final l10n = context.l10n;

    final (statusTitle, statusIcon, statusColor) = switch (null) {
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

    return BlocBuilder<NetworkTesterCubit, NetworkTesterState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(l10n.diagnosticNetworkTestDetails_title),
                subtitle: Text(l10n.diagnosticNetworkTestDetails_description),
                titleTextStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                subtitleTextStyle: textTheme.bodySmall,
              ),
              ListTile(
                title: Text(l10n.diagnosticNetworkTestDetails_status),
                subtitle: Text(statusTitle, style: textTheme.bodyMedium?.copyWith(color: statusColor)),
                trailing: Icon(statusIcon, color: statusColor),
              ),
              if (effective.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Text(
                    l10n.diagnosticNetworkTestDetails_candidates,
                    style: textTheme.labelMedium?.copyWith(color: colorScheme.outline),
                  ),
                ),
                ...effective.map((c) => _CandidateTile(candidate: c)),
              ] else if (!gathering)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    offline
                        ? l10n.diagnosticNetworkTestDetails_noNetwork
                        : l10n.diagnosticNetworkTestDetails_noCandidates,
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _CandidateTile extends StatelessWidget {
  const _CandidateTile({required this.candidate});

  final CandidateInfo candidate;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final typeColor = switch (candidate.type) {
      IceType.srflx => Colors.green,
      IceType.relay => Colors.orange,
      IceType.host => colorScheme.primary,
      _ => colorScheme.outline,
    };

    final transportLabel = candidate.transport == IceTransport.tcp && candidate.protocol.isNotEmpty
        ? 'TCP/${candidate.protocol}'
        : candidate.transport.name.toUpperCase();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: typeColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(4)),
            child: Text(candidate.type.name, style: textTheme.labelSmall?.copyWith(color: typeColor)),
          ),
          const SizedBox(width: 8),
          Text(transportLabel, style: textTheme.bodySmall?.copyWith(color: colorScheme.outline)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${candidate.address}:${candidate.port}',
              style: textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
