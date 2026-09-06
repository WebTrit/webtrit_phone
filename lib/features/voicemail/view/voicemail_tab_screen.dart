import 'package:flutter/material.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../widgets/widgets.dart';

/// Voicemail as a section of the bottom menu: the same list under the bar
/// every section carries.
///
/// The actions that manage the mailbox are not here. Clearing the media cache
/// opens a screen that lives inside settings, and emptying the mailbox is
/// destructive over everything there is; both belong where the feature is
/// managed. What is left is the delete control for messages picked by hand,
/// which shows itself only once something is picked.
class VoicemailTabScreen extends StatelessWidget {
  const VoicemailTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      // The configured bar is transparent, and the sections that have a page
      // style of their own put the tint back through appBarBlurredSurface.
      // This one has no page style, so it takes the same recipe from the
      // adaptive fallback - without it the bar reads as part of the background.
      extendBodyBehindAppBar: true,
      appBar: MainAppBar(
        title: Text(EnvironmentConfig.APP_NAME),
        context: context,
        flexibleSpace: BlurredSurface.adaptive(context),
        actions: const [VoicemailDeleteAction(offersDeleteAll: false)],
      ),
      // No inset of its own: the body runs behind the bar and Scaffold already
      // hands it a MediaQuery whose top padding is the bar plus the status bar,
      // which a list with no padding of its own takes.
      body: const VoicemailBody(),
    );
  }
}
