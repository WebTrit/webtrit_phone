// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.bottom,
    this.actions = const [],
    required this.context,
    this.backgroundColor,
    this.flexibleSpace,
    this.elevation,
  });

  final BuildContext context;
  final Widget? title;
  final PreferredSizeWidget? bottom;

  /// Controls of one screen, shown before the ones every screen carries.
  ///
  /// A screen whose header is a single short line has nowhere else to put a
  /// control that belongs to the whole screen rather than to what the line
  /// below is about.
  ///
  /// Shown while the session is still being established, unlike the bar's own
  /// controls: those need a session to mean anything, while a screen's control
  /// works on what is already on screen.
  final List<Widget> actions;
  final Color? backgroundColor;
  final Widget? flexibleSpace;
  final double? elevation;

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kMinInteractiveDimension + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // The smoothing of transient signaling states lives in SessionStatusCubit,
    // so the status is consumed directly: a second debouncer here would stack
    // an identical window on top and lag the app bar behind the rest of the UI.
    return RepaintBoundary(
      child: BlocBuilder<SessionStatusCubit, SessionStatusState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, sessionStatusState) {
          final status = sessionStatusState.status;
          return AppBar(
            title: Builder(
              builder: (context) {
                Widget? widgetToShow;
                if (status.isEstablishing) {
                  widgetToShow = Row(
                    key: status.key,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(width: 16, height: 16, child: CircularProgressIndicator()),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          status.appBarl10n(context),
                          // Colored as a title: the status line replaces the title, so it has
                          // to follow the app bar's configured title color, not the typography.
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: DefaultTextStyle.of(context).style.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  );
                }
                widgetToShow ??= Row(mainAxisSize: MainAxisSize.max, children: [title ?? SizedBox.shrink()]);

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    final r = animation.status == AnimationStatus.reverse;
                    return FadeTransition(
                      opacity: animation.drive(CurveTween(curve: Curves.easeInOut)),
                      child: SlideTransition(
                        position: animation.drive(
                          Tween<Offset>(
                            begin: Offset(0, r ? -1 : 1),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeOut)),
                        ),
                        child: child,
                      ),
                    );
                  },
                  switchInCurve: Curves.easeInExpo,
                  switchOutCurve: Curves.easeOutExpo,
                  child: widgetToShow,
                );
              },
            ),
            bottom: bottom,
            backgroundColor: backgroundColor,
            flexibleSpace: flexibleSpace,
            elevation: elevation,
            centerTitle: false,
            actions: [
              ...actions,
              if (status.isReady) ...[
                if (AppBarParams.of(context).pullableCallDialogs.isNotEmpty)
                  CallPullBadge(pullableCallDialogs: AppBarParams.of(context).pullableCallDialogs),
                if (AppBarParams.of(context).systemNotificationsEnabled) SystemNotificationsBadge(),
              ],
              Ink(
                decoration: ShapeDecoration(
                  shape: CircleBorder(side: BorderSide(color: status.color(context))),
                ),
                child: BlocBuilder<UserInfoCubit, UserInfoState>(
                  builder: (context, userinfoState) {
                    final info = userinfoState.userInfo;
                    final displayName = info?.name ?? info?.numbers.main;
                    final myAccount = context.l10n.settings_AppBarTitle_myAccount;
                    return SemanticAction(
                      label: displayName == null ? myAccount : '$myAccount, $displayName',
                      identifier: mainAppBarId,
                      child: IconButton(
                        key: mainAppBarKey,
                        constraints: const BoxConstraints.tightFor(
                          width: kMinInteractiveDimension,
                          height: kMinInteractiveDimension,
                        ),
                        padding: const EdgeInsets.all(2),
                        // The avatar's initials and status badges are visual-only here; the
                        // button announces itself with a fixed name instead.
                        icon: ExcludeSemantics(
                          // The avatar keeps its own palette: without this reset the app bar
                          // pushes its foreground color into the subtree and tints it.
                          child: IconTheme(
                            data: theme.iconTheme,
                            child: DefaultTextStyle(
                              style: theme.textTheme.bodyMedium!,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  LeadingAvatar(
                                    username: info?.name ?? info?.numbers.main,
                                    thumbnailUrl: GravatarUrl.forEmail(info?.email),
                                    radius: kMinInteractiveDimension / 2,
                                    showLoading: true,
                                  ),
                                  BlocBuilder<MicrophoneStatusBloc, MicrophoneStatusState>(
                                    builder: (context, microphoneStatusState) {
                                      return Visibility(
                                        visible:
                                            microphoneStatusState.microphonePermissionGranted != null &&
                                            !microphoneStatusState.microphonePermissionGranted!,
                                        child: Positioned(
                                          right: -8,
                                          top: -2,
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.error,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.mic_off,
                                              color: Theme.of(context).colorScheme.onError,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  BlocBuilder<SessionStatusCubit, SessionStatusState>(
                                    buildWhen: (previous, current) => previous.topIssue != current.topIssue,
                                    builder: (context, sessionState) {
                                      final topIssue = sessionState.topIssue;
                                      if (topIssue == null) return const SizedBox.shrink();
                                      return Positioned(
                                        right: -2,
                                        bottom: -2,
                                        child: SessionIssueBadge(color: topIssue.color(context), size: 12),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          context.router.navigate(const SettingsRouterPageRoute());
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: NavigationToolbar.kMiddleSpacing),
            ],
          );
        },
      ),
    );
  }
}
