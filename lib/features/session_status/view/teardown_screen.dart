import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart' show WebtritSignalingService;

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

final _logger = Logger('TeardownScreen');

class TeardownScreen extends StatefulWidget {
  const TeardownScreen({super.key});

  @override
  State<TeardownScreen> createState() => _TeardownScreenState();
}

class _TeardownScreenState extends State<TeardownScreen> {
  @override
  void initState() {
    super.initState();
    _logger.fine('TeardownScreen.initState');

    // Stop the native signaling service before session cleanup begins so it
    // stops reconnecting with the stale token immediately. TeardownScreen is
    // only rendered during explicit logout, so no status check is needed here.
    unawaited(
      WebtritSignalingService.stopService().catchError((Object e, StackTrace st) {
        _logger.warning('stopService failed', e, st);
      }),
    );

    // Schedule the cleanup event after the widget is mounted.
    // Using addPostFrameCallback ensures the navigation transition
    // has definitely started processing.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _logger.fine('TeardownScreen.addPostFrameCallback');
        context.read<AppBloc>().add(const AppCleanupRequested());
      } else {
        _logger.fine('TeardownScreen.addPostFrameCallback: widget is not mounted');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(context.l10n.session_Teardown_progressText),
          ],
        ),
      ),
    );
  }
}
