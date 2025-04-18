import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/data/data.dart';

import '../../../../../data/app_preferences.dart';
import '../../../../../repositories/voicemail/voice_mail_repository.dart' show VoicemailRepository;
import '../bloc/voicemail_cubit.dart';
import 'voicemail_screen.dart';

@RoutePage()
class VoicemailScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const VoicemailScreenPage();

  @override
  Widget build(BuildContext context) {
    const widget = VoicemailScreen();
    final securetyStorage = context.read<SecureStorage>();

    final mediaHeaders = {
      'authorization': 'Bearer ${securetyStorage.readToken()}',
    };

    return BlocProvider(
      create: (context) => VoicemailCubit(context.read<VoicemailRepository>(), mediaHeaders),
      child: widget,
    );
  }
}
