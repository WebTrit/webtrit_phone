// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.title,
    this.bottom,
    required this.context,
    this.backgroundColor,
    this.flexibleSpace,
    this.elevation,
  });

  final BuildContext context;
  final Widget? title;
  final PreferredSizeWidget? bottom;
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
    // final colorScheme = theme.colorScheme;

    return BlocBuilder<SessionStatusCubit, SessionStatusState>(
      builder: (context, sessionState) {
        final status = sessionState.status;
        return AppBar(
          title: Builder(
            builder: (context) {
              Widget? widgetToShow;
              if (!status.hasPushTokenError &&
                  status.signalingStatus != CallStatus.ready &&
                  status.signalingStatus != CallStatus.appUnregistered) {
                widgetToShow = Row(
                  key: status.key,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: 16, height: 16, child: CircularProgressIndicator()),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        sessionState.status.appBarl10n(context),
                        style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
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
            if (status.signalingStatus == CallStatus.ready && !status.hasPushTokenError) ...[
              if (AppBarParams.of(context).pullableCallDialogs.isNotEmpty)
                CallPullBadge(pullableCallDialogs: AppBarParams.of(context).pullableCallDialogs),
              if (AppBarParams.of(context).systemNotificationsEnabled) SystemNotificationsBadge(),
            ],
            Ink(
              decoration: ShapeDecoration(
                shape: CircleBorder(side: BorderSide(color: sessionState.status.color(context))),
              ),
              child: BlocBuilder<UserInfoCubit, UserInfoState>(
                builder: (context, userinfoState) {
                  final info = userinfoState.userInfo;
                  return IconButton(
                    key: mainAppBarKey,
                    constraints: const BoxConstraints.tightFor(
                      width: kMinInteractiveDimension,
                      height: kMinInteractiveDimension,
                    ),
                    padding: const EdgeInsets.all(2),
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        LeadingAvatar(
                          username: info?.name ?? info?.numbers.main,
                          thumbnailUrl: gravatarThumbnailUrl(info?.email),
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
                                  child: Icon(Icons.mic_off, color: Colors.white, size: 14),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.router.navigate(const SettingsRouterPageRoute());
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: NavigationToolbar.kMiddleSpacing),
          ],
        );
      },
    );
  }
}
