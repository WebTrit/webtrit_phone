import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _onMultiTapTriggered() {
    context.router.navigate(const LogRecordsConsoleScreenPageRoute());
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final localStyle = widget.style ?? themeData.extension<AboutScreenStyles>()?.primary;

    return BlocBuilder<AboutBloc, AboutState>(
      builder: (context, state) {
        final delimiterHeight = themeData.textTheme.titleLarge!.fontSize!;

        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.settings_ListViewTileTitle_about)),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConfigurableThemeImage(style: localStyle?.pictureLogoStyle, defaultScale: 0.25),
                    SizedBox(height: delimiterHeight),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(state.packageName),
                          GestureDetector(onTap: _multiTapLoggingTrigger.tap, child: Text(state.userAgent)),
                          SizedBox(height: delimiterHeight / 2),
                          CopyToClipboard(
                            data: state.appIdentifier,
                            child: Text(context.l10n.settings_AboutText_AppSessionIdentifier),
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
                          SizedBox(height: delimiterHeight / 2),
                          CopyToClipboard(
                            data: state.fcmPushToken,
                            child: Text(context.l10n.settings_AboutText_FCMPushNotificationToken),
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
                          SizedBox(height: delimiterHeight / 2),
                          CopyToClipboard(
                            data: state.coreUrl.toString(),
                            child: Text(state.coreUrl.toString(), textAlign: TextAlign.center),
                          ),
                          TextButton.icon(
                            onPressed: () => _showEmbeddedLinksDialog(context, state.embeddedLinks),
                            icon: const Icon(Icons.link),
                            label: Text(
                              context.l10n.settings_AboutText_ApplicationEmbeddedLinks,
                              style: themeData.textTheme.bodyMedium,
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Text(
                                state.progress
                                    ? ''
                                    : (state.coreVersion ?? context.l10n.settings_AboutText_CoreVersionUndefined)
                                          .toString(),
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEmbeddedLinksDialog(BuildContext context, List<String> links) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.settings_AboutText_ApplicationEmbeddedLinks),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: links.length,
            itemBuilder: (context, index) => _buildEmbeddedLinkItem(context, links[index]),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text(context.l10n.alertDialogActions_ok)),
        ],
      ),
    );
  }

  Widget _buildEmbeddedLinkItem(BuildContext context, String url) {
    return CopyToClipboard(
      data: url,
      child: ListTile(title: Text(url, style: Theme.of(context).textTheme.bodySmall)),
    );
  }
}
