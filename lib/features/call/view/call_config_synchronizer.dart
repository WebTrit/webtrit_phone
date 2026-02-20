import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';

import '../bloc/call_bloc.dart';

final _logger = Logger('CallConfigSynchronizer');

/// Synchronizes external feature configurations with the [CallBloc].
///
/// This widget acts as a logical listener layer. It monitors changes in
/// [FeatureAccess] (e.g., [LoggingConfig]) and dispatches the appropriate
/// configuration events to the [CallBloc].
///
/// By isolating this side-effect logic from visual routing components
/// like [CallShell], it ensures that backend configuration updates
/// do not trigger unnecessary UI rebuilds.
class CallConfigSynchronizer extends StatefulWidget {
  const CallConfigSynchronizer({super.key, required this.child});

  final Widget child;

  @override
  State<CallConfigSynchronizer> createState() => _CallConfigSynchronizerState();
}

class _CallConfigSynchronizerState extends State<CallConfigSynchronizer> {
  FeatureAccess? _previousAccess;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currentAccess = context.watch<FeatureAccess>();

    if (_previousAccess != null) {
      _syncConfigs(_previousAccess!, currentAccess);
    }

    _previousAccess = currentAccess;
  }

  void _syncConfigs(FeatureAccess prev, FeatureAccess current) {
    if (prev.loggingConfig.monitorCheckInterval != current.loggingConfig.monitorCheckInterval) {
      _logger.info(
        'monitorCheckInterval updated: ${prev.loggingConfig.monitorCheckInterval} -> ${current.loggingConfig.monitorCheckInterval}',
      );

      context.read<CallBloc>().add(
        CallConfigEvent.updated(monitorCheckInterval: current.loggingConfig.monitorCheckInterval),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
