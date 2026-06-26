import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:store_info_extractor/store_info_extractor.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

final _logger = Logger('CompatibilityIssueScreen');

/// Full-screen, non-dismissible gate shown when the backend core version is
/// outside the app's supported constraint (the inverse of the too-old app gate:
/// here the backend is too new). The user must update or log out.
///
/// Replaces the former `CompatibilityIssueDialog` overlay. The router guard
/// ([AppRouter.onMainShellRouteGuardNavigation]) redirects here while
/// [AppState.appCompatibility] is [CoreVersionUnsupported].
@RoutePage()
class CompatibilityIssueScreenPage extends StatelessWidget {
  const CompatibilityIssueScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appInfo = context.read<AppInfo>();
    final compatibility = context.select<AppBloc, AppCompatibility>((bloc) => bloc.state.appCompatibility);

    final currentVersion = appInfo.version;
    final supportedConstraint = compatibility is CoreVersionUnsupported
        ? compatibility.constraint
        : VersionConstraint.any;

    return PopScope(
      canPop: false,
      child: _CompatibilityIssueView(currentVersion: currentVersion, supportedConstraint: supportedConstraint),
    );
  }
}

/// Hosts the async store-URL resolution: the "Update" action is only offered
/// when the store hosts a build newer than the running one.
class _CompatibilityIssueView extends StatefulWidget {
  const _CompatibilityIssueView({required this.currentVersion, required this.supportedConstraint});

  final Version currentVersion;
  final VersionConstraint supportedConstraint;

  @override
  State<_CompatibilityIssueView> createState() => _CompatibilityIssueViewState();
}

class _CompatibilityIssueViewState extends State<_CompatibilityIssueView> {
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
    final l10n = context.l10n;
    return Scaffold(
      body: Center(
        child: AlertDialog(
          title: Text(l10n.main_CompatibilityIssueDialog_title, textAlign: TextAlign.center),
          content: Text(
            l10n.main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(
              widget.currentVersion.toString(),
              widget.supportedConstraint.toString(),
            ),
          ),
          actions: [
            if (_updateStoreUrl != null)
              TextButton(onPressed: _onUpdate, child: Text(l10n.main_CompatibilityIssueDialogActions_update)),
            TextButton(onPressed: _onLogout, child: Text(l10n.main_CompatibilityIssueDialogActions_logout)),
          ],
        ),
      ),
    );
  }
}
