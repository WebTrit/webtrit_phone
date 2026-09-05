import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/adapters/polling_on_demand_refresher.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/services/services.dart';

/// Port adapters: the layer that hands consumers their domain-facing ports,
/// each backed by a service from the layer above (see
/// `docs/ports_and_adapters.md`).
///
/// A provider here registers the narrow per-source port type, never the
/// shared base contract, and carries the same feature gate as the capability
/// it exposes - so a consumer can only obtain a port that actually works in
/// this session. When no port applies, the layer steps aside entirely: a
/// provider list here must never end up empty (an empty MultiProvider
/// asserts), so each gated port returns the bare child instead.
class MainShellAdapters extends StatelessWidget {
  const MainShellAdapters({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();
    if (!featureAccess.externalContactsAvailable) return child;

    // The contacts pull-to-refresh port: the forced refresh goes through the
    // polling service, so it cannot race a scheduled tick and pushes the
    // next one a full interval away.
    return Provider<ContactsRefresher>(
      create: (context) => PollingContactsRefresher(
        pollingService: context.read<PollingService>(),
        listener: context.read<ExternalContactsSyncWorker>(),
      ),
      child: child,
    );
  }
}
