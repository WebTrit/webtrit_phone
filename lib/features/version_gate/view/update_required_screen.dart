import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:store_info_extractor/store_info_extractor.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';

final _logger = Logger('UpdateRequiredScreen');

/// Full-screen, non-dismissible force-update gate shown when the running app is
/// older than the backend-declared minimum supported version
/// (`min_supported_app_version` from system-info). The user must update or log out.
///
/// Replaces the former `AppUpdateRequiredDialog` overlay: as a routed page it
/// removes the visual blink where the real main content flashed before the
/// dialog covered it. The router guard ([AppRouter.onMainShellRouteGuardNavigation])
/// redirects here while [AppState.appCompatibility] is [AppVersionTooOld].
@RoutePage()
class UpdateRequiredScreenPage extends StatelessWidget {
  const UpdateRequiredScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final packageInfo = context.read<PackageInfo>();
    final compatibility = context.select<AppBloc, AppCompatibility>((bloc) => bloc.state.appCompatibility);

    final currentVersion = Version.parse(packageInfo.version);
    final minSupportedVersion = compatibility is AppVersionTooOld ? compatibility.minSupportedVersion : currentVersion;

    // The Android back button must not escape the gate.
    return PopScope(
      canPop: false,
      child: _UpdateRequiredView(currentVersion: currentVersion, minSupportedVersion: minSupportedVersion),
    );
  }
}

/// Hosts the async store-URL resolution: the "Update" action is only offered
/// when the store actually hosts a build newer than the running one (matching
/// the former MainBloc behaviour). Resolution failures are swallowed and the
/// Update button is simply omitted.
class _UpdateRequiredView extends StatefulWidget {
  const _UpdateRequiredView({required this.currentVersion, required this.minSupportedVersion});

  final Version currentVersion;
  final Version minSupportedVersion;

  @override
  State<_UpdateRequiredView> createState() => _UpdateRequiredViewState();
}

class _UpdateRequiredViewState extends State<_UpdateRequiredView> {
  Uri? _updateStoreUrl;

  @override
  void initState() {
    super.initState();
    _resolveStoreUpdateUrl();
  }

  Future<void> _resolveStoreUpdateUrl() async {
    final packageInfo = context.read<PackageInfo>();
    final appVersion = widget.currentVersion;

    StoreInfo? storeInfo;
    try {
      storeInfo = await StoreInfoExtractor().getStoreInfo(packageInfo.packageName);
    } catch (e, st) {
      _logger.warning('getStoreInfo for ${packageInfo.packageName} error - ignore', e, st);
    }

    if (!mounted) return;
    if (storeInfo != null && storeInfo.version > appVersion) {
      setState(() => _updateStoreUrl = storeInfo!.viewUrl);
    }
  }

  Future<void> _onUpdate() async {
    final url = _updateStoreUrl;
    if (url != null && await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _onLogout() {
    context.read<AppBloc>().add(const AppLogoutRequested(reason: AppLogoutReason.userRequest));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final elevatedButtonStyles = theme.extension<ElevatedButtonStyles>();

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
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
                        _VersionCard(
                          currentVersion: widget.currentVersion,
                          minSupportedVersion: widget.minSupportedVersion,
                        ),
                        const Spacer(flex: 2),
                        if (_updateStoreUrl != null) ...[
                          ElevatedButton(
                            onPressed: _onUpdate,
                            style: elevatedButtonStyles?.primary,
                            child: Text(context.l10n.main_CompatibilityIssueDialogActions_update),
                          ),
                          const SizedBox(height: kInset / 3),
                        ],
                        TextButton(
                          onPressed: _onLogout,
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
