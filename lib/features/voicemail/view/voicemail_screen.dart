import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

/// Voicemail as it is reached from the settings list: under a header of its
/// own, with the actions that manage the mailbox.
class VoicemailScreen extends StatelessWidget {
  const VoicemailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.voicemail_Widget_screenTitle),
        actions: [
          if (context.read<AppCacheManager>().sections.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.storage),
              tooltip: context.l10n.cacheManagement_Widget_screenTitle,
              onPressed: () => _onOpenCacheManagement(context),
            ),
          const VoicemailDeleteAction(offersDeleteAll: true),
        ],
      ),
      body: const VoicemailBody(),
    );
  }

  /// Clearing the voicemail cache deletes files the player may hold open, so
  /// playback stops before the cache management screen opens on top.
  void _onOpenCacheManagement(BuildContext context) {
    unawaited(context.read<VoicemailPlaybackController>().stop());
    context.router.navigate(const CacheManagementScreenPageRoute());
  }
}
