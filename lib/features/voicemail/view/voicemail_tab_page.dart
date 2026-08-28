import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/environment_config.dart';

import 'voicemail_screen_host.dart';

/// Voicemail as a section of the main screen's bottom menu.
///
/// The same screen and the same dependencies as the settings sub-screen; only
/// the header differs, and the title given here is what tells the screen it is
/// a tab. See [VoicemailScreenHost].
@RoutePage()
class VoicemailTabPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const VoicemailTabPage();

  @override
  Widget build(BuildContext context) {
    return VoicemailScreenHost(title: Text(EnvironmentConfig.APP_NAME));
  }
}
