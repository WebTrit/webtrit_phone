import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../bloc/about_bloc.dart';
import '../widgets/widgets.dart';

import 'about_screen_style.dart';
import 'about_screen_styles.dart';

export 'about_screen_style.dart';
export 'about_screen_styles.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key, this.style});

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
    _multiTapLoggingTrigger = MultiTapTrigger(onTriggered: _onMultiTapTriggered);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final localStyle = widget.style ?? themeData.extension<AboutScreenStyles>()?.primary;
    final delimiterHeight = themeData.textTheme.titleLarge!.fontSize!;
    return ThemedScaffold(
      background: localStyle?.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_about),
        backgroundColor: themeData.canvasColor.withAlpha(150),
        flexibleSpace: const BlurredSurface(),
      ),
      body: BlocBuilder<AboutBloc, AboutState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConfigurableThemeImage(style: localStyle?.pictureLogoStyle, defaultScale: 0.25),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  SizedBox(height: delimiterHeight),
                                  Text(state.packageName, textAlign: TextAlign.center),
                                  GestureDetector(
                                    onTap: _multiTapLoggingTrigger.tap,
                                    behavior: HitTestBehavior.translucent,
                                    child: Column(
                                      children: [
                                        Text(state.appInfo, textAlign: TextAlign.center),
                                        Text(state.deviceInfo, textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: delimiterHeight / 2),
                                  InfoTile(
                                    label: context.l10n.settings_AboutText_AppSessionIdentifier,
                                    value: state.appIdentifier,
                                  ),
                                  SizedBox(height: delimiterHeight / 2),
                                  InfoTile(
                                    label: context.l10n.settings_AboutText_FCMPushNotificationToken,
                                    value: state.fcmPushToken,
                                  ),
                                  SizedBox(height: delimiterHeight / 2),
                                  CoreInfoTile(
                                    coreUrl: state.coreUrl,
                                    coreVersion: state.coreVersion,
                                    progress: state.progress,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: TextButton.icon(
                  onPressed: () => _showEmbeddedLinksDialog(context, state.embeddedLinks),
                  icon: const Icon(Icons.link),
                  label: Text(
                    context.l10n.settings_AboutText_ApplicationEmbeddedLinks,
                    style: themeData.textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEmbeddedLinksDialog(BuildContext context, List<String> links) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.settings_AboutText_ApplicationEmbeddedLinks, textAlign: TextAlign.center),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: links.length,
            itemBuilder: (context, index) => CopyToClipboard(
              data: links[index],
              child: ListTile(
                title: Text(links[index], style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _onEmbeddedLinksDialogDismiss(ctx),
            child: Text(context.l10n.alertDialogActions_ok),
          ),
        ],
      ),
    );
  }

  void _onMultiTapTriggered() {
    context.router.navigate(const LogRecordsConsoleScreenPageRoute());
  }

  void _onEmbeddedLinksDialogDismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
