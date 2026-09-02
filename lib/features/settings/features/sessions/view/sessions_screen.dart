import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../cubit/sessions_cubit.dart';
import '../widgets/widgets.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key, required this.dateFormat});

  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.sessions_AppBar_title), leading: const ExtBackButton()),
      body: BlocBuilder<SessionsCubit, SessionsState>(
        builder: (context, state) {
          if (state.loading && state.sessions.isEmpty) {
            return const Center(child: CircularProgressIndicator(strokeWidth: 2));
          }
          if (state.failed && state.sessions.isEmpty) {
            return _FailurePlaceholder(onRetry: () => _onRefresh(context));
          }

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: state.sessions.isEmpty
                        ? _EmptyPlaceholder(text: l10n.sessions_Placeholder_empty)
                        : ListView(
                            children: [
                              for (final session in state.sessionsStartedFromCurrent)
                                SessionTile(
                                  session: session,
                                  dateFormat: dateFormat,
                                  revoking: state.isRevoking(session.id),
                                  onRevoke: (session) => _onRevoke(context, session),
                                ),
                            ],
                          ),
                  ),
                ),
                if (state.hasOtherSessions)
                  TextButton.icon(
                    icon: const Icon(Icons.logout),
                    label: Text(l10n.sessions_Button_revokeAllOthers),
                    onPressed: state.hasOtherSessions ? () => _onRevokeAllOthers(context) : null,
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onPrimary,
                      backgroundColor: colorScheme.primary,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) => context.read<SessionsCubit>().fetch();

  Future<void> _onRevoke(BuildContext context, ActiveSession session) async {
    final confirmed = await ConfirmDialog.showDangerous(
      context,
      title: context.l10n.sessions_RevokeConfirmDialog_title,
      content: context.l10n.sessions_RevokeConfirmDialog_content,
    );
    if (confirmed != true || !context.mounted) return;

    final succeeded = await context.read<SessionsCubit>().revoke(session.id);
    if (!succeeded && context.mounted) {
      context.showErrorSnackBar(context.l10n.sessions_SnackBar_revokeFailed);
    }
  }

  Future<void> _onRevokeAllOthers(BuildContext context) async {
    final confirmed = await ConfirmDialog.showDangerous(
      context,
      title: context.l10n.sessions_RevokeAllConfirmDialog_title,
      content: context.l10n.sessions_RevokeAllConfirmDialog_content,
    );
    if (confirmed != true || !context.mounted) return;

    final succeeded = await context.read<SessionsCubit>().revokeAllOthers();
    if (!succeeded && context.mounted) {
      context.showErrorSnackBar(context.l10n.sessions_SnackBar_revokeFailed);
    }
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  const _EmptyPlaceholder({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    // A scrollable is required so pull-to-refresh keeps working while the list is empty.
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Center(child: Text(text)),
        ),
      ],
    );
  }
}

class _FailurePlaceholder extends StatelessWidget {
  const _FailurePlaceholder({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(context.l10n.sessions_Placeholder_failure, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: Text(context.l10n.sessions_Button_retry)),
        ],
      ),
    );
  }
}
