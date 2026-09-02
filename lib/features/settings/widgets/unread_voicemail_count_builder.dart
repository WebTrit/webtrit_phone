import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/voicemail/cubits/cubits.dart';

/// Builds its child with the number of voicemails waiting.
///
/// The count is read nullably: the badge it feeds is an ornament, so a host
/// that shows a settings row outside a session - the screenshot previews -
/// provides no counter and must get a row without a badge rather than a
/// missing-provider error. Same reasoning, and the same read, as the messaging
/// badge on the navigation bar.
class UnreadVoicemailCountBuilder extends StatelessWidget {
  const UnreadVoicemailCountBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, int unreadCount) builder;

  @override
  Widget build(BuildContext context) {
    // `watch` is enough to follow the count: BlocProvider subscribes to the
    // cubit and marks its dependents on every emission, so a BlocBuilder on
    // top of this would only subscribe a second time to the same stream.
    final unreadVoicemails = context.watch<VoicemailUnreadCubit?>();

    return builder(context, unreadVoicemails?.state ?? 0);
  }
}
