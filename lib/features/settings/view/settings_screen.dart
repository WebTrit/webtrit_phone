import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/call_routing/cubit/call_routing_cubit.dart';
import 'package:webtrit_phone/features/register_status/register_status.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/features/voicemail/cubits/cubits.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../settings.dart';
import '../widgets/widgets.dart';

export 'settings_screen_style.dart';
export 'settings_screen_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.sections, required this.sessionsEnabled, this.style});

  final List<SettingsSection> sections;

  /// Whether the backend can list and revoke sessions; the row is not part of
  /// [sections] because it is not configurable.
  final bool sessionsEnabled;

  final SettingScreenStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final effectiveStyle = style ?? themeData.extension<SettingsScreenStyles>()?.primary;

    final showSeparators = effectiveStyle?.showSeparators ?? true;

    final mediaQuery = MediaQuery.of(context);
    final topPadding = kToolbarHeight + mediaQuery.padding.top;

    return ThemedScaffold(
      background: effectiveStyle?.background,
      contentThemeOverride: effectiveStyle?.contentThemeOverride,
      applyToAppBar: effectiveStyle?.applyToAppBar ?? true,
      appBarTheme: effectiveStyle?.appBarTheme,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: Text(context.l10n.settings_AppBarTitle_myAccount),
        flexibleSpace: BlurredSurface.fromStyle(effectiveStyle?.appBarBlurredSurface),
        actions: [
          // The busy overlay covers the body only, and the bar is outside it -
          // so an action up here has to refuse the press by itself while
          // something else is already running against the account.
          BlocSelector<SettingsBloc, SettingsState, bool>(
            selector: (state) => state.progress,
            builder: (context, busy) => SemanticAction(
              label: context.l10n.settings_ListViewTileTitle_logout,
              identifier: settingsLogoutButtonId,
              // The tooltip stays for the long press but keeps quiet: spoken on
              // top of the name it would say the same thing twice.
              child: Tooltip(
                message: context.l10n.settings_ListViewTileTitle_logout,
                excludeFromSemantics: true,
                child: IconButton(
                  // The Patrol logout subsequence taps this key.
                  key: settingsLogoutButtonKey,
                  // No colour of its own: it takes the bar's, the way every
                  // other app bar action does.
                  icon: const Icon(Icons.logout),
                  onPressed: busy ? null : () => _onLogoutTap(context),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                top: false,
                bottom: false,
                // Refreshing is a pull and nothing else, so the list has to
                // take a drag from a mouse too - on the web build that is the
                // only pointer there is.
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(dragDevices: PointerDeviceKind.values.toSet()),
                  // The list starts at the very top of the screen, under the
                  // translucent app bar, so the spinner has to start below it.
                  child: RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    edgeOffset: topPadding,
                    child: ListView(
                      padding: (effectiveStyle?.listViewPadding ?? const EdgeInsets.only(top: 16)).add(
                        EdgeInsets.only(top: topPadding, bottom: mediaQuery.padding.bottom),
                      ),
                      children: [
                        BlocBuilder<UserInfoCubit, UserInfoState>(
                          builder: (context, state) => UserInfoListTile(
                            info: state.userInfo,
                            topIssue: context.watch<SessionStatusCubit>().state.topIssue,
                          ),
                        ),
                        BlocBuilder<SessionStatusCubit, SessionStatusState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status || previous.topIssue != current.topIssue,
                          builder: (context, sessionState) => SessionStatusListTile(
                            status: sessionState.status,
                            topIssue: sessionState.topIssue,
                            registered: context.select<RegisterStatusCubit, bool>((cubit) => cubit.state.value),
                            updating: context.select<RegisterStatusCubit, bool>((cubit) => cubit.state.isUpdating),
                            onTap: () => _onDiagnosticTap(context),
                          ),
                        ),
                        if (showSeparators) ListTileSeparator(color: effectiveStyle?.separatorColor),
                        BlocBuilder<RegisterStatusCubit, RegisterStatus>(
                          builder: (context, registerState) => RegisterStatusListTile(
                            sessionStatus: context.select<SessionStatusCubit, SessionStatus>(
                              (cubit) => cubit.state.status,
                            ),
                            registerStatus: registerState,
                            onChanged: (value) => _onRegisterStatusChanged(context, value),
                            onUnavailableTap: () => _onRegisterStatusUnavailableTap(context),
                            textStyle: effectiveStyle?.itemTextStyle,
                            iconColor: effectiveStyle?.userIconColor ?? effectiveStyle?.leadingIconsColor,
                          ),
                        ),
                        if (showSeparators) ListTileSeparator(color: effectiveStyle?.separatorColor),
                        if (sessionsEnabled)
                          Builder(
                            builder: (context) {
                              final sessionsCount = context.select<SessionsCubit, int>(
                                (cubit) => cubit.state.sessions.length,
                              );
                              return SettingsTile(
                                title: context.l10n.settings_ListViewTileTitle_sessions,
                                icon: Icons.devices,
                                iconColor: effectiveStyle?.leadingIconsColor,
                                trailing: sessionsCount > 0 ? CountBadge(count: sessionsCount, size: 32) : null,
                                trailingLabel: sessionsCount > 0
                                    ? context.l10n.common_SemanticsValue_totalCount(sessionsCount)
                                    : null,
                                textStyle: effectiveStyle?.itemTextStyle,
                                showSeparator: showSeparators,
                                separatorColor: effectiveStyle?.separatorColor,
                                onTap: () => _onSessionsTap(context),
                              );
                            },
                          ),
                        for (final section in sections) ...[
                          GroupTitleListTile(
                            titleData: context.parseL10n(section.titleL10n),
                            style: effectiveStyle?.groupTitleListStyle,
                          ),
                          for (final item in section.items) ...[
                            if (item.flavor == SettingsFlavor.callerId)
                              BlocBuilder<CallRoutingCubit, CallRoutingState?>(
                                builder: (context, routingState) {
                                  if (routingState == null || routingState.additionalNumbers.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return SettingsTile(
                                    title: context.parseL10n(item.titleL10n),
                                    icon: item.icon,
                                    iconColor: item.iconColor ?? effectiveStyle?.leadingIconsColor,
                                    textStyle: effectiveStyle?.itemTextStyle,
                                    showSeparator: showSeparators,
                                    separatorColor: effectiveStyle?.separatorColor,
                                    onTap: () => _onItemTap(context, item),
                                  );
                                },
                              )
                            else if (item.flavor == SettingsFlavor.presence) ...[
                              if (PresenceViewParams.of(context).hybridPresenceSupport)
                                SettingsTile(
                                  title: context.parseL10n(item.titleL10n),
                                  icon: item.icon,
                                  iconColor: item.iconColor ?? effectiveStyle?.leadingIconsColor,
                                  textStyle: effectiveStyle?.itemTextStyle,
                                  showSeparator: showSeparators,
                                  separatorColor: effectiveStyle?.separatorColor,
                                  onTap: () => _onItemTap(context, item),
                                ),
                            ] else if (item.flavor == SettingsFlavor.voicemail) ...[
                              _WithUnreadVoicemailCount(
                                builder: (context, unreadCount) => SettingsTile(
                                  title: context.parseL10n(item.titleL10n),
                                  icon: item.icon,
                                  iconColor: item.iconColor ?? effectiveStyle?.leadingIconsColor,
                                  trailing: unreadCount > 0 ? CountBadge(count: unreadCount, size: 32) : null,
                                  trailingLabel: unreadCount > 0
                                      ? context.l10n.common_SemanticsValue_unreadCount(unreadCount)
                                      : null,
                                  textStyle: effectiveStyle?.itemTextStyle,
                                  showSeparator: showSeparators,
                                  separatorColor: effectiveStyle?.separatorColor,
                                  onTap: () => _onItemTap(context, item),
                                ),
                              ),
                            ] else
                              SettingsTile(
                                title: context.parseL10n(item.titleL10n),
                                icon: item.icon,
                                iconColor: item.iconColor ?? effectiveStyle?.leadingIconsColor,
                                textStyle: effectiveStyle?.itemTextStyle,
                                showSeparator: showSeparators,
                                separatorColor: effectiveStyle?.separatorColor,
                                onTap: () => _onItemTap(context, item),
                              ),
                          ],
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              if (state.progress) const AbsorbPointer(child: Center(child: CircularProgressIndicator())),
            ],
          );
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    final succeeded = await context.read<RegisterStatusCubit>().fetchStatus();
    if (!succeeded && context.mounted) {
      context.showErrorSnackBar(context.l10n.settings_registerStatusSnackBar_requestFailed);
    }
  }

  void _onDiagnosticTap(BuildContext context) => context.router.navigate(const DiagnosticScreenPageRoute());

  void _onSessionsTap(BuildContext context) => context.router.navigate(const SessionsScreenPageRoute());

  /// A failure rolls the switch back, so it must be explained: without a
  /// message the flip-back reads as the app ignoring the tap.
  Future<void> _onRegisterStatusChanged(BuildContext context, bool value) async {
    final succeeded = await context.read<RegisterStatusCubit>().setStatus(value);
    if (!succeeded && context.mounted) {
      context.showErrorSnackBar(context.l10n.settings_registerStatusSnackBar_requestFailed);
    }
  }

  void _onRegisterStatusUnavailableTap(BuildContext context) => context.showSnackBar(
    context.l10n.settings_registerStatusSnackBar_unavailable,
    action: SnackBarAction(label: context.l10n.diagnostic_AppBar_title, onPressed: () => _onDiagnosticTap(context)),
  );

  void _onItemTap(BuildContext context, SettingItem item) {
    switch (item.flavor) {
      case SettingsFlavor.network:
        context.router.navigate(const NetworkScreenPageRoute());
      case SettingsFlavor.language:
        context.router.navigate(const LanguageScreenPageRoute());
      case SettingsFlavor.themeMode:
        context.router.navigate(const ThemeModeScreenPageRoute());
      case SettingsFlavor.help:
        context.router.navigate(HelpScreenPageRoute(initialUriQueryParam: item.data!.uri.toString()));
      case SettingsFlavor.terms:
      case SettingsFlavor.embedded:
        context.router.navigate(EmbeddedScreenPageRoute(data: item.data!));
      case SettingsFlavor.about:
        context.router.navigate(const AboutScreenPageRoute());
      case SettingsFlavor.log:
        context.router.navigate(const LogRecordsConsoleScreenPageRoute());
      case SettingsFlavor.deleteAccount:
        _onDeleteAccountTap(context);
      case SettingsFlavor.mediaSettings:
        context.router.navigate(const MediaSettingsScreenPageRoute());
      case SettingsFlavor.cacheManagement:
        context.router.navigate(const CacheManagementScreenPageRoute());
      case SettingsFlavor.voicemail:
        context.router.navigate(const VoicemailScreenPageRoute());
      case SettingsFlavor.callerId:
        context.router.navigate(const CallerIdSettingsScreenPageRoute());
      case SettingsFlavor.presence:
        context.router.navigate(const PresenceSettingsScreenPageRoute());
    }
  }

  Future<void> _onLogoutTap(BuildContext context) async {
    final settingsBloc = context.read<SettingsBloc>();
    final logout = await ConfirmDialog.show(
      context,
      title: context.l10n.settings_LogoutConfirmDialog_title,
      content: context.l10n.settings_LogoutConfirmDialog_content,
    );
    if (logout == true) {
      settingsBloc.add(const SettingsLogouted());
    }
  }

  Future<void> _onDeleteAccountTap(BuildContext context) async {
    final settingsBloc = context.read<SettingsBloc>();
    final deleteAccount = await ConfirmDialog.show(
      context,
      title: context.l10n.settings_AccountDeleteConfirmDialog_title,
      content: context.l10n.settings_AccountDeleteConfirmDialog_content,
    );
    if (deleteAccount == true) {
      settingsBloc.add(const SettingsAccountDeleted());
    }
  }
}

/// Builds its child with the number of voicemails waiting.
///
/// The badge is an ornament, so a host that shows this screen outside a
/// session - the screenshot previews - provides no counter and gets a row
/// without one rather than a missing-provider error. Same reasoning, and the
/// same nullable read, as the messaging badge on the navigation bar.
class _WithUnreadVoicemailCount extends StatelessWidget {
  const _WithUnreadVoicemailCount({required this.builder});

  final Widget Function(BuildContext context, int unreadCount) builder;

  @override
  Widget build(BuildContext context) {
    final unreadVoicemails = context.watch<VoicemailUnreadCubit?>();
    if (unreadVoicemails == null) return builder(context, 0);

    return BlocBuilder<VoicemailUnreadCubit, int>(bloc: unreadVoicemails, builder: builder);
  }
}
