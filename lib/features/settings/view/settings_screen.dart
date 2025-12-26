import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/call_routing/cubit/call_routing_cubit.dart';
import 'package:webtrit_phone/features/register_status/register_status.dart';
import 'package:webtrit_phone/features/session_status/session_status.dart';
import 'package:webtrit_phone/features/user_info/user_info.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../settings.dart';
import '../widgets/widgets.dart';

export 'settings_screen_style.dart';
export 'settings_screen_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({required this.sections, this.style, super.key});

  final List<SettingsSection> sections;
  final SettingScreenStyle? style;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final effectiveStyle = style ?? themeData.extension<SettingsScreenStyles>()?.primary;

    final showSeparators = effectiveStyle?.showSeparators ?? true;
    final background = effectiveStyle?.background;
    final isComplexBackground = background?.isComplex == true;

    return ThemedScaffold(
      background: background,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: Text(context.l10n.settings_AppBarTitle_myAccount),
        backgroundColor: isComplexBackground ? Colors.transparent : null,
        elevation: isComplexBackground ? 0 : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            style: IconButton.styleFrom(foregroundColor: colorScheme.onSurface),
            onPressed: () => _onRefreshTap(context),
          ),
        ],
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                top: !isComplexBackground,
                bottom: false,
                child: ListView(
                  padding: effectiveStyle?.listViewPadding ?? const EdgeInsets.only(top: 16),
                  children: [
                    BlocBuilder<UserInfoCubit, UserInfoState>(
                      builder: (context, state) => UserInfoListTile(info: state.userInfo),
                    ),
                    BlocBuilder<SessionStatusCubit, SessionStatusState>(
                      buildWhen: (previous, current) => previous.status != current.status,
                      builder: (context, sessionState) =>
                          SessionStatusListTile(status: sessionState.status, onTap: () => _onDiagnosticTap(context)),
                    ),
                    if (showSeparators) const ListTileSeparator(),
                    BlocBuilder<RegisterStatusCubit, RegisterStatus>(
                      builder: (context, registerState) => SwitchListTile(
                        title: Text(
                          context.l10n.settings_ListViewTileTitle_registered,
                          style: effectiveStyle?.itemTextStyle,
                        ),
                        value: registerState,
                        onChanged: (value) => _onRegisterStatusChanged(context, value),
                        secondary: Icon(
                          Icons.account_circle_outlined,
                          color: effectiveStyle?.userIconColor ?? effectiveStyle?.leadingIconsColor,
                        ),
                      ),
                    ),
                    if (showSeparators) const ListTileSeparator(),
                    SettingsTile(
                      key: settingsLogoutButtonKey,
                      title: context.l10n.settings_ListViewTileTitle_logout,
                      icon: Icons.logout,
                      iconColor: effectiveStyle?.logoutIconColor ?? effectiveStyle?.leadingIconsColor,
                      textStyle: effectiveStyle?.itemTextStyle,
                      showSeparator: showSeparators,
                      onTap: () => _onLogoutTap(context),
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
                                iconColor: item.iconColor ?? style?.leadingIconsColor,
                                textStyle: style?.itemTextStyle,
                                showSeparator: showSeparators,
                                onTap: () => _onItemTap(context, item),
                              );
                            },
                          )
                        else if (item.flavor == SettingsFlavor.presence) ...[
                          if (PresenceViewParams.of(context).viewSource == PresenceViewSource.sipPresence)
                            SettingsTile(
                              title: context.parseL10n(item.titleL10n),
                              icon: item.icon,
                              iconColor: item.iconColor ?? style?.leadingIconsColor,
                              textStyle: style?.itemTextStyle,
                              showSeparator: showSeparators,
                              onTap: () => _onItemTap(context, item),
                            ),
                        ] else
                          SettingsTile(
                            title: context.parseL10n(item.titleL10n),
                            icon: item.icon,
                            iconColor: item.iconColor ?? style?.leadingIconsColor,
                            trailing: item.flavor == SettingsFlavor.voicemail
                                ? UnreadBadge(count: state.unreadVoicemailCount)
                                : null,
                            textStyle: style?.itemTextStyle,
                            showSeparator: showSeparators,
                            onTap: () => _onItemTap(context, item),
                          ),
                      ],
                    ],
                  ],
                ),
              ),
              if (state.progress) const AbsorbPointer(child: Center(child: CircularProgressIndicator())),
            ],
          );
        },
      ),
    );
  }

  void _onRefreshTap(BuildContext context) => context.read<RegisterStatusCubit>().fetchStatus();

  void _onDiagnosticTap(BuildContext context) => context.router.navigate(const DiagnosticScreenPageRoute());

  void _onRegisterStatusChanged(BuildContext context, bool value) =>
      context.read<RegisterStatusCubit>().setStatus(value);

  void _onItemTap(BuildContext context, SettingItem item) {
    switch (item.flavor) {
      case SettingsFlavor.network:
        context.router.navigate(const NetworkScreenPageRoute());
      case SettingsFlavor.language:
        context.router.navigate(const LanguageScreenPageRoute());
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
