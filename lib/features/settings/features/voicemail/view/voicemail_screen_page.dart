import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';

import '../models/models.dart';
import '../utils/utils.dart';

import 'voicemail_screen.dart';

@RoutePage()
class VoicemailScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const VoicemailScreenPage();

  @override
  Widget build(BuildContext context) {
    final secureStorage = context.read<SecureStorage>();
    final appTime = context.read<AppTime>();
    final appPath = context.read<AppPath>();

    final mediaHeaders = MediaHeadersBuilder(secureStorage: secureStorage).build();

    final screenContext = VoicemailScreenContext(
      mediaCacheBasePath: appPath.mediaCacheBasePath,
      dateFormat: appTime.formatDateTime(true),
      mediaHeaders: mediaHeaders,
    );

    return Provider<VoicemailScreenContext>(create: (context) => screenContext, child: const VoicemailScreen());
  }
}
