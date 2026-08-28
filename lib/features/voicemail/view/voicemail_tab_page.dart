import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';

import 'voicemail_screen_host.dart';
import 'voicemail_tab_screen.dart';

/// Route of the bottom-menu voicemail section.
@RoutePage()
class VoicemailTabPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const VoicemailTabPage();

  @override
  Widget build(BuildContext context) {
    return const VoicemailScreenHost(child: VoicemailTabScreen());
  }
}
