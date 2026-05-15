import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

        final networkLabel = state.networks
            .where((n) => n != ConnectivityResult.none)
            .map(_networkLabel)
            .toSet()
            .join(', ');

        final (title, icon, color) = switch (null) {
          _ when offline => ('Offline', Icons.signal_wifi_off, Colors.red),
          _ when srflx.isNotEmpty => ('Reachable', Icons.check_circle, Colors.green),
          _ when relay.isNotEmpty => ('Restricted', Icons.warning_amber_rounded, Colors.orange),
          _ when host.isNotEmpty => ('Restricted', Icons.warning_amber_rounded, Colors.orange),
          _ when gathering => ('Checking…', Icons.pending_outlined, Colors.grey),
          _ => ('Unreachable', Icons.error_outline, Colors.red),
        };

        final subtitleParts = [
          if (networkLabel.isNotEmpty) networkLabel,
          if (offline)
            'No network connection'
          else if (srflx.isNotEmpty)
            'Public: $publicIps'
          else if (relay.isNotEmpty)
            'STUN blocked · relay available'
          else if (host.isNotEmpty)
            'STUN unreachable · local only'
          else if (!gathering)
            'No ICE candidates gathered',
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
                    color: Colors.red,
                    padding: const EdgeInsets.all(4),
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

  static String _networkLabel(ConnectivityResult r) => switch (r) {
    ConnectivityResult.wifi => 'WiFi',
    ConnectivityResult.mobile => 'Mobile',
    ConnectivityResult.ethernet => 'Ethernet',
    ConnectivityResult.vpn => 'VPN',
    _ => r.name,
  };
}
