import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/about_bloc.dart';

import 'about_screen_style.dart';
import 'about_screen_styles.dart';

export 'about_screen_style.dart';
export 'about_screen_styles.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({
    super.key,
    this.style,
  });

  final AboutScreenStyle? style;

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late final MultiTapTrigger _multiTapLoggingTrigger;

  @override
  void initState() {
    super.initState();
    // TODO(Serdun): Add environment config to the disable multi-tap logging trigger
    _multiTapLoggingTrigger = MultiTapTrigger(
      onTriggered: () => context.router.navigate(const LogRecordsConsoleScreenPageRoute()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final localStyle = widget.style ?? themeData.extension<AboutScreenStyles>()?.primary;
    final logo = localStyle?.picture;

    return BlocBuilder<AboutBloc, AboutState>(
      builder: (context, state) {
        final themeData = Theme.of(context);
        final logoHeight = themeData.textTheme.displayLarge!.fontSize! * 1.5;
        final delimiterHeight = themeData.textTheme.titleLarge!.fontSize!;
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.settings_ListViewTileTitle_about),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (logo != null)
                    logo.svg(
                      height: logoHeight,
                    ),
                  Text(
                    state.appName,
                    style: themeData.textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  Text(state.packageName),
                  SizedBox(
                    height: delimiterHeight,
                  ),
                  Text(
                    context.l10n.settings_AboutText_AppVersion,
                  ),
                  GestureDetector(
                    onTap: _multiTapLoggingTrigger.tap,
                    child: Text(
                      state.appVersion,
                      style: themeData.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: delimiterHeight,
                  ),
                  Text(
                    context.l10n.settings_AboutText_StoreVersion,
                  ),
                  Text(
                    state.storeVersion,
                    style: themeData.textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: delimiterHeight,
                  ),
                  CopyToClipboard(
                    data: state.appIdentifier,
                    child: Text(
                      context.l10n.settings_AboutText_AppSessionIdentifier,
                    ),
                  ),
                  CopyToClipboard(
                    data: state.appIdentifier,
                    child: Text(
                      state.appIdentifier,
                      style: themeData.textTheme.labelSmall,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: delimiterHeight,
                  ),
                  CopyToClipboard(
                    data: state.fcmPushToken,
                    child: Text(
                      context.l10n.settings_AboutText_FCMPushNotificationToken,
                    ),
                  ),
                  CopyToClipboard(
                    data: state.fcmPushToken,
                    child: Text(
                      state.fcmPushToken ?? '-',
                      style: themeData.textTheme.labelSmall,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: delimiterHeight,
                  ),
                  CopyToClipboard(
                    data: state.coreUrl.toString(),
                    child: Text(
                      state.coreUrl.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Text(
                        state.progress
                            ? ''
                            : (state.coreVersion ?? context.l10n.settings_AboutText_CoreVersionUndefined).toString(),
                        style: themeData.textTheme.bodyMedium,
                      ),
                      if (state.progress)
                        SizedCircularProgressIndicator(
                          size: themeData.textTheme.bodyMedium!.fontSize!,
                          strokeWidth: 2,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
