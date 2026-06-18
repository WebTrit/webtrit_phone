import 'package:flutter/material.dart';

import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

/// Non-dismissible, full-screen prompt shown when the running app is older than
/// the backend-declared minimum supported app version (`min_supported_app_version`
/// from system-info). The inverse of [CompatibilityIssueDialog]: there the
/// backend is too new, here the app is too old. The user must update or log out.
class AppUpdateRequiredDialog extends StatelessWidget {
  static Future show(
    BuildContext context,
    Version currentVersion,
    Version minSupportedVersion, {
    VoidCallback? onUpdatePressed,
    VoidCallback? onLogoutPressed,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        // PopScope blocks the Android back button so the gate cannot be escaped.
        return PopScope(
          canPop: false,
          child: AppUpdateRequiredDialog._(
            currentVersion,
            minSupportedVersion,
            onUpdatePressed: onUpdatePressed,
            onLogoutPressed: onLogoutPressed,
          ),
        );
      },
    );
  }

  const AppUpdateRequiredDialog._(
    this.currentVersion,
    this.minSupportedVersion, {
    this.onUpdatePressed,
    this.onLogoutPressed,
  });

  final Version currentVersion;
  final Version minSupportedVersion;
  final VoidCallback? onUpdatePressed;
  final VoidCallback? onLogoutPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final elevatedButtonStyles = theme.extension<ElevatedButtonStyles>();

    return Dialog.fullscreen(
      backgroundColor: colorScheme.surface,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kInset, vertical: kInset),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(),
                        const Center(child: _UpdateHero()),
                        const SizedBox(height: kInset),
                        Text(
                          context.l10n.main_AppUpdateRequiredDialog_title,
                          textAlign: TextAlign.center,
                          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: kInset / 2),
                        Text(
                          context.l10n.main_AppUpdateRequiredDialog_description,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: kInset * 1.5),
                        _VersionCard(currentVersion: currentVersion, minSupportedVersion: minSupportedVersion),
                        const Spacer(flex: 2),
                        if (onUpdatePressed != null) ...[
                          ElevatedButton(
                            onPressed: onUpdatePressed,
                            style: elevatedButtonStyles?.primary,
                            child: Text(context.l10n.main_CompatibilityIssueDialogActions_update),
                          ),
                          const SizedBox(height: kInset / 3),
                        ],
                        TextButton(
                          onPressed: onLogoutPressed,
                          child: Text(context.l10n.main_CompatibilityIssueDialogActions_logout),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Light blue concentric badge with an upward arrow and a small accent sparkle.
class _UpdateHero extends StatelessWidget {
  const _UpdateHero();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: kInset * 5,
      height: kInset * 5,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.primary.withValues(alpha: 0.10)),
            child: const SizedBox.expand(),
          ),
          Container(
            width: kInset * 4,
            height: kInset * 4,
            decoration: BoxDecoration(shape: BoxShape.circle, color: colorScheme.primary.withValues(alpha: 0.16)),
          ),
          Icon(Icons.arrow_upward_rounded, color: colorScheme.primary, size: kInset * 2),
          Positioned(
            top: kInset * 0.4,
            right: kInset * 0.6,
            child: Icon(Icons.auto_awesome, color: colorScheme.tertiary, size: kInset * 0.7),
          ),
        ],
      ),
    );
  }
}

/// Bordered card contrasting the running version with the required minimum.
class _VersionCard extends StatelessWidget {
  const _VersionCard({required this.currentVersion, required this.minSupportedVersion});

  final Version currentVersion;
  final Version minSupportedVersion;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(kInset * 0.66),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.symmetric(horizontal: kInset, vertical: kInset * 0.75),
      child: Column(
        children: [
          _VersionRow(
            label: context.l10n.main_AppUpdateRequiredDialog_currentVersionLabel,
            version: currentVersion,
            valueColor: colorScheme.onSurface,
          ),
          Divider(height: kInset, color: colorScheme.outlineVariant),
          _VersionRow(
            label: context.l10n.main_AppUpdateRequiredDialog_minimumVersionLabel,
            version: minSupportedVersion,
            valueColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

class _VersionRow extends StatelessWidget {
  const _VersionRow({required this.label, required this.version, required this.valueColor});

  final String label;
  final Version version;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: kInset / 6),
        Text(
          version.toString(),
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.bold,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
